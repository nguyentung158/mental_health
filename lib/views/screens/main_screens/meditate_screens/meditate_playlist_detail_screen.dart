import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:mental_health_app/models/meditation_ex.dart';
import 'package:mental_health_app/views/widgets/meditate_ex_item.dart';
import 'package:provider/provider.dart';

class MeditatePlaylistDetailScreen extends StatelessWidget {
  final CollectionReference reference;
  final Map<String, dynamic> courseData;
  const MeditatePlaylistDetailScreen(
      {super.key, required this.reference, required this.courseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MeditationEx>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: false,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height / 3,
                flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.network(
                    courseData['imageUrl'],
                    fit: BoxFit.cover,
                  ),
                )),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Text(
                    courseData['title'],
                    style: Theme.of(context).textTheme.headline4,
                  );
                }, childCount: 1)),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Text(
                    courseData['description'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontSize: 17),
                  );
                }, childCount: 1)),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return const Divider(
                    color: Colors.black54,
                  );
                }, childCount: 1)),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                sliver: snapshot.data == null
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => const Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text(
                                      'You had done meditation exercise today.'),
                                ),
                            childCount: 1))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                        return MeditateExItem(
                          reference: reference,
                          meditationEx: snapshot.data![index],
                        );
                      }, childCount: snapshot.data?.length)),
              ),
            ],
          );
        },
        future: Provider.of<MeditateController>(context, listen: false)
            .loadPlaylistItems(reference),
      ),
    );
  }
}
