import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';

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
          setState(() {
            _curruntIndex = value;
          });
        },
        unselectedLabelStyle: const TextStyle(color: Colors.black38),
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.primary),
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
              label: 'Profile'),
        ],
      ),
      body: pages[_curruntIndex],
    );
  }
}
