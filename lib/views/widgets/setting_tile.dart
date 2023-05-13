import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/constant.dart';
import 'package:mental_health_app/controllers/account_controller.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/models/setting.dart';
import 'package:mental_health_app/views/screens/main_screens/account_screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (setting.title == 'Personal Info') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                      user:
                          Provider.of<AccountController>(context, listen: false)
                              .userInfo!,
                    )),
          );
        } else if (setting.title == 'Logout') {
          FirebaseAuth.instance.signOut();
        }
      }, // Navigation
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: klightContentColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(setting.icon, color: kprimaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            setting.title,
            style: const TextStyle(
              color: kprimaryColor,
              fontSize: ksmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}
