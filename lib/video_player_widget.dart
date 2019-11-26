import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  VideoPlayerController playerController;
  VoidCallback listener; // means the fn has no argument and no return value

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playerController = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      // VideoPlayerController.asset('assets/videos/intro.mp4')
      ..initialize()
      ..setVolume(1.0).then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 18 / 9,
          child: Container(
            child: (playerController != null
                ? VideoPlayer(playerController)
                : Container()),
          ),
        ),
      ),
    );
  }
}
