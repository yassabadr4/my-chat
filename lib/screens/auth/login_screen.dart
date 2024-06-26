import 'package:chat_app_material3/screens/auth/forget_password_screen.dart';
import 'package:chat_app_material3/utils/colors.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:chat_app_material3/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              Text(
                'Welcom Back',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Let\'s Chat :)',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Email',
                      controller: emailController,
                      icon: Iconsax.direct,
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      controller: passwordController,
                      icon: Iconsax.password_check,
                      isPass: true,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgetPasswordScreen(),
                                  ));
                            },
                            child: const Text('Forget Password?')),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text).then((value) =>
                              print('login done')).onError(
                                (error, stackTrace) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Check Email and Password'
                                    ),
                                  ),
                                ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Login'.toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () async {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SetupProfile(),
                        //     ),
                        //     (route) => false);
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                            .then((value) => print('ok'))
                            .onError(
                              (error, stackTrace) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    error.toString(),
                                  ),
                                ),
                              ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Create account'.toUpperCase(),
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onSurface),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
