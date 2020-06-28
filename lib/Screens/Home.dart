import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Components/navigator.dart';
import 'package:flutter_hackathon_submission/Screens/AccountPage.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';
import 'package:uuid/uuid.dart';

import 'ForumPage.dart';
import 'Notepad.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _home = Notepad();

  GlobalKey<NavigatorBarState> key;

  var _forum;

  var _account = AccountPage();

  var _controller = PageController();

  int _currentPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    key = GlobalKey<NavigatorBarState>();
    _forum = ForumPage(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _currentPosition == 0
            ? FloatingActionButton.extended(
                elevation: 0.0,
                label: Text(
                  "Add",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Note(Uuid().v4().toString(), "", "",
                          Duration(milliseconds: 500000))
                      .showBottomSheetView(context);
                },
              )
            : null,
        body: PageView(
          controller: _controller,
          children: [_home, _forum, _account],
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
//          onPageChanged: (i) {
//            key.currentState.selectTab(i);
//          },
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
                    setState(() {
                      _currentPosition = currentPosition;
                    });

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
