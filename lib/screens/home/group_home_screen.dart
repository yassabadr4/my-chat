import 'package:chat_app_material3/screens/group/create_group.dart';
import 'package:chat_app_material3/screens/group/widgets/group_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupHomeScreen extends StatefulWidget {
  const GroupHomeScreen({super.key});

  @override
  State<GroupHomeScreen> createState() => _GroupHomeScreenState();
}

class _GroupHomeScreenState extends State<GroupHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateGroup();
          },));
        },
        child: const Icon(Iconsax.message_add_copy),
      ),
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const GroupCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
