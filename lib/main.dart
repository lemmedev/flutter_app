import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.asset('assets/videos/intro.mp4')
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 18 / 9,
          child: Container(
            child: (playerController != null
                ? VideoPlayer(playerController)
                : Container()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            playerController.value.isPlaying
                ? playerController.pause()
                : playerController.play();
          });
          // print(playerController.play());
        },
        tooltip: 'Play/Pause',
        child: Icon(
            playerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
