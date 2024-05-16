import 'package:chat_app_material3/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatScreen(),
              ));
        },
        title: const Text('Name'),
        subtitle: const Text('Last Message'),
        leading: const CircleAvatar(),
        trailing: Badge(
          label: const Text('3'),
          largeSize: 20.sp,
        ),
      ),
    );
  }
}
