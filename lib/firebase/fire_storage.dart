import 'dart:io';

import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  sendImage({required File file,required String roomId,required String uid})async {
    String extension = file.path.split('.').last;
    final reference = firebaseStorage.ref().child(
        'image/$roomId/${DateTime.now().millisecondsSinceEpoch}.$extension');
   await reference.putFile(file);



    String imageUrl =await reference.getDownloadURL();
    FireData().sendMessage(uid, imageUrl, roomId, type: 'image');
  }
}
