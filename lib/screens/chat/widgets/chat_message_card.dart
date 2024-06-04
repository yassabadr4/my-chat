import 'package:chat_app_material3/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.index,
    required this.messageItem,
  });

  final int index;
  final MessageModel messageItem;

  @override
  Widget build(BuildContext context) {
    bool isMe = messageItem.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.message_edit_copy))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16),
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
                  Text(messageItem.message!),
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
                        DateFormat.yMMMEd()
                            .format(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageItem.createdAt!)))
                            .toString(),
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
    );
  }
}
