import 'package:chat_app_material3/screens/chat/widgets/chat_card.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
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
                    const Icon(
                      Iconsax.minus_copy,
                      size: 60,
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
                    SizedBox(height: 16.h,),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer
                      ),
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
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ChatCard();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
