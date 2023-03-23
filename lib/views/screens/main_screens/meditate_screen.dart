import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/musics_controller.dart';
import 'package:provider/provider.dart';

class MeditateScreen extends StatelessWidget {
  const MeditateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Provider.of<MusicsController>(context, listen: false)
            .getAllSongs();
      }),
    );
  }
}
