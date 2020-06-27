import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hackathon_submission/Components/Button.dart';
import 'package:flutter_hackathon_submission/Screens/Notepad.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Components/navigator.dart';
import 'Screens/Home.dart';
import 'Utils/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xff303138));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarColor(Color(0xff303138));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff54ffb8),
          primaryColorDark: Color(0xffff5e7c),
          scaffoldBackgroundColor: Color(0xff303138),
          disabledColor: Color(0xff3d6b6a),
          textTheme: TextTheme(
            headline1: TextStyle(
                color: Color(0xff54ffb8),
                fontSize: 30,
                fontWeight: FontWeight.bold),
            bodyText1: TextStyle(
              color: Color(0xff36c98c),
            ),
            overline: TextStyle(
              color: Color(0xff303138),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Button("ENTER", Theme.of(context).primaryColor, () {
          User.login().then((value) {
            print(value);

            if (value == 0) {
              User.signInWithGoogle().then((s) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            }
          });
        }),
      ),
    );
  }
}
