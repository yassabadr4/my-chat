import 'package:chat_app_material3/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupMessageCard extends StatelessWidget {
  const GroupMessageCard({
    super.key,
    required this.index,
    required this.message,
  });

  final int index;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    bool isMe = message.fromId == FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(message.fromId)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData ?  Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isMe ? 16.r : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 16.r),
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r)),
                ),
                color: isMe
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !isMe
                            ? Text(
                                snapshot.data!.data()!['name'],
                                style: Theme.of(context).textTheme.labelLarge,
                              )
                            : Container(),
                        const SizedBox(),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(message.message!),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isMe
                                ? const Icon(
                                    Iconsax.tick_circle_copy,
                                    size: 16,
                                    color: Colors.blueAccent,
                                  )
                                : const SizedBox(),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              message.createdAt!,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ) : Container();
        });
  }
}
