import 'package:chat_app_material3/provider/provider.dart';
import 'package:chat_app_material3/screens/settings/profile.dart';
import 'package:chat_app_material3/screens/settings/qr_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class SettingHomeScreen extends StatefulWidget {
  const SettingHomeScreen({super.key});

  @override
  State<SettingHomeScreen> createState() => _SettingHomeScreenState();
}

class _SettingHomeScreenState extends State<SettingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProviderApp>(context);
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
                leading: prov.me!.image == '' ?  CircleAvatar(
                  radius: 30.r,
                ) : CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(prov.me!.image!),
                ),
                minVerticalPadding: 40,
                title: Text(prov.me!.name.toString()),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QrCode(),
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
                          builder: (context) => const ProfileScreen(),
                        ));
                  },
                  title: const Text('Profile'),
                  leading: const Icon(Iconsax.user_copy),
                  trailing: const Icon(Iconsax.arrow_right_3_copy),
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
                              pickerColor: Color(prov.mainColor),
                              onColorChanged: (value) {
                                print(value.value.toRadixString(16));
                                prov.changeColor(value.value);
                              },
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Done'))
                          ],
                        );
                      },
                    );
                  },
                  title: const Text('Theme'),
                  leading: const Icon(Iconsax.colorfilter_copy),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Dark Mode'),
                  leading: const Icon(Iconsax.user_copy),
                  trailing: Switch(
                      value: prov.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        prov.changeMode(value);
                      }),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  title: const Text('Sign-Out'),
                  trailing: const Icon(Iconsax.logout_1_copy),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
