import 'package:chat_app_material3/screens/group/group_member.dart';
import 'package:chat_app_material3/screens/group/widgets/group_message_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            Text(
              'member 1, member 2, member 3,...',
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupMember(),));
          }, icon: const Icon(Iconsax.user_square_copy)),
         // IconButton(onPressed: () {}, icon: const Icon(Iconsax.copy_copy)),
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
                  return GroupMessageCard(
                    index: index,
                  );
                },
              ),
              // child: Center(
              //   child: GestureDetector(
              //     child: Card(
              //       child: Padding(
              //         padding: const EdgeInsets.all(12.0),
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               '👋',
              //               style: Theme.of(context).textTheme.displayMedium,
              //             ),
              //             SizedBox(height: 16.h,),
              //             Text(
              //               'Say Hello',
              //               style: Theme.of(context).textTheme.bodyLarge,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
