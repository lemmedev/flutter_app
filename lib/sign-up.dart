import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var passwordVisible = false;
  var _obsecureText = true;

  _signUpButton() {}

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked.toString() + '>>>>>>>>');
        selectedDate = picked;
      });
  }

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
                                          'Sign Up',
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
                                        labelText: 'Username',
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
                                        labelText: 'Phone',
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
                                  Container(
                                      padding: EdgeInsets.only(top: 15.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'DOB',
                                      )),
                                  TextFormField(
                                      decoration: InputDecoration(
                                          // labelText: 'DOB',
                                          ),
                                      onTap: () => _selectDate(context),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                      },
                                      initialValue: selectedDate.toString(),
                                      onSaved: (val) {
                                        setState(() {
                                          selectedDate.toLocal();
                                        });
                                      }
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
                                          onPressed: () {
                                            final form = _formKey.currentState;
                                            print(form.toString() + 'zzzzzzzz');
                                          },
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
                        child: Container(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: _signUpButton(),
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
}
