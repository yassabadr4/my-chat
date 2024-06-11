import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/utils/date_time.dart';
import 'package:chat_app_material3/utils/photo_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatMessageCard extends StatefulWidget {
  const ChatMessageCard({
    super.key,
    required this.index,
    required this.messageItem,
    required this.roomId,
    required this.isSelect,
  });

  final int index;
  final MessageModel messageItem;
  final String roomId;
  final bool isSelect;

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  @override
  void initState() {
    if (widget.messageItem.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireData().readMessage(widget.roomId, widget.messageItem.id!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMe =
        widget.messageItem.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: widget.isSelect ? Colors.grey : Colors.transparent,
      ),
      child: Row(
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
                    maxWidth: MediaQuery.sizeOf(context).width / 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.messageItem.type == 'image'
                        ? GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoViewScreen(
                                      image: widget.messageItem.message!),
                                )),
                            child: Container(
                              height: 100.h,
                              child: CachedNetworkImage(
                                imageUrl: widget.messageItem.message!,
                                placeholder: (context, url) {
                                  return Container(
                                    height: 100.h,
                                  );
                                },
                              ),
                            ),
                          )
                        : Text(widget.messageItem.message!),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isMe
                            ? Icon(
                                Iconsax.tick_circle_copy,
                                size: 16,
                                color: widget.messageItem.read == ''
                                    ? Colors.grey
                                    : Colors.blueAccent,
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          MyDateTime.timeDate(widget.messageItem.createdAt!),
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
      ),
    );
  }
}
