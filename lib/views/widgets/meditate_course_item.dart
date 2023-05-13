import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_playlist_detail_screen.dart';

class MeditateCourseItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const MeditateCourseItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CollectionReference reference = FirebaseFirestore.instance
            .collection('meditation_playlist')
            .doc(data['path'])
            .collection('courses')
            .doc(data['title'])
            .collection('list');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeditatePlaylistDetailScreen(
                    reference: reference,
                    courseData: data,
                  )),
        );
      },
      child: Row(
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(data['imageUrl']))),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data['title'],
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  data['description'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 13,
                      color: const Color.fromRGBO(87, 95, 112, 1),
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          )),
          const SizedBox(
            width: 3,
          ),
        ],
      ),
    );
  }
}
