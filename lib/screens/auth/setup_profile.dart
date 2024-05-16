import 'package:chat_app_material3/screens/auth/login_screen.dart';
import 'package:chat_app_material3/utils/colors.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
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
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
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
                'Create Account and Let\'s Chat',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
               SizedBox(
                height: 16.h,
              ),
              Text(
                'Please Enter Your Name',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomTextFormField(
                label: 'Name',
                controller: emailController,
                icon: Iconsax.user_copy,
              ),
               SizedBox(
                height: 16.h,
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Send Email'.toUpperCase(),
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
