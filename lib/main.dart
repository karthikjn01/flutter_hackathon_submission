import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Screens/Notepad.dart';

import 'Components/navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff54ffb8),
          scaffoldBackgroundColor: Color(0xff303138),
          disabledColor: Color(0xff3d6b6a),
        ),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatelessWidget {
  var _home = Notepad();
  var _forum = Container();
  var _account = Container();
  var _controller = PageController();

  int _currentPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [_home, _forum, _account],
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0.0,
                offset: Offset(0, 0),
                color: Colors.black.withOpacity(0.2),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              NavigatorBar(
                (currentPosition) {
                  _controller.animateToPage(currentPosition,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                key: key,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
