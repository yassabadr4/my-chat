import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});


  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController groupNameController = TextEditingController();
  List<String> members = [];
  List myContacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: members.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                FireData().createGroup(groupNameController.text, members).then(
                      (value) {
                        Navigator.pop(context);
                        setState(() {
                          members = [];
                        });
                      }
                    );
              },
              label: const Text('Done'),
              icon: const Icon(Iconsax.tick_circle_copy),
            )
          : Container(),
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                      ),
                      Positioned(
                        top: 20,
                        bottom: 20,
                        right: 18,
                        left: 20,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                    child: CustomTextFormField(
                        label: 'Group Name',
                        icon: Iconsax.user_octagon_copy,
                        controller: groupNameController))
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            const Divider(),
            SizedBox(
              height: 16.h,
            ),
             Row(
              children: [
                const Text('Member'),
                const Spacer(),
                Text(members.length.toString()),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        myContacts = snapshot.data!.data()!['my_users'];
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('id',
                                    whereIn:
                                        myContacts.isEmpty ? [''] : myContacts)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<ChatUser> items = snapshot.data!.docs
                                    .map((e) => ChatUser.fromJson(e.data()))
                                    .where(
                                      (element) =>
                                          element.id !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                    )
                                    .toList()
                                  ..sort(
                                    (a, b) => a.name!.compareTo(b.name!),
                                  );
                                return ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      title: Text(items[index].name!),
                                      checkboxShape: const CircleBorder(),
                                      value: members.contains(items[index].id),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            members.add(items[index].id!);
                                          } else {
                                            members.remove(items[index].id!);
                                          }

                                        });
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        return Container();
                      }
                    }))
            // Expanded(
            //   child: ListView(
            //     children: [
            //       CheckboxListTile(
            //         title: const Text('Name'),
            //         checkboxShape: const CircleBorder(),
            //         value: true,
            //         onChanged: (value) {},
            //       ),
            //       CheckboxListTile(
            //         title: const Text('Name'),
            //         checkboxShape: const CircleBorder(),
            //         value: false,
            //         onChanged: (value) {},
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
