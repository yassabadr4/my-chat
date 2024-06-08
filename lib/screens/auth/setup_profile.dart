import 'package:chat_app_material3/firebase/fire_auth.dart';
import 'package:chat_app_material3/utils/colors.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SetupProfile extends StatefulWidget {
  const SetupProfile({super.key});

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Iconsax.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Please Enter Your Name',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomTextFormField(
                label: 'Name',
                controller: nameController,
                icon: Iconsax.user_copy,
              ),
              SizedBox(
                height: 16.h,
              ),
              ElevatedButton(
                onPressed: () async{
                  if (nameController.text.isNotEmpty) {
                   await FirebaseAuth.instance.currentUser!
                        .updateDisplayName(nameController.text)
                        .then((value) => FireAuth.createUser());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continue'.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
