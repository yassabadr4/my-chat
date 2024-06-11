import 'package:chat_app_material3/firebase_options.dart';
import 'package:chat_app_material3/provider/provider.dart';
import 'package:chat_app_material3/screens/auth/login_screen.dart';
import 'package:chat_app_material3/screens/auth/setup_profile.dart';
import 'package:chat_app_material3/widgets/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ProviderApp(),
        child: Consumer<ProviderApp>(
          builder: (context, value, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(value.mainColor), brightness: Brightness.light),
              useMaterial3: true,
            ),
            themeMode: value.themeMode,
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(value.mainColor), brightness: Brightness.dark),
            ),
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (FirebaseAuth.instance.currentUser!.displayName == '' ||
                      FirebaseAuth.instance.currentUser!.displayName == null) {
                    return const SetupProfile();
                  } else {
                    return const LayoutApp();
                  }
                } else {
                  return const LoginScreen();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
