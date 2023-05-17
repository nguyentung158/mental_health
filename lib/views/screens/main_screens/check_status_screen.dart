import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/auth_controller.dart';
import 'package:mental_health_app/controllers/schedule_controller.dart';
import 'package:mental_health_app/models/user.dart';
import 'package:mental_health_app/views/screens/main_screens/navi_screen.dart';
import 'package:provider/provider.dart';

class CheckStatusScreen extends StatelessWidget {
  const CheckStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (User.isDoctor) {
            return FutureBuilder(
              future: Provider.of<ScheduleController>(context, listen: false)
                  .fetchAndSetData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const NaviScreen();
              },
            );
          }
          return const NaviScreen();
        },
        future:
            Provider.of<AuthController>(context, listen: false).checkDoctor(),
      ),
    );
  }
}
