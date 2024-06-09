import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/group_model.dart';
import 'package:chat_app_material3/models/message_model.dart';
import 'package:chat_app_material3/screens/group/group_member.dart';
import 'package:chat_app_material3/screens/group/widgets/group_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupScreen extends StatefulWidget {
  final ChatGroup chatGroup;

  const GroupScreen({super.key, required this.chatGroup});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatGroup.name),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('id', whereIn: widget.chatGroup.members).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List memberName = [];
                    for(var element in snapshot.data!.docs){
                      memberName.add(element.data()['name']);
                    }
                    return Text(
                     memberName.join(' , '),
                      style: Theme.of(context).textTheme.labelMedium,
                    );
                  }else{
                    return Container();
                  }

                })
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  GroupMember(
                        chatGroup: widget.chatGroup,
                      ),
                    ));
              },
              icon: const Icon(Iconsax.user_square_copy)),
          // IconButton(onPressed: () {}, icon: const Icon(Iconsax.copy_copy)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('groups')
                      .doc(widget.chatGroup.id)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<MessageModel> msgs = snapshot.data!.docs
                          .map(
                            (e) => MessageModel.fromJson(e.data()),
                          )
                          .toList()
                        ..sort(
                          (a, b) => b.createdAt!.compareTo(a.createdAt!),
                        );
                      if (msgs.isEmpty) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              FireData().sendGroupMessage(
                                  'Hello 👋', widget.chatGroup.id);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: msgs.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return GroupMessageCard(
                              index: index,
                              message: msgs[index],
                            );
                          },
                        );
                      }
                    } else {
                      return Container();
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: msgController,
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
                              onPressed: () {},
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
                      if (msgController.text.isNotEmpty) {
                        FireData()
                            .sendGroupMessage(
                                msgController.text, widget.chatGroup.id)
                            .then(
                          (value) {
                            setState(() {
                              msgController.text = '';
                            });
                          },
                        );
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
