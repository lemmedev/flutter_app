import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_app/first_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:html' as html;
import 'first_screen.dart';

void main() {
  runApp(MyApp());
}

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
  final _formKey = GlobalKey<FormState>();
  VideoPlayerController playerController;
  var userInf;
  //final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();
  void playVideo(String atUrl) {
    if (kIsWeb) {
      final doc = html.window.document;
      final v = doc.querySelector("#video");

      if (v != null) {
        // v.hidden = false;
        v.setInnerHtml('<source type="video/mp4" src="$atUrl">',
            validator: html.NodeValidatorBuilder()
              ..allowElement('source', attributes: ['src', 'type']));
        final a = html.window.document.getElementById('triggerVideoPlayer');
        if (a != null) {
          a.dispatchEvent(html.MouseEvent('click'));
        }
      }
    } else {
      // we're not on the web platform
      // and should use the video_player package
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  var passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;

    if (kIsWeb) {
      playVideo(
          'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4');
    }
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount g = await _googleSignIn.signIn();
      print(g.email);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Sign  In success with ${g.email}'),
      ));
    } catch (error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Sign  In Failed'),
      ));
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

  var _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? Stack(
              children: <Widget>[
                Positioned(
                  width: MediaQuery.of(context).size.width * .5,
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    color: Colors.red,
                    child: Image.asset('assets/images/group2.png',
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                    width: MediaQuery.of(context).size.width * .5,
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            child: Image.asset('assets/images/groupHand.png'),
                          ),
                        ),
                        Positioned(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width * 0.94,
                                  right: MediaQuery.of(context).size.width -
                                      MediaQuery.of(context).size.width * 0.94,
                                  top: 40.0,
                                  bottom: 10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Login',
                                          textScaleFactor: 1.5,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        // color: Colors.red,

                                        margin: EdgeInsets.only(left: 0),
                                        alignment: Alignment.centerRight,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Color(0xffb4194b)),
                                          ),
                                          onPressed: () {},
                                          child: Text('Guest'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.only(top: 10.0, bottom: 30),
                                    child: Wrap(children: <Widget>[
                                      Text(
                                        'Use your username and password',
                                        textScaleFactor: 1,
                                      ),
                                    ]),
                                  ),
                                  TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                      },
                                      onSaved: (val) => null
                                      // setState(() => _user.firstName = val),
                                      ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                            _obsecureText = !_obsecureText;
                                          });
                                        },
                                        child: Icon(
                                          // Based on passwordVisible state choose the icon
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                    },
                                    onSaved: (val) => null,
                                    obscureText: _obsecureText,
                                    // setState(() => _user.firstName = val),
                                  ),
                                  Wrap(children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password',
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: FlatButton(
                                          child: Text('Login'),
                                          textColor: Colors.white,
                                          color: Color(0xffb4194b),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Dont have an account?'),
                                      FlatButton(
                                        child: Text('Sign up'),
                                        textColor: Colors.blue,
                                        onPressed: () {},
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    // RaisedButton(
                    //   child: Text("Login with googe"),
                    //   onPressed: () {
                    //     _handleSignIn();
                    //   },
                    // ),
                    )
              ],
            )
          : Container(
              child: Column(
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
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (kIsWeb) {
      //       return null;
      //     }
      //     setState(() {
      //       playerController.value.isPlaying
      //           ? playerController.pause()
      //           : playerController.play();
      //     });
      //     print(playerController.play());
      //   },
      //   tooltip: 'Play/Pause',
      //   child: kIsWeb
      //       ? Icon(playerController.value.isPlaying
      //           ? Icons.pause
      //           : Icons.play_arrow)
      //       : Container(
      //           child: Text('It\'s web'),
      //         ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        if (!kIsWeb) {
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
        }
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
