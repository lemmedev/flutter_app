import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sample_web/first_screen.dart';
// import 'package:flutter_app/first_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController playerController;
  var userInf;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!kIsWeb) {
      playerController = VideoPlayerController.network(
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
        // VideoPlayerController.asset('assets/videos/intro.mp4')
        ..initialize()
        ..setVolume(1.0).then(
          (_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          },
        );
    }
  }

  Future<String> signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    // print(user);
    userInf = user;

    return 'signInWithGoogle succeeded: $user';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Web Render'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: AspectRatio(
              aspectRatio: 18 / 9,
              child: Container(
                child: ((playerController != null && !kIsWeb)
                    ? VideoPlayer(playerController)
                    : Container()),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: _signInButton(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kIsWeb) {
            return null;
          }
          setState(() {
            playerController.value.isPlaying
                ? playerController.pause()
                : playerController.play();
          });
          print(playerController.play());
        },
        tooltip: 'Play/Pause',
        child: kIsWeb
            ? Icon(playerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow)
            : Container(
                child: Text('It\'s web'),
              ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        // if (!kIsWeb) {
        signInWithGoogle().whenComplete(
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen(userInf);
                },
              ),
            );
          },
        );
        // }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
