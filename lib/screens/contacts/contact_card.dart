import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/screens/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.user,
  });

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading:user.image == '' ? const CircleAvatar() : CircleAvatar(
          backgroundImage: NetworkImage(user.image!),
        ),
        title: Text(user.name!),
        subtitle: Text(
          user.about!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () {
            List<String> members = [
              user.id!,
              FirebaseAuth.instance.currentUser!.uid
            ]..sort(
                (a, b) => a.compareTo(b),
              );
            FireData().createRoom(user.email!).then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(roomId: members.toString(), chatUser: user),
                )));
          },
          icon: const Icon(Iconsax.messages_1_copy),
        ),
      ),
    );
  }
}
