import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/models/room_model.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/screens/chat/chat_screen.dart';
import 'package:chat_app_material3/utils/date_time.dart';
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
    List members = item.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid).toList();
    String userId = members.isEmpty ?  FirebaseAuth.instance.currentUser!.uid : members.first;
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
                      : item.lastMessage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: chatUser.image == '' ? const CircleAvatar(
                  ) : CircleAvatar(
                    backgroundImage: NetworkImage(chatUser.image!),
                  ),
                  trailing: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('rooms')
                        .doc(item.id)
                        .collection('messages')
                        .snapshots(),
                    builder: (context, snapshot) {
                      final unReadList = snapshot.data?.docs
                          .map((e) => MessageModel.fromJson(e.data()))
                          .where((element) => element.read == '')
                          .where((element) =>
                              element.fromId !=
                              FirebaseAuth.instance.currentUser!.uid) ??[];
                      return unReadList.isNotEmpty
                          ? Badge(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              label: Text(unReadList.length.toString()),
                              largeSize: 20.sp,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                            )
                          : Text(MyDateTime.dateAndTime(item.lastMessageTime!).toString());
                    },
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}
