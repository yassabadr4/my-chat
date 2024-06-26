import 'package:chat_app_material3/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static User user = auth.currentUser!;

  static Future createUser() async {
    ChatUser chatUser = ChatUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
      pushToken: '',
      about: 'Hello i\'m User on the Chat',
      image: '',
      online: false,
      myUsers: [],
    );
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  Future updateToken(String token) async {
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update({'push_token': token});
  }

  Future updateActivate(bool online)async{
    firebaseFirestore.collection('users').doc(user.uid).update({
      'online' : online,
      'last_activated' : DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }
}





/// class
/// firebase auth
/// firebase store cloud store
/// object User from firebase auth
/// method from my model
/// await firebaseFirestore.collection('users').doc(user.uid).set(chatUser.toJson());

/// to open collection ^^^
/// finally in login to create collection in fire store
