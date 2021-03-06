import 'dart:io';

import 'package:client/views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

String action;
String reaction;
final snackbar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Could not make Area! Select only 2 options'));

class CreateArea extends StatefulWidget {
  final String text;
  final String accessToken;
  final String googleEmail;

  CreateArea({Key key, this.text, this.accessToken, this.googleEmail})
      : super(key: key);

  @override
  _CreateAreaState createState() => _CreateAreaState(
      text: text, accessToken: accessToken, googleEmail: googleEmail);
}

class _CreateAreaState extends State<CreateArea> {
  final String text;
  final String accessToken;
  final String googleEmail;
  String currentAccessToken;
  _CreateAreaState({Key key, this.text, this.accessToken, this.googleEmail});
  bool weatherValue = false;
  bool mailValue = false;
  bool newsValue = false;
  bool bitcoinValue = false;
  bool gmailValue = false;
  bool cloudCoverValue = false;
  bool cookValue = false;
  bool driveValue = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      // setState(() {
      currentUser = account;
      currentUser.authentication.then((googleKey) {
//          print(googleKey.accessToken);
        currentAccessToken = googleKey.accessToken;
//          print(googleKey.accessToken);
        //   print(googleKey.idToken);
        //   print(_currentUser.displayName);
        // });
      });
    });
    googleSignIn.signInSilently();
  }

  Future sendActionReaction(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/$action$reaction', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      throw Exception('Failed Load Data with status code ${res.statusCode}');
    });
  }

  Future sendActionReactionGoogleLogged(
      bool state, BuildContext context) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/$action$reaction', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print("===================");
      print(res.statusCode);
      if (res.statusCode == 404) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error: Couldn't send Area"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Builder(
          builder: (context) => LiteRollingSwitch(
            value: false,
            textOn: 'Connected',
            textOff: 'Disconnected',
            colorOn: Colors.greenAccent[700],
            colorOff: Colors.redAccent[700],
            iconOn: Icons.done,
            iconOff: Icons.remove_circle_outline,
            textSize: 14.0,
            onChanged: (bool state) {
              if (state == true) {
                if (action != null && reaction != null) {
                  if (isGoogleLogged == false) {
                    handleSignIn().whenComplete(() {
                      // Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        sendActionReaction(state);
                      });
                      // });
                    });
                  } else if (isGoogleLogged == true) {
                    sendActionReactionGoogleLogged(state, context);
                  }
                }
              }
            },
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(

      child: GridView.count(
        childAspectRatio: 6.0,
        crossAxisCount: 2,
        children: <Widget>[
          CheckboxListTile(
            activeColor: Colors.green,
            title: const Text('Weather'),
            value: weatherValue,
            onChanged: (bool value) {
              if (weatherValue == false) {
                setState(() {
                  weatherValue = true;
                  action = 'weather';
                  print(action);
                });
              } else {
                setState(() {
                  weatherValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.wb_sunny, ),
          ),
          CheckboxListTile(
            title: const Text('Mail'),
            value: mailValue,
            onChanged: (bool value) {
              if (mailValue == false) {
                setState(() {
                  mailValue = true;
                  reaction = 'Mail';
                });
              } else {
                setState(() {
                  mailValue = false;
                  reaction = null;
                });
              }
            },
            secondary: const Icon(Icons.mail),
          ),
          CheckboxListTile(
            title: const Text('News'),
            value: newsValue,
            onChanged: (bool value) {
              if (newsValue == false) {
                setState(() {
                  newsValue = true;
                  action = 'news';
                });
              } else {
                setState(() {
                  newsValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.library_books),
          ),
          CheckboxListTile(
            title: const Text('Gmail'),
            value: gmailValue,
            onChanged: (bool value) {
              if (gmailValue == false) {
                setState(() {
                  gmailValue = true;
                  reaction = 'Gmail';
                });
              } else {
                setState(() {
                  gmailValue = false;
                  reaction = null;
                });
              }
            },
            secondary: const Icon(Icons.mail),
          ),
          CheckboxListTile(
            title: const Text('Bitcoin'),
            value: bitcoinValue,
            onChanged: (bool value) {
              if (bitcoinValue == false) {
                setState(() {
                  bitcoinValue = true;
                  action = 'bitcoin';
                });
              } else {
                setState(() {
                  bitcoinValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.copyright),
          ),
          CheckboxListTile(
            title: const Text('CloudCover'),
            value: cloudCoverValue,
            onChanged: (bool value) {
              if (cloudCoverValue == false) {
                setState(() {
                  cloudCoverValue = true;
                  action = 'cloudCover';
                });
              } else {
                setState(() {
                  cloudCoverValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.cloud),
          ),
          CheckboxListTile(
            title: const Text('Cook Recipe'),
            value: cookValue,
            onChanged: (bool value) {
              if (cookValue == false) {
                setState(() {
                  cookValue = true;
                  action = 'cook';
                });
              } else {
                setState(() {
                  cookValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.collections_bookmark),
          ),
          CheckboxListTile(
            title: const Text('Drive'),
            value: driveValue,
            onChanged: (bool value) {
              if (driveValue == false) {
                setState(() {
                  driveValue = true;
                  reaction = 'Drive';
                });
              } else {
                setState(() {
                  driveValue = false;
                  action = null;
                });
              }
            },
            secondary: const Icon(Icons.mail),
          ),
        ],
      ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
