import 'package:chat_app_material3/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = 'My Name';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
                    CircleAvatar(
                      radius: 70.r,
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: Icon(Iconsax.edit_copy),
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
                      onPressed: () {}, icon: Icon(Iconsax.edit_copy)),
                  leading: Icon(Iconsax.user_octagon_copy),
                  title: TextField(
                    controller: nameController,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'Name', border: InputBorder.none),
                  ),
                ),
              ), Card(
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {}, icon: Icon(Iconsax.information_copy)),
                  leading: Icon(Iconsax.user_octagon_copy),
                  title: TextField(
                    controller: nameController,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'About', border: InputBorder.none),
                  ),
                ),
              ),Card(
                child: ListTile(
                  leading: Icon(Iconsax.direct_copy),
                  title: Text('Email'),
                  subtitle: Text('mm@s.com'),
                ),
              ),Card(
                child: ListTile(
                  leading: Icon(Iconsax.calendar_1_copy),
                  title: Text('joined on'),
                  subtitle: Text('22-4-2024'),
                ),
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Login'.toUpperCase(),
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
