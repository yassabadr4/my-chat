import 'dart:io';

import 'package:chat_app_material3/firebase/fire_database.dart';
import 'package:chat_app_material3/firebase/fire_storage.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  ChatUser? me;
  String _img = '';
 bool nameEdit = false;
 bool aboutEdit = false;
  @override
  void initState() {
    me = Provider.of<ProviderApp>(context, listen: false).me;
    nameController.text = me!.name!;
    aboutController.text = me!.about!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _img == ''
                        ? me!.image == ''
                            ? CircleAvatar(
                                radius: 70.r,
                              )
                            : CircleAvatar(
                     radius: 70.r,backgroundImage: NetworkImage(me!.image!),
                    )
                        : CircleAvatar(
                            radius: 70.r,
                            backgroundImage: FileImage(File(_img)),
                          ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton.filled(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _img = image.path;
                            });
                            FireStorage()
                                .updateProfileImage(file: File(image.path));
                          }
                        },
                        icon: const Icon(Iconsax.edit_copy),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Card(
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          nameEdit = true;
                        });
                      }, icon: const Icon(Iconsax.edit_copy)),
                  leading: const Icon(Iconsax.user_octagon_copy),
                  title: TextField(
                    controller: nameController,
                    enabled: nameEdit,
                    decoration: const InputDecoration(
                        labelText: 'Name', border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          aboutEdit = true;
                        });
                      }, icon: const Icon(Iconsax.information_copy)),
                  leading: const Icon(Iconsax.user_octagon_copy),
                  title: TextField(
                    controller: aboutController,
                    enabled: aboutEdit,
                    decoration: const InputDecoration(
                        labelText: 'About', border: InputBorder.none),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Iconsax.direct_copy),
                  title: const Text('Email'),
                  subtitle: Text(me!.email.toString()),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Iconsax.calendar_1_copy),
                  title: const Text('joined on'),
                  subtitle: Text(me!.createdAt.toString()),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  if(nameController.text.isNotEmpty && aboutController.text.isNotEmpty){
                    FireData().editProfile(nameController.text, aboutController.text).then((value) {
                      setState(() {
                        nameEdit = false;
                        aboutEdit = false;
                      });
                    },);
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Save'.toUpperCase(),
                    // style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
