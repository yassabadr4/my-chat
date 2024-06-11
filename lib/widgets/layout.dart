import 'package:chat_app_material3/firebase/fire_auth.dart';
import 'package:chat_app_material3/models/user_model.dart';
import 'package:chat_app_material3/provider/provider.dart';
import 'package:chat_app_material3/screens/home/chat_home_screen.dart';
import 'package:chat_app_material3/screens/home/contact_home_screen.dart';
import 'package:chat_app_material3/screens/home/group_home_screen.dart';
import 'package:chat_app_material3/screens/home/setting_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class LayoutApp extends StatefulWidget {
  const LayoutApp({super.key});

  @override
  State<LayoutApp> createState() => _LayoutAppState();
}

class _LayoutAppState extends State<LayoutApp> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  @override
  void initState() {
    Provider.of<ProviderApp>(context,listen: false).getValuesPref();
    Provider.of<ProviderApp>(context,listen: false).getUserDetails();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if(message.toString() == 'AppLifecycleState.resumed'){
        FireAuth().updateActivate(true);
      }else if(message.toString() == 'AppLifecycleState.paused' || message.toString() == 'AppLifecycleState.inactive'){
        FireAuth().updateActivate(false);
      }
      return Future.value(message);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ChatUser? me =  Provider.of<ProviderApp>(context).me;
    return Scaffold(
      body: me == null ? const Center(child: CircularProgressIndicator(),) : PageView(
        onPageChanged:(value){
          setState(() {
            currentIndex = value;
          });
        },
        controller: pageController,
        children: const [
          ChatHomeScreen(),
          GroupHomeScreen(),
          ContactHomeScreen(),
          SettingHomeScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value){
          currentIndex = value;
          setState(() {
            pageController.jumpToPage(value);
          });
        },
        elevation: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Chats'),
          NavigationDestination(icon: Icon(Iconsax.messages), label: 'Groups'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Contacts'),
          NavigationDestination(icon: Icon(Iconsax.setting), label: 'Settings'),
        ],
      ),
    );
  }
}
