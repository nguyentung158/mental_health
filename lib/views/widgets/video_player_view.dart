import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    _videoPlayerController = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: _videoPlayerController.value.aspectRatio);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    _videoPlayerController.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_videoPlayerController.value.aspectRatio);
    return _chewieController != null
        ? AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Chewie(
              controller: _chewieController!,
            ))
        : CircularProgressIndicator();
  }
}
