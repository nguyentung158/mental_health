import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/musics_controller.dart';
import 'package:mental_health_app/views/screens/main_screens/musics_screens/song_detail_screen.dart';
import 'package:mental_health_app/views/widgets/music_filter_button.dart';
import 'package:mental_health_app/views/widgets/song_item.dart';
import 'package:provider/provider.dart';

class MusicsScreen extends StatefulWidget {
  const MusicsScreen({super.key});

  @override
  State<MusicsScreen> createState() => _MusicsScreenState();
}

class _MusicsScreenState extends State<MusicsScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<MusicsController>(context, listen: false).getCategories();
    Provider.of<MusicsController>(context, listen: false).getAllSongs();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MusicsController>(context, listen: false).getFilterSongs(0);
      // Add Your Code here.
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    double appbarHeight = appBar.preferredSize.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   Song song = Song(
      //       title: 'Moon clouds',
      //       id: '${DateTime.now()}',
      //       category: 'sleep',
      //       description:
      //           'Ease the mind into a restful night’s sleep with these deep, amblent tones.',
      //       duration: '40 min',
      //       isFavourite: [],
      //       songUrl:
      //           'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      //       imageUrl:
      //           'https://img.freepik.com/premium-photo/beautiful-realistic-clouds-with-full-moon_250994-421.jpg?w=2000');
      //   await FirebaseFirestore.instance
      //       .collection('musics')
      //       .doc(song.id)
      //       .set(song.toJson());
      // }),
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/musics_icons/background.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: EdgeInsets.only(top: appbarHeight),
                            child: Text(
                              'Musics Stories',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      childCount: 1)),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              'Soothing bedtime stories to help you fall into a deep and natural sleep',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white, fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      childCount: 1)),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                            margin: const EdgeInsets.only(
                                left: 8, top: 6, bottom: 12),
                            height: MediaQuery.of(context).size.height / 9,
                            child: Consumer<MusicsController>(
                                builder: (context, value, child) {
                              return ListView.builder(
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () => value.getFilterSongs(index),
                                  child: MusicFilterButton(
                                      title: value.categories[index],
                                      isSelected: value.selectedIndex == index),
                                ),
                                itemCount: value.categories.length,
                                scrollDirection: Axis.horizontal,
                              );
                            }),
                          ),
                      childCount: 1)),
              Consumer<MusicsController>(
                builder: (context, value, child) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SongDetailScreen(
                                        song: value.filterSongs[index],
                                      )),
                            );
                          },
                          child: SongItem(
                              title: value.filterSongs[index].title,
                              duration: value.filterSongs[index].duration,
                              imageUrl: value.filterSongs[index].imageUrl,
                              category: value.filterSongs[index].category),
                        );
                      },
                          childCount: Provider.of<MusicsController>(context)
                              .filterSongs
                              .length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
