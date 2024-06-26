import 'dart:convert';
import 'package:chat_app_material3/models/group_model.dart';
import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/models/room_model.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FireData {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String myUserId = FirebaseAuth.instance.currentUser!.uid;
  String now = DateTime.now().millisecondsSinceEpoch.toString();

  Future createRoom(String email) async {
    QuerySnapshot userEmail = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myUserId, userId]..sort(
          (a, b) => a.compareTo(b),
        );

      QuerySnapshot roomExist = await firebaseFirestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();
      if (roomExist.docs.isEmpty) {
        ChatRoom chatRoom = ChatRoom(
          id: members.toString(),
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          members: members,
          lastMessage: '',
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await firebaseFirestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoom.toJson());
      }
    }
  }

  Future createGroup(String name, List members) async {
    String gId = const Uuid().v1();
    members.add(myUserId);
    ChatGroup chatGroup = ChatGroup(
      id: gId,
      name: name,
      image: '',
      admin: [myUserId],
      createdAt: now,
      members: members,
      lastMessage: '',
      lastMessageTime: now,
    );
    await firebaseFirestore
        .collection('groups')
        .doc(gId)
        .set(chatGroup.toJson());
  }

  Future addContact(String email) async {
    QuerySnapshot userEmail = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      firebaseFirestore.collection('users').doc(myUserId).update({
        'my_users': FieldValue.arrayUnion([userId])
      });
    }
  }

  Future sendMessage( String uid, String msg, String roomId, ChatUser chatUser,
      BuildContext context,
      {String? type}) async {
    String msgId = const Uuid().v1();
    MessageModel messageModel = MessageModel(
      id: msgId,
      toId: uid,
      fromId: myUserId,
      message: msg,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
      type: type ?? 'text',
    );
    await firebaseFirestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(messageModel.toJson())
        .then(
          (value) => sendNotification(
              chatUser: chatUser, context: context, message: type ?? msg),
        );

    await firebaseFirestore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future sendGroupMessage(
      String msg, String groupId, BuildContext context, ChatGroup chatGroup,
      {String? type}) async {
    List<ChatUser> chatUsers = [];
    chatGroup.members = chatGroup.members
        .where(
          (element) => element != myUserId,
        )
        .toList();
    firebaseFirestore
        .collection('users')
        .where('id', whereIn: chatGroup.members)
        .get()
        .then(
          (value) => chatUsers.addAll(value.docs.map(
            (e) => ChatUser.fromJson(e.data()),
          )),
        );
    String msgId = const Uuid().v1();
    MessageModel messageModel = MessageModel(
      id: msgId,
      toId: '',
      fromId: myUserId,
      message: msg,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
      type: type ?? 'text',
    );
    await firebaseFirestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(msgId)
        .set(messageModel.toJson())
        .then(
          (value) {
            for(var element in chatUsers){
              sendNotification(
                  chatUser: element, context: context, message: type ?? msg, groupName: chatGroup.name);
            }
          }
        );

    await firebaseFirestore.collection('groups').doc(groupId).update({
      'last_message': type ?? msg,
      'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future readMessage(String roomId, String messageId) async {
    await firebaseFirestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  deleteMessage(String roomId, List<String> messages) async {
    if (messages.length == 1) {
      await firebaseFirestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(messages.first)
          .delete();
    } else {
      for (var element in messages) {
        await firebaseFirestore
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(element)
            .delete();
      }
    }
  }

  Future editGroup(String gId, String name, List members) async {
    await firebaseFirestore
        .collection('groups')
        .doc(gId)
        .update({'name': name, 'members': FieldValue.arrayUnion(members)});
  }

  Future removeMember(String gId, String memberId) async {
    await firebaseFirestore.collection('groups').doc(gId).update({
      'members': FieldValue.arrayRemove([memberId])
    });
  }

  Future promptAdmin(String gId, String memberId) async {
    await firebaseFirestore.collection('groups').doc(gId).update({
      'admins_id': FieldValue.arrayUnion([memberId])
    });
  }

  Future removeAdmin(String gId, String memberId) async {
    await firebaseFirestore.collection('groups').doc(gId).update({
      'admins_id': FieldValue.arrayRemove([memberId])
    });
  }

  Future editProfile(String name, String about) async {
    await firebaseFirestore
        .collection('users')
        .doc(myUserId)
        .update({'name': name, 'about': about});
  }

  sendNotification(
      {required ChatUser chatUser,
      required BuildContext context,
      required String message,
      String? groupName
      }) async {
    final header = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=fU82JcCeRMiQ6rdwWyJD22:APA91bEk1tmrFIeKGmgeSXg3iCcqmJcgkob2JiicadGZMBE1JE-YTBTuJAlldQN0PeiBKCwXunmFlmH9Na4HFTIUgZOtYdAs6D7dwsS5mWzvUalv7u0yx9xg_ZyLCi3Q94fOw7UlT8Ti',
    };
    final body = {
      'to': chatUser.pushToken,
      'notification': {
        "title": groupName == null ? Provider.of<ProviderApp>(context, listen: false).me!.name : '$groupName : ${Provider.of<ProviderApp>(context, listen: false).me!.name}',
        "body": message,
      }
    };
    final req = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(body),
        headers: header);
  }
}
