import 'dart:io';

import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorage {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  sendImage({
    required File file,
    required String roomId,
    required String uid,
    required ChatUser chatUser,
    required BuildContext context,
  }) async {
    String extension = file.path.split('.').last;
    final reference = firebaseStorage.ref().child(
        'image/$roomId/${DateTime.now().millisecondsSinceEpoch}.$extension');
    await reference.putFile(file);

    String imageUrl = await reference.getDownloadURL();
    FireData().sendMessage(
      uid,
      imageUrl,
      roomId,
      chatUser,
      context,
      type: 'image',
    );
  }



  Future updateProfileImage({required File file}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String extension = file.path.split('.').last;
    final reference = firebaseStorage.ref().child(
        'profile/$uid/${DateTime.now().millisecondsSinceEpoch}.$extension');
    await reference.putFile(file);

    String imageUrl = await reference.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'image': imageUrl});
  }
}
