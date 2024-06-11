import 'package:chat_app_material3/models/group_model.dart';
import 'package:chat_app_material3/screens/group/group_screen.dart';
import 'package:flutter/material.dart';

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
                builder: (context) =>  GroupScreen(chatGroup: chatGroup,roomId: chatGroup.id,),
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
        leading: chatGroup.image == '' ?  CircleAvatar(
          child: Text(chatGroup.name.characters.first),
        ) : CircleAvatar(backgroundImage: NetworkImage(chatGroup.image),),
        trailing: Text(chatGroup.lastMessageTime),
      ),
    );
  }
}
