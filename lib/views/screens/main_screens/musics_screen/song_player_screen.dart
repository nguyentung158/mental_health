import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/models/song.dart';

class SongPlayerScreen extends StatefulWidget {
  final Song song;
  const SongPlayerScreen({super.key, required this.song});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.paused;

  int _timeProgress = 0;
  int _audioDuration = 0;

  Widget slider() {
    return SizedBox(
      width: 300,
      child: Slider(
        activeColor: Colors.white,
        inactiveColor: const Color.fromRGBO(71, 85, 126, 1),
        thumbColor: Colors.white,
        value: _timeProgress.floorToDouble(),
        max: _audioDuration.floorToDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          _playerState = event;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((event) {
      if (mounted) {
        setState(() {
          _audioDuration = event.inSeconds;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((event) {
      if (mounted) {
        setState(() {
          _timeProgress = event.inSeconds;
        });
      }
    });
    play();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.release();
    _audioPlayer.dispose();
  }

  void play() async {
    await _audioPlayer.play(UrlSource(widget.song.songUrl));
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(3, 23, 77, 1),
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/musics_icons/song_player_bg.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.song.title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                widget.song.category,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white60, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (_timeProgress - 15 <= 0) {
                          seekToSec(0);
                        }
                        seekToSec(_timeProgress - 15);
                      },
                      icon: const ImageIcon(
                        AssetImage(
                            'assets/images/musics_icons/15s_arrow_back.png'),
                        color: Colors.white,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      _playerState == PlayerState.playing ? pause() : play();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: Icon(
                        _playerState == PlayerState.playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {
                        if (_timeProgress + 15 >= _audioDuration) {
                          seekToSec(_audioDuration);
                        }
                        seekToSec(_timeProgress + 15);
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/images/musics_icons/15s_arrow.png'),
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: slider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTimeString(_timeProgress),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      getTimeString(_audioDuration),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              // ignore: avoid_returning_null_for_void
            ],
          )),
    );
  }

  void seekToSec(int sec) {
    Duration duration = Duration(seconds: sec);
    _audioPlayer.seek(duration);
  }

  String getTimeString(int seconds) {
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';
    return '$minuteString:$secondString'; // Returns a string with the format mm:ss
  }
}
