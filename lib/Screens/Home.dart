import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Components/navigator.dart';

import 'Notepad.dart';

class Home extends StatelessWidget {
  var _home = Notepad();
  GlobalKey key;
  var _forum = Container();
  var _account = Container();
  var _controller = PageController();

  int _currentPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          elevation: 0.0,
          label: Text(
            "Add",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
          icon: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            print("CLICKED");
          },
        ),
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
      ),
    );
  }
}
