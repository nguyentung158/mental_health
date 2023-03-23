import 'package:flutter/material.dart';
import 'package:mental_health_app/controllers/musics_controller.dart';
import 'package:mental_health_app/models/song.dart';
import 'package:mental_health_app/views/screens/main_screens/musics_screen/song_player_screen.dart';
import 'package:mental_health_app/views/widgets/auth_button.dart';
import 'package:mental_health_app/views/widgets/song_item.dart';
import 'package:provider/provider.dart';

class SongDetailScreen extends StatefulWidget {
  Song song;
  SongDetailScreen({super.key, required this.song});

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 23, 77, 1),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: Provider.of<MusicsController>(context, listen: false)
                    .getRelatedSong(widget.song.id, widget.song.category),
                builder: (context, snapshot) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  const Color.fromRGBO(3, 23, 76, 0.5),
                              child: Consumer<MusicsController>(
                                  builder: (context, value, child) {
                                return IconButton(
                                  icon: !widget.song.isFavorite(widget.song.id)
                                      ? Icon(Icons.favorite_outline)
                                      : Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                        ),
                                  onPressed: () async {
                                    widget.song = await value.changeFavourite(
                                        widget.song.id, widget.song.category);
                                  },
                                );
                              }),
                            ),
                          )
                        ],
                        pinned: true,
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
                            widget.song.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        )),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (ctx, index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0),
                                            child: Text(
                                              widget.song.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Row(
                                              children: [
                                                Text(
                                                  widget.song.duration,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                ),
                                                Text(
                                                  ' * ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                ),
                                                Text(
                                                  '${widget.song.category.toUpperCase()} MUSIC',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0),
                                            child: Text(
                                              widget.song.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color: Colors.white,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Consumer<
                                                                MusicsController>(
                                                            builder: (context,
                                                                value, child) {
                                                          return Text(
                                                            '${widget.song.isFavourite.length} Favorits',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17),
                                                          );
                                                        })
                                                      ],
                                                    )),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.headphones,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      'Listening',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Color.fromRGBO(
                                                152, 161, 189, 1),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                35,
                                            width: double.infinity,
                                          ),
                                          Text(
                                            'Related',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                            width: double.infinity,
                                          )
                                        ]),
                                childCount: 1)),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  color: Colors.white,
                                );
                              }
                              return snapshot.data == null
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SongDetailScreen(
                                                  song: snapshot.data![index],
                                                )),
                                      ),
                                      child: SongItem(
                                          title: snapshot.data![index].title,
                                          duration:
                                              snapshot.data![index].duration,
                                          imageUrl:
                                              snapshot.data![index].imageUrl,
                                          category:
                                              snapshot.data![index].category),
                                    );
                            },
                                childCount: snapshot.data == null
                                    ? 0
                                    : snapshot.data!.length),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            )),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SongPlayerScreen(song: widget.song),
                ));
              },
              child: const AuthButton(
                  title: 'Play',
                  color: Colors.white,
                  backGroundColor: Color.fromRGBO(142, 151, 253, 1)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 32,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
