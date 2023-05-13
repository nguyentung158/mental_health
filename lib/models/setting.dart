import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Personal Info",
    route: "/",
    icon: CupertinoIcons.person_fill,
  ),
  Setting(
    title: "Settings",
    route: "/",
    icon: Icons.settings,
  ),
  Setting(
    title: "E-Statements",
    route: "/",
    icon: CupertinoIcons.doc_fill,
  ),
  Setting(
    title: "Security",
    route: "/",
    icon: CupertinoIcons.lock_shield,
  ),
];

final List<Setting> settings2 = [
  Setting(
    title: "FAQ",
    route: "/",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
  ),
  Setting(
    title: "Our Handbook",
    route: "/",
    icon: CupertinoIcons.pencil_circle_fill,
  ),
  Setting(
    title: "Community",
    route: "/",
    icon: CupertinoIcons.person_3_fill,
  ),
];

final List<Setting> settings3 = [
  Setting(
    title: "Logout",
    route: "/",
    icon: Icons.logout,
  ),
];
