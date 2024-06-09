import 'package:chat_app_material3/models/group_model.dart';
import 'package:chat_app_material3/screens/group/group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.chatGroup,
  });

  final ChatGroup chatGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  GroupScreen(chatGroup: chatGroup,),
              ));
        },
        title: Text(chatGroup.name),
        subtitle: Text(
          chatGroup.lastMessage == ''
              ? 'Send First Message'
              : chatGroup.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: CircleAvatar(
          child: Text(chatGroup.name.characters.first),
        ),
        trailing: Text(chatGroup.lastMessageTime),
      ),
    );
  }
}
