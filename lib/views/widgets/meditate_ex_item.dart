import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:mental_health_app/models/meditation_ex.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_detail_screen.dart';
import 'package:provider/provider.dart';

class MeditateExItem extends StatelessWidget {
  final CollectionReference reference;
  final MeditationEx meditationEx;
  const MeditateExItem(
      {super.key, required this.reference, required this.meditationEx});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeditateDetailScreen(
                    reference: reference,
                    meditationEx: meditationEx,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 8, right: 8),
          title: Text(meditationEx.title,
              style: Theme.of(context).textTheme.headline6),
          subtitle: Text(
            meditationEx.duration,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: const Color.fromRGBO(24, 34, 58, 1),
                fontSize: 13,
                fontWeight: FontWeight.w100),
          ),
          leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/006/408/741/small/meditate-yoga-person-sitting-in-lotus-position-line-icon-relaxation-tranquility-rest-keep-calm-illustration-free-vector.jpg',
                fit: BoxFit.cover,
              )),
          trailing: SizedBox(
            width: 25,
            child: Consumer<MeditateController>(
              builder: (context, value, child) => FutureBuilder<bool>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    return snapshot.data == true
                        ? const Icon(
                            Icons.done,
                            color: Colors.black,
                          )
                        : Container();
                  },
                  future:
                      Provider.of<MeditateController>(context, listen: false)
                          .isMeditateDone(reference, meditationEx.id)),
            ),
          ),
        ),
      ),
    );
  }
}
