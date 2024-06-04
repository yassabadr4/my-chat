import 'package:chat_app_material3/models/room_model.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/screens/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCard extends StatelessWidget {
  final ChatRoom item;

  const ChatCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    String userId = item.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .first;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatUser chatUser = ChatUser.fromJson(snapshot.data!.data()!);
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          roomId: item.id!,
                          chatUser: chatUser,
                        ),
                      ));
                },
                title: Text(chatUser.name!),
                subtitle: Text(item.lastMessage! == ''
                    ? chatUser.about!
                    : item.lastMessage!),
                leading: const CircleAvatar(),
                trailing: 1 / 1 != 0
                    ? Badge(
                        label: Text('3'),
                        largeSize: 20.sp,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      )
                    : Text(''),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
