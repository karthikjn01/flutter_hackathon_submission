import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Components/Button.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';
import 'package:flutter_hackathon_submission/Utils/Utils.dart';

class FocusPage extends StatefulWidget {
  Note note;

  FocusPage(this.note);

  @override
  _FocusPageState createState() => _FocusPageState(note);
}

class _FocusPageState extends State<FocusPage> {
  String _timeLeft = "";

  int timeSinceStarted = 0;

  bool paused = false;

  Note note;

  _FocusPageState(this.note);

  bool disposed = false;

  Alignment alignment;

  bool a = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    alignment = Alignment.center;

    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!paused) {
        timeSinceStarted++;
      }

      if (disposed) {
        timer.cancel();
      }

      setState(() {
        if (!a) {
          a = !a;
        } else {
          a = !a;
          if (alignment == Alignment.centerRight ||
              alignment == Alignment.center) {
            alignment = Alignment.centerLeft;
          } else {
            alignment = Alignment.centerRight;
          }
        }

        if (note.timer.inMilliseconds - ((timeSinceStarted + 1) * 1000) < 0) {
          timeSinceStarted -= 5;
          paused = true;
          showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              builder: (c) {
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note.title.toUpperCase() + "\nHAS BEEN COMPLETED",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Button("FINISH", Theme.of(context).primaryColor,
                            () {
                          Firestore.instance
                              .collection("Notes")
                              .document(note.id)
                              .delete();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }),
                      )
                    ],
                  ),
                );
              });
        }
        _timeLeft = Utils.calculateTime(Duration(
            milliseconds:
                note.timer.inMilliseconds - (timeSinceStarted * 1000)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "FOCUS",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          width: 250,
                          alignment: alignment,
                          curve: Curves.easeInOutSine,
                          duration: Duration(milliseconds: 2000),
                          child: Container(
                              width: 225, child: Image.asset("sun.png")),
                        ),
                        AnimatedContainer(
                          width: 300,
                          alignment: alignment,
                          curve: Curves.easeInOutSine,
                          duration: Duration(milliseconds: 2000),
                          child: Container(
                              width: 100, child: Image.asset("car.png")),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            note.title.toUpperCase(),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            note.description.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Container(height: 10),
                          Text(
                            _timeLeft.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white.withOpacity(0.2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    EvaIcons.chevronUpOutline,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    paused ? "PLAY" : "PAUSE",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  Text(
                                    paused
                                        ? "Playing will continue the timer"
                                        : "Pausing will pause the timer",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: paused ? 10.0 : 0.0),
                              child: Button(paused ? "PLAY" : "PAUSE",
                                  Theme.of(context).primaryColor, () {
                                Firestore.instance
                                    .collection("Notes")
                                    .document(note.id)
                                    .updateData({
                                  "duration": note.timer.inMilliseconds -
                                      (timeSinceStarted * 1000)
                                });
                                paused = !paused;
                              }),
                            ),
                            paused
                                ? Button(
                                    "RETURN", Theme.of(context).primaryColor,
                                    () {
                                    if (paused) Navigator.pop(context);
                                  })
                                : Container(),
                          ],
                        ),
                        Container(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RESET",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  Text(
                                    "Resetting will return the clock to the original time.",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Button(
                                  "RESET", Theme.of(context).primaryColor, () {
                                setState(() {
                                  timeSinceStarted = 0;
                                });
                              }),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "FINISH",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  Text(
                                    "Finishing will remove it from the homepage.",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Button(
                                  "FINISH", Theme.of(context).primaryColor, () {
                                Firestore.instance
                                    .collection("Notes")
                                    .document(note.id)
                                    .delete();
                                Navigator.of(context).pop();
                              }),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    disposed = true;
  }
}
