import 'package:chat_app_material3/screens/settings/profile.dart';
import 'package:chat_app_material3/screens/settings/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingHomeScreen extends StatefulWidget {
  const SettingHomeScreen({super.key});

  @override
  State<SettingHomeScreen> createState() => _SettingHomeScreenState();
}

class _SettingHomeScreenState extends State<SettingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30.r,
                ),
                minVerticalPadding: 40,
                title: const Text('Name'),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrCode(),
                          ));
                    },
                    icon: const Icon(Iconsax.scan_barcode_copy)),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ));
                  },
                  title: Text('Profile'),
                  leading: Icon(Iconsax.user_copy),
                  trailing: Icon(Iconsax.arrow_right_3_copy),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: Colors.green,
                              onColorChanged: (value) {},
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Done'))
                          ],
                        );
                      },
                    );
                  },
                  title: Text('Theme'),
                  leading: Icon(Iconsax.colorfilter_copy),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Dark Mode'),
                  leading: const Icon(Iconsax.user_copy),
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  title: Text('Sign-Out'),
                  trailing: Icon(Iconsax.logout_1_copy),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
