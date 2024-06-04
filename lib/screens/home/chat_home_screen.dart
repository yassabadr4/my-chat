import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/room_model.dart';
import 'package:chat_app_material3/screens/chat/widgets/chat_card.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.minus_copy,
                      size: 60.sp,
                    ),
                    Row(
                      children: [
                        Text(
                          'Enter Friend Email',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(Iconsax.scan_barcode_copy))
                      ],
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      icon: Iconsax.direct_copy,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          FireData()
                              .createRoom(emailController.text)
                              .then((value) {
                            setState(() {
                              emailController.text = '';
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: const Center(
                        child: Text('Create Chat'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.message_add_1_copy),
      ),
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .where('members',
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChatRoom> items = snapshot.data!.docs
                          .map((e) => ChatRoom.fromJson(e.data()))
                          .toList()
                        ..sort(
                          (a, b) =>
                              b.lastMessageTime!.compareTo(a.lastMessageTime!),
                        );
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ChatCard(item: items[index],);
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
