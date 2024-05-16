import 'package:chat_app_material3/utils/colors.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:chat_app_material3/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
               SizedBox(
                height: 20.h,
              ),
              Text(
                'please Enter Your Email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomTextFormField(
                label: 'Email',
                controller: emailController,
                icon: Iconsax.direct,
              ),
               SizedBox(
                height: 16.h,
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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