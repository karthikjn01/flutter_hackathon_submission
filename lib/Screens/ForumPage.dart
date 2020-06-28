import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Components/NoteCard.dart';
import 'package:flutter_hackathon_submission/Components/TipCard.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';
import 'package:flutter_hackathon_submission/Structures/Tip.dart';
import 'package:flutter_hackathon_submission/Utils/User.dart';

import 'FocusPage.dart';

class ForumPage extends StatefulWidget {
  PageController controller;

  ForumPage(this.controller);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  TextEditingController _messageController = TextEditingController();
  bool showing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(listener);
  }

  void listener() {
    setState(() {
      if (widget.controller.page == 1.0) {
        showing = true;
      } else {
        showing = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "TIPS",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Theme.of(context).primaryColorDark),
            ),
          ),
        ),
        Expanded(
          child: Container(
              child: StreamBuilder(
            stream: Firestore.instance
                .collection("Tips")
                .orderBy("time", descending: true)
                .limit(100)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data.documents.length == 0) {
                return Container();
              }

              List<Tip> data = [];

              snapshot.data.documents.forEach((v) {
                data.add(Tip.fromMap(v.data, v.documentID));
              });

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, item) {
                  return Dismissible(
                      key: GlobalKey(debugLabel: data[item].id),
                      movementDuration: Duration(milliseconds: 500),
                      resizeDuration: Duration(milliseconds: 100),
                      background: data[item].author["uid"] == User.user.uid
                          ? Container(
                              color: Theme.of(context).primaryColorDark,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text("DELETE POST",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                  ),
                                ],
                              ),
                            )
                          : data[item].likedBy.contains(User.user.uid)
                              ? Container(
                                  color: Theme.of(context).primaryColorDark,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text("REMOVE LIKE",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text("LIKE",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                    ],
                                  ),
                                ),
                      secondaryBackground: data[item].author["uid"] ==
                              User.user.uid
                          ? Container(
                              color: Theme.of(context).primaryColorDark,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text("DELETE POST",
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline),
                                  ),
                                ],
                              ),
                            )
                          : data[item].likedBy.contains(User.user.uid)
                              ? Container(
                                  color: Theme.of(context).primaryColorDark,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text("REMOVE LIKE",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text("LIKE",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                    ],
                                  ),
                                ),
                      confirmDismiss: (direction) async {
                        if (data[item].author["uid"] == User.user.uid) {
                          Future.delayed(Duration(milliseconds: 200), () {
                            Firestore.instance
                                .collection("Tips")
                                .document(data[item].id)
                                .delete();
                          });
                          return true;
                        }
                        if (data[item].likedBy.contains(User.user.uid)) {
                          Future.delayed(Duration(milliseconds: 500), () {
                            Firestore.instance
                                .collection("Tips")
                                .document(data[item].id)
                                .updateData({
                              "likedBy": FieldValue.arrayRemove([User.user.uid])
                            });
                          });
                          return false;
                        } else {
                          Future.delayed(Duration(milliseconds: 500), () {
                            Firestore.instance
                                .collection("Tips")
                                .document(data[item].id)
                                .updateData({
                              "likedBy": FieldValue.arrayUnion([User.user.uid])
                            });
                          });
                          return false;
                        }
                      },
                      child: TipCard(data[item]));
                },
                itemCount: snapshot.data.documents.length,
              );
            },
          )),
        ),
        AnimatedOpacity(
          opacity: showing ? 1.0 : 0.0,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
          child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            child: TextField(
              controller: _messageController,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Theme.of(context).primaryColorDark),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    EvaIcons.chevronRightOutline,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    if (_messageController.value.text.trim().length == 0) {
                      Flushbar(
                        icon: Icon(
                          EvaIcons.closeOutline,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        message: "Please enter a message",
                        isDismissible: true,
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 100.0),
                        duration: Duration(milliseconds: 1500),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        animationDuration: Duration(milliseconds: 500),
                        borderRadius: 10.0,
                        barBlur: 10.0,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shouldIconPulse: false,
                        boxShadows: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          )
                        ],
                      )..show(context);
                      return;
                    }
                    Tip.fromJson(
                        _messageController.value.text,
                        [],
                        DateTime.now(),
                        {
                          "uid": User.user.uid,
                          "photoUrl": User.user.photoUrl,
                          "displayName": User.user.displayName,
                        }).push();
                    _messageController.clear();
                  },
                ),
                labelText: "MESSAGE",
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Theme.of(context).primaryColorDark),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark, width: 1.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.removeListener(listener);
  }
}
