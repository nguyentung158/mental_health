import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/account_controller.dart';
import 'package:mental_health_app/models/setting.dart';
import 'package:mental_health_app/views/widgets/avatar_card.dart';
import 'package:mental_health_app/views/widgets/setting_tile.dart';
import 'package:mental_health_app/views/widgets/support_card.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 14),
        child: FutureBuilder<bool>(
            future: Provider.of<AccountController>(context, listen: false)
                .fetchAndSetAccount(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Consumer<AccountController>(
                builder: (context, value, child) => Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvatarCard(
                          email: value.userInfo!.email,
                          imageUrl: value.userInfo!.profilePhoto,
                          name: value.userInfo!.name,
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            settings.length,
                            (index) => SettingTile(setting: settings[index]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            settings2.length,
                            (index) => SettingTile(setting: settings2[index]),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            settings3.length,
                            (index) => SettingTile(setting: settings3[index]),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SupportCard()
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
