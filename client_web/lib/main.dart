import 'package:client/views/createArea.dart';
import 'package:client/views/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:client/views/homePage.dart';
import 'package:client/views/loginPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/home': (_) => HomePage(),
        '/createArea': (_) => CreateArea(),
        '/signup': (_) => SignupPage()
      },
    ),
  );
}
