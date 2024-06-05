import 'dart:io';

import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/firebase/fire_storage.dart';
import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/screens/chat/widgets/chat_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final ChatUser chatUser;

  const ChatScreen({super.key, required this.roomId, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> selectedMessage = [];
  List<String> copyMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatUser.name!),
            Text(
              widget.chatUser.lastActivated!,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        actions: [
          selectedMessage.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    FireData().deleteMessage(widget.roomId, selectedMessage);
                    setState(() {
                      selectedMessage.clear();
                      copyMessages.clear();
                    });
                  },
                  icon: const Icon(Iconsax.trash_copy),
                )
              : Container(),
          copyMessages.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: copyMessages.join('\n')));
                   setState(() {
                     copyMessages.clear();
                     selectedMessage.clear();
                   });
                  },
                  icon: const Icon(Iconsax.copy_copy))
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .doc(widget.roomId)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MessageModel> messageItems = snapshot.data!.docs
                          .map((e) => MessageModel.fromJson(e.data()))
                          .toList()
                        ..sort(
                          (a, b) => b.createdAt!.compareTo(a.createdAt!),
                        );
                      return messageItems.isNotEmpty
                          ? ListView.builder(
                              itemCount: messageItems.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMessage.isNotEmpty
                                          ? selectedMessage.contains(
                                                  messageItems[index].id)
                                              ? selectedMessage.remove(
                                                  messageItems[index].id)
                                              : selectedMessage
                                                  .add(messageItems[index].id!)
                                          : null;
                                      copyMessages.isNotEmpty
                                          ? messageItems[index].type == 'text'
                                              ? copyMessages.contains(
                                                      messageItems[index]
                                                          .message)
                                                  ? copyMessages.remove(
                                                      messageItems[index]
                                                          .message!)
                                                  : copyMessages.add(
                                                      messageItems[index]
                                                          .message!)
                                              : null
                                          : null;
                                      print(copyMessages);
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedMessage
                                              .contains(messageItems[index].id)
                                          ? selectedMessage
                                              .remove(messageItems[index].id)
                                          : selectedMessage
                                              .add(messageItems[index].id!);
                                      messageItems[index].type == 'text'
                                          ? copyMessages.contains(
                                                  messageItems[index].message)
                                              ? copyMessages.remove(
                                                  messageItems[index].message!)
                                              : copyMessages.add(
                                                  messageItems[index].message!)
                                          : null;

                                      print(copyMessages);
                                    });
                                  },
                                  child: ChatMessageCard(
                                    isSelect: selectedMessage
                                        .contains(messageItems[index].id),
                                    roomId: widget.roomId,
                                    messageItem: messageItems[index],
                                    index: index,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  FireData().sendMessage(widget.chatUser.id!,
                                      'Hello 👋 ', widget.roomId);
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '👋',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Text(
                                          'Say Hello',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }
                    return Container();
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.emoji_happy_copy,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  FireStorage().sendImage(
                                      file: File(image.path),
                                      roomId: widget.roomId,
                                      uid: widget.chatUser.id!);
                                }
                              },
                              icon: const Icon(
                                Iconsax.camera_copy,
                              ),
                            ),
                          ],
                        ),
                        hintText: 'Message',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),
                ),
                IconButton.filled(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        FireData()
                            .sendMessage(widget.chatUser.id!,
                                messageController.text, widget.roomId)
                            .then((value) {
                          setState(() {
                            messageController.text = '';
                          });
                        });
                      }
                    },
                    icon: const Icon(Iconsax.send_1_copy))
              ],
            )
          ],
        ),
      ),
    );
  }
}
