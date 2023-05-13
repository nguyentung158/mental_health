import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerView extends StatefulWidget {
  final String url;
  const YoutubePlayerView({super.key, required this.url});

  @override
  State<YoutubePlayerView> createState() => _YoutubePlayerViewState();
}

class _YoutubePlayerViewState extends State<YoutubePlayerView> {
  late YoutubePlayerController _youtubePlayerController;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    final videoId = YoutubePlayer.convertUrlToId(widget.url);
    _youtubePlayerController =
        YoutubePlayerController(initialVideoId: videoId!);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _youtubePlayerController);
  }
}
