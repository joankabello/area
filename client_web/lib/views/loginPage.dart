import 'dart:io';

import 'package:client/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

String currentAccessToken;
GoogleSignInAccount currentUser;
bool isGoogleLogged = false;
GlobalKey key;

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile',
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/gmail.compose',
    'https://www.googleapis.com/auth/drive.file'

  ],
);

Future<void> handleSignIn() async {
  try {
    await googleSignIn.signIn();
  } catch (error) {
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
  void joan(){}
}

class _LoginPageState extends State<LoginPage> {
  Map data;
  List usersData;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  void initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();

    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      currentUser = account;
      currentUser.authentication.then((googleKey) {
        currentAccessToken = googleKey.accessToken;
      });
    });
    googleSignIn.signInSilently();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  String pwdIncorrect() {
    return 'Password is incorrect';
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Center(
                    // padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Image.asset(
                      'assets/area_logo.png',
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 2.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 1.0, left: 20.0, right: 20.0, bottom: 0.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      controller: emailInputController,
                      validator: emailValidator,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      controller: pwdInputController,
                      validator: pwdValidator,
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        isGoogleLogged = false;
                        http.post(Uri.http('192.168.3.206:8080', '/login'),
                            headers: {},
                            body: {
                              'first_name': 'mobile',
                              'password': pwdInputController.text,
                              'email': emailInputController.text
                            }).then((res) {
                          if (res.statusCode == 200){
                            _sendMailToHome(context);
                          }
                        });
                      },
                      child: Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      key: key,
                      onTap: () {
                        isGoogleLogged = true;
                        handleSignIn().whenComplete(() {
                          _sendDataToSecondScreen(context);
                        });
                      },
                      child: Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child:
                                    ImageIcon(AssetImage('assets/google.png')),
                              ),
                              SizedBox(width: 10.0),
                              Center(
                                child: Text('Log in with Google',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to AREA ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }

  void _sendMailToHome(BuildContext context) {
    String textToSend = emailInputController.text;
    String googleEmail = '====';
      setState(() {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            text: textToSend,
            googleEmail: googleEmail,
          ),
        ));
      });
          

  }

  Future<void> _sendDataToSecondScreen(BuildContext context) async {
    // sleep(Duration(seconds: 3));
    await Future.delayed(Duration(seconds: 1));
    String textToSend = await currentAccessToken;
    String googleEmail = await currentUser.email;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            accessToken: textToSend,
            googleEmail: googleEmail,
          ),
        ));
            await debugPrint("currentAccessTokennnnn22222" + textToSend);

  }
}
