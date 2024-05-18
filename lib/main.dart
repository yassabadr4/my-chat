import 'package:chat_app_material3/screens/auth/login_screen.dart';
import 'package:chat_app_material3/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
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
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo,brightness: Brightness.light),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green,brightness: Brightness.dark),
        ),
        debugShowCheckedModeBanner: false,
        home: LayoutApp(),
      ),
    );
  }
}
