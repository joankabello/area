import 'dart:io';

import 'package:client/views/createArea.dart';
import 'package:client/views/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'loginPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String text;
  final String accessToken;
  final String googleEmail;

  HomePage({Key key, this.text, this.accessToken, this.googleEmail})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
      text: text, accessToken: accessToken, googleEmail: googleEmail);
}

class _HomePageState extends State<HomePage> {
  final String text;
  final String accessToken;
  final String googleEmail;
  String currentAccessToken;

  _HomePageState({Key key, this.text, this.accessToken, this.googleEmail});

  Map data;
  Map usersData;
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

  Future gmail(bool state) async {
    // await Future.delayed(Duration(seconds: 20));
    // print("============" + currentAccessToken);
    http
        .get(Uri.http('192.168.3.206:8080', '/api/bitcoinGmail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future cloudCoverGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cloudCoverGmail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginCloudCoverGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cloudCoverGmail', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future cookDrive(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cookDrive', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginCookDrive(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cookDrive', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future cookDriveGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cookDriveGmail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginCookDriveGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/cookDriveGmail', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

    Future weatherGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/weatherGmail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginWeatherGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/weatherGmail', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

      Future newsGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/newsGmail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginNewsGmail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/newsGmail', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

        Future issMail(bool state) async {
    http
        .get(Uri.http('192.168.3.206:8080', '/api/issMail', {
      "accessToken": currentAccessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future loginGmail(bool state) async {
    // await Future.delayed(Duration(seconds: 20));
    http
        .get(Uri.http('192.168.3.206:8080', '/api/bitcoinGmail', {
      "accessToken": accessToken,
      "email": text,
      "googleEmail": googleEmail,
      "isGoogleLogged": isGoogleLogged.toString(),
      "state": state.toString()
    }))
        .then((res) {
      print(res.statusCode);
    });
  }

  Future getWeatherNewsMail(bool state) async {
    await http
        .get(Uri.http('192.168.3.206:8080', '/api/weatherNewsMail', {
      "email": text,
      "isGoogleLogged": isGoogleLogged.toString(),
      "googleEmail": googleEmail,
      "state": state.toString()
    }))
        .then((res) {
      print(googleEmail);
    });
  }

  Future getWeatherMail(bool state) async {
    await http.get(Uri.http('192.168.3.206:8080', '/api/weatherMail', {
      "email": text,
      "isGoogleLogged": isGoogleLogged.toString(),
      "googleEmail": googleEmail,
      "state": state.toString()
    }));
  }

  Future getNewsMail(bool state) async {
    print(state);
    await http.get(Uri.http('192.168.3.206:8080', '/api/newsMail', {
      "email": text,
      "isGoogleLogged": isGoogleLogged.toString(),
      "googleEmail": googleEmail,
      "state": state.toString()
    }));
  }

  Future<void> _handleSignOut() {
    return googleSignIn.signOut();
  }

  Future<void> delayGmail(int time) async {
    await Future.delayed(Duration(seconds: time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () {
                _handleSignOut;
                Navigator.of(context).pop();
              }

              // googleSignIn.disconnect().whenComplete(() {
              //           Navigator.of(context).pushReplacement(
              //               MaterialPageRoute(
              //                   builder: (BuildContext context) =>
              //                       LoginPage()));
              //         });
              )
        ],
        title: Image.asset(
          'assets/area_logo.png',
          width: MediaQuery.of(context).size.width / 10,
          height: MediaQuery.of(context).size.height / 10,
        ),
        backgroundColor: Colors.white,
      ),
      body: Wrap(
        children: <Widget>[
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.12,
              width: MediaQuery.of(context).size.width / 1.5,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  // ),
                  // Weather -> Bitcoin -> Email
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset(
                                    'assets/weatherBitcoinEmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Weather forcast in Tirana & Bitcoin News with NodeMailer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
                              value: false,
                              textOn: 'Connected',
                              textOff: 'Disconnected',
                              colorOn: Colors.greenAccent[700],
                              colorOff: Colors.redAccent[700],
                              iconOn: Icons.done,
                              iconOff: Icons.remove_circle_outline,
                              textSize: 14.0,
                              onChanged: (bool state) {
                                if (state == true)
                                  getWeatherNewsMail(state);
                                else if (state == false)
                                  getWeatherNewsMail(state);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Weather -> Email
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/weatherEmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Weather forcast in Tirana with Mail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
                              value: false,
                              textOn: 'Connected',
                              textOff: 'Disconnected',
                              colorOn: Colors.greenAccent[700],
                              colorOff: Colors.redAccent[700],
                              iconOn: Icons.done,
                              iconOff: Icons.remove_circle_outline,
                              textSize: 14.0,
                              onChanged: (bool state) {
                                if (state == true)
                                  getWeatherMail(state);
                                else if (state == false) getWeatherMail(state);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bitcoin -> Email
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/bitcoinEmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Bitcoin News with NodeMailer",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  getNewsMail(state);
                                } else if (state == false) {
                                  getNewsMail(state);
                                  print('its false++++++++++++++');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/bitcoinGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Bitcoin Price with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          gmail(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginGmail(state);
                                          debugPrint(
                                              "after loginGmail" + accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child:
                                    Image.asset('assets/cloudCoverGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Cloud Cover in Tirana with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          cloudCoverGmail(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginCloudCoverGmail(state);
                                          debugPrint(
                                              "after loginGmail 88888888888888" +
                                                  accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/cookDrive.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Save your cook recipes in Google Drive",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          cookDrive(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginCookDrive(state);
                                          debugPrint(
                                              "after loginGmail 88888888888888" +
                                                  accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/cookDriveGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Save your cook recipes on Drive and send them with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          cookDriveGmail(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginCookDriveGmail(state);
                                          debugPrint(
                                              "after loginGmail 88888888888888" +
                                                  accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/weatherGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Weather forcast in Tirana with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          weatherGmail(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginWeatherGmail(state);
                                          debugPrint(
                                              "after loginGmail 88888888888888" +
                                                  accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                      SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/newsGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Bitcoin News with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                  if (isGoogleLogged == false) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');
                                          newsGmail(state);
                                        });
                                      });
                                    });
                                  } else if (isGoogleLogged == true) {
                                    handleSignIn().whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          print('30 seconds passed');

                                          loginNewsGmail(state);
                                          debugPrint(
                                              "after loginGmail 88888888888888" +
                                                  accessToken);
                                          print("$state  ++++++");
                                        });
                                      });
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                      SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Image.asset('assets/newsGmail.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "Get Bitcoin News with Gmail",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            child: LiteRollingSwitch(
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
                                 issMail(state);
                                }
                                else if (state == false)
                                issMail(state);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            (MaterialPageRoute(
                              builder: (context) => CreateArea(
                                  text: text,
                                  accessToken: accessToken,
                                  googleEmail: googleEmail),
                            )));
                      });
                    },
                    child: Container(
                      height: 40.0,
                      width: 10,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        // elevation: 7.0,
                        // child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Icon(
                              Icons.create,
                              color: Colors.white,
                            )),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text('CREATE AREA',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
