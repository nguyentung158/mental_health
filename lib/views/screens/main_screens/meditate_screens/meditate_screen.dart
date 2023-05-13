import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/meditate_controller.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_detail_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_playlist_detail_screen.dart';
import 'package:mental_health_app/views/screens/main_screens/meditate_screens/meditate_report_screen.dart';
import 'package:mental_health_app/views/widgets/meditate_course_lists.dart';
import 'package:provider/provider.dart';

class MeditateScreen extends StatefulWidget {
  const MeditateScreen({super.key});

  @override
  State<MeditateScreen> createState() => _MeditateScreenState();
}

class _MeditateScreenState extends State<MeditateScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   heroTag: null,
      //   onPressed: () async {
      //     MeditationEx meditationEx = MeditationEx(
      //         title:
      //             'Transformative Breathwork and Meditation to Contemplate on Self',
      //         id: DateTime.now().toString(),
      //         category: 'Transcendental',
      //         description: 'description',
      //         duration: 'duration',
      //         videoUrl:
      //             'https://www.youtube.com/watch?v=l72L5FRNr2I&list=PLBfRLLhSBb-BkbhVRMEbmnxOYOJkU6LOC&index=1&ab_channel=BreatheandFlow',
      //         imageUrl:
      //             'https://images.unsplash.com/photo-1474418397713-7ede21d49118?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWVkaXRhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
      //         isDone: []);
      //     await FirebaseFirestore.instance
      //         .collection('meditation_playlist')
      //         .doc('Trending this week')
      //         .collection('courses')
      //         .doc('Sound Healing Meditation for Relaxation and Inner Peace')
      //         .collection('list')
      //         .doc(meditationEx.id)
      //         .set(meditationEx.toJson());
      //     await FirebaseFirestore.instance
      //         .collection('meditation_playlist')
      //         .doc('Trending this week')
      //         .collection('courses')
      //         .doc('Sound Healing Meditation for Relaxation and Inner Peace')
      //         .set({
      //       'imageUrl':
      //           'https://t3.ftcdn.net/jpg/00/82/69/12/360_F_82691291_ER0rGruoM5zLxytoiQO1g85yhyXjq0Lv.jpg',
      //       'description':
      //           "This course uses sound healing techniques to calm the mind and promote a more relaxed state of being."
      //     });
      //     // await Provider.of<MeditateController>(context, listen: false)
      //     //     .loadPlaylist();
      //   },
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MeditateReportScreen(),
                ));
              },
              icon: Icon(
                Icons.history,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
        flexibleSpace: SafeArea(
          child: ListTile(
            leading: ImageIcon(
              const AssetImage('assets/images/app_logo_icon.png'),
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Transform.translate(
              offset: const Offset(-16, 0),
              child: Text(
                'Meditate',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: FutureBuilder<Object>(
              future: Provider.of<MeditateController>(context, listen: false)
                  .loadAll(),
              builder: (context, snapshot) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          MeditatePlaylistDetailScreen(
                                        reference: FirebaseFirestore.instance
                                            .collection('meditation_playlist')
                                            .doc('daily')
                                            .collection('daily'),
                                        courseData: const {
                                          'title': 'Daily Meditation',
                                          'imageUrl':
                                              'https://images.unsplash.com/photo-1559595500-e15296bdbb48?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80',
                                          'description':
                                              'The Daily Meditation feature is designed to help you incorporate a daily meditation practice into your routine. With this feature, you can set aside a few minutes each day to focus your mind, calm your thoughts, and cultivate a sense of inner peace and relaxation.'
                                        },
                                      ),
                                    ));
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1559595500-e15296bdbb48?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'))),
                                      ),
                                      Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFF000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          snapshot.connectionState !=
                                                  ConnectionState.waiting
                                              ? 'Daily Meditation'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            childCount: 1)),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(((context, index) {
                      return MeditateCourseLists(
                          title: Provider.of<MeditateController>(context,
                                  listen: false)
                              .playlistTitle[index]);
                    }),
                            childCount: Provider.of<MeditateController>(context,
                                    listen: false)
                                .playlistTitle
                                .length)),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: Text(
                            'Healthy mind is the key to your success!',
                            style: Theme.of(context).textTheme.headline6!,
                          ),
                        ),
                      );
                    }), childCount: 1)),
                  ],
                );
              })),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
