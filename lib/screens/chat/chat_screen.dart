import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            Text(
              'Last Seen 11:00 am',
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.trash_copy)),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.copy_copy)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                       index %2 == 0 ? IconButton(onPressed: (){}, icon: Icon(Iconsax.message_edit_copy)) :SizedBox() ,
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(index % 2 == 0 ? 16 : 0),
                                bottomRight:
                                    Radius.circular(index % 2 == 0 ? 0 : 16),
                                topRight: Radius.circular(16.r),
                                topLeft: Radius.circular(16.r)),
                          ),
                          color: index % 2 == 0
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width / 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('Message uhfvytkuf'),
                                  Row(
                                    children: [
                                      Text(
                                        '04:03 pm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      index % 2 == 0
                                          ? Icon(
                                              Iconsax.tick_circle_copy,
                                              size: 16,
                                        color: Colors.blueAccent,
                                            )
                                          : SizedBox(),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
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
                    onPressed: () {}, icon: const Icon(Iconsax.send_1_copy))
              ],
            )
          ],
        ),
      ),
    );
  }
}
