import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';
import 'package:mental_health_app/models/user.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({super.key});

  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {
  int _curruntIndex = 0;
  @override
  Widget build(BuildContext context) {
    return !User.isDoctor
        ? Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _curruntIndex,
              onTap: (value) {
                if (value == 2) {}
                setState(() {
                  _curruntIndex = value;
                });
              },
              backgroundColor: _curruntIndex == 2
                  ? const Color.fromRGBO(3, 23, 77, 1)
                  : null,
              unselectedItemColor: _curruntIndex == 2
                  ? const Color.fromRGBO(152, 161, 189, 1)
                  : null,
              selectedItemColor: _curruntIndex == 2
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/nav_icons/meditate.png')),
                    label: 'Meditate'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/nav_icons/moon.png')),
                    label: 'Musics'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/nav_icons/profile.png')),
                    label: 'Account'),
              ],
            ),
            body: IndexedStack(
              index: _curruntIndex,
              children: pages,
            ),
          )
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _curruntIndex,
              onTap: (value) {
                setState(() {
                  _curruntIndex = value;
                });
              },
              backgroundColor: _curruntIndex == 2
                  ? const Color.fromRGBO(3, 23, 77, 1)
                  : null,
              unselectedItemColor: _curruntIndex == 2
                  ? const Color.fromRGBO(152, 161, 189, 1)
                  : null,
              selectedItemColor: _curruntIndex == 2
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today), label: 'Schedule'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                        AssetImage('assets/images/nav_icons/profile.png')),
                    label: 'Account'),
              ],
            ),
            body: doctorPages[_curruntIndex],
          );
  }
}
