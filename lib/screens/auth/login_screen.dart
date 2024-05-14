import 'package:chat_app_material3/utils/colors.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:chat_app_material3/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Let\'s Chat :)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () {}, child: const Text('Forget Password?')),
                ],
              ),
              const SizedBox(
                height: 16,
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
                    'Login'.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () {},
                child: Center(
                  child: Text(
                    'Create account'.toUpperCase(),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
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
