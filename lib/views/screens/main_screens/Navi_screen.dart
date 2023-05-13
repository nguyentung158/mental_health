import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';
import 'package:mental_health_app/views/screens/main_screens/account_screens/setting_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/home_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/doctor_screens/messages_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/musics_screens/musics_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/account_screens/edit_profile_screen.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({super.key});

  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {
  int _curruntIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curruntIndex,
        onTap: (value) {
          if (value == 3) {}
          setState(() {
            _curruntIndex = value;
          });
        },
        backgroundColor:
            _curruntIndex == 3 ? const Color.fromRGBO(3, 23, 77, 1) : null,
        unselectedItemColor:
            _curruntIndex == 3 ? const Color.fromRGBO(152, 161, 189, 1) : null,
        selectedItemColor: _curruntIndex == 3
            ? Colors.white
            : Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_rounded),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage('assets/images/nav_icons/meditate.png')),
              label: 'Meditate'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/nav_icons/moon.png')),
              label: 'Musics'),
          BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage('assets/images/nav_icons/profile.png')),
              label: 'Account'),
        ],
      ),
      body: IndexedStack(
        index: _curruntIndex,
        children: pages,
      ),
    );
  }
}
