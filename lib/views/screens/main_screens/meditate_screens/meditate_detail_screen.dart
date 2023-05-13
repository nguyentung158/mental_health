import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/models/meditation_ex.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_player_screen.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';

class MeditateDetailScreen extends StatelessWidget {
  final CollectionReference reference;
  final MeditationEx meditationEx;
  const MeditateDetailScreen(
      {super.key, required this.reference, required this.meditationEx});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(meditationEx.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Introduction',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                meditationEx.duration,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                meditationEx.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 17),
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MeditatePlayerScreen(
                          reference: reference,
                          meditationEx: meditationEx,
                        )),
              );
            },
            child: const AuthButton(
              title: 'Start',
              color: Colors.white,
              backGroundColor: Color.fromRGBO(24, 34, 58, 1),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ]),
      appBar: AppBar(
        title: Text(meditationEx.title),
      ),
    );
  }
}
