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

  Future sendMessage(String uid, String msg, String roomId)async {
    String msgId = Uuid().v1();
    MessageModel messageModel = MessageModel(
      id: msgId,
      toId: uid,
      fromId: myUserId,
      message: msg,
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
      type: 'text',
    );
    await firebaseFirestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(messageModel.toJson());
  }
}
