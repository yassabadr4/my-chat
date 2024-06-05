import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String myUserId = FirebaseAuth.instance.currentUser!.uid;

  Future createRoom(String email) async {
    QuerySnapshot userEmail = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myUserId, userId]
        ..sort(
              (a, b) => a.compareTo(b),
        );

      QuerySnapshot roomExist = await firebaseFirestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();
      if (roomExist.docs.isEmpty) {
        ChatRoom chatRoom = ChatRoom(
          id: members.toString(),
          createdAt: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          members: members,
          lastMessage: '',
          lastMessageTime: DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
        );

        await firebaseFirestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoom.toJson());
      }
    }
  }

  Future addContact(String email) async {
    QuerySnapshot userEmail = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      firebaseFirestore.collection('users').doc(myUserId).update(
          {'my_users': FieldValue.arrayUnion([userId])});
    }
  }

    Future sendMessage(String uid, String msg, String roomId,
        {String? type}) async {
      String msgId = Uuid().v1();
      MessageModel messageModel = MessageModel(
        id: msgId,
        toId: uid,
        fromId: myUserId,
        message: msg,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        read: '',
        type: type ?? 'text',
      );
      await firebaseFirestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(msgId)
          .set(messageModel.toJson());

      firebaseFirestore.collection('rooms').doc(roomId).update({
        'last_message': type ?? msg,
        'last_message_time': DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
      });
    }

    Future readMessage(String roomId, String messageId) async {
      await firebaseFirestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(messageId)
          .update({'read': DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()});
    }

    deleteMessage(String roomId, List<String> messages) async {
      for (var element in messages) {
        await firebaseFirestore
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(element).delete();
      }
    }

  }
