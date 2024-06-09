import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/group_model.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/screens/group/group_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupMember extends StatefulWidget {
  final ChatGroup chatGroup;

  const GroupMember({super.key, required this.chatGroup});

  @override
  State<GroupMember> createState() => _GroupMemberState();
}

class _GroupMemberState extends State<GroupMember> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin =
        widget.chatGroup.admin.contains(FirebaseAuth.instance.currentUser!.uid);
    String myId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Members'),
        centerTitle: true,
        actions: [
          isAdmin
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupEdit(
                            chatGroup: widget.chatGroup,
                          ),
                        ));
                  },
                  icon: Icon(Iconsax.user_edit_copy),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('id', whereIn: widget.chatGroup.members)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChatUser> userList = snapshot.data!.docs
                          .map(
                            (e) => ChatUser.fromJson(e.data()),
                          )
                          .toList();
                      return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          bool admin = widget.chatGroup.admin
                              .contains(userList[index].id);
                          return ListTile(
                            title: Text(userList[index].name!),
                            subtitle: admin
                                ? const Text(
                                    'Admin',
                                    style: TextStyle(color: Colors.green),
                                  )
                                : const Text('member'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isAdmin && myId != userList[index].id
                                    ? IconButton(
                                        onPressed: () {
                                          admin
                                              ? FireData().removeAdmin(
                                                  widget.chatGroup.id,
                                                  userList[index].id!).then((value) {
                                                    setState(() {
                                                      widget.chatGroup.admin.remove(userList[index].id!);
                                                    });
                                                  },)
                                              : FireData().promptAdmin(
                                                  widget.chatGroup.id,
                                                  userList[index].id!).then((value) {
                                            setState(() {
                                              widget.chatGroup.admin.add(userList[index].id!);
                                            });
                                          },);
                                        },
                                        icon: Icon(Iconsax.user_tick_copy),
                                      )
                                    : Container(),
                                isAdmin && myId != userList[index].id
                                    ? IconButton(
                                        onPressed: () {
                                          FireData()
                                              .removeMember(widget.chatGroup.id,
                                                  userList[index].id!)
                                              .then(
                                            (value) {
                                              setState(() {
                                                widget.chatGroup.members.remove(
                                                    userList[index].id!);
                                              });
                                            },
                                          );
                                        },
                                        icon: Icon(Iconsax.trash_copy),
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
