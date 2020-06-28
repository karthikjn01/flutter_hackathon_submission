import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_hackathon_submission/Components/Button.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';

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
          primaryColor: Color(0xff30fca4),
          primaryColorDark: Color(0xffff3364),
          primaryColorLight: Color(0xffbc47ff),
          accentColor: Color(0xff703241),
          splashColor: Color(0xff563366),
          disabledColor: Color(0xff3d6b6a),
          scaffoldBackgroundColor: Color(0xff303138),
          textTheme: TextTheme(
            headline1: GoogleFonts.poppins(
                shadows: [
                  BoxShadow(color: Color(0xffffffff).withOpacity(0.1)
                      , spreadRadius: 2.0, blurRadius: 5.0)
                ],
                color: Color(0xff30fca4),
                fontSize: 35,
                fontWeight: FontWeight.w800,
            ),
            headline2: GoogleFonts.poppins(
              shadows: [
                BoxShadow(color: Color(0xffffffff).withOpacity(0.1)
                    , spreadRadius: 2.0, blurRadius: 5.0)
              ],
              color: Color(0xff30fca4),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: GoogleFonts.poppins(
              color: Color(0xff30fca4),
            ),
            overline: GoogleFonts.poppins(
              color: Color(0xff303138),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    User.login().then((value) {
      if (value == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      }
    });
  }

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
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            }
          });
        }),
      ),
    );
  }
}
