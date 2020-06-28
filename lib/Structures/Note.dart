import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hackathon_submission/Components/Button.dart';
import 'package:flutter_hackathon_submission/Utils/User.dart';

class Note {
  String id;
  String title;
  String description;
  Duration timer;

  Note(this.id, this.title, this.description, this.timer);

  Note.fromJson(Map<String, dynamic> map, String id) {
    print(map);
    this.id = id;
    this.title = map["title"];
    this.description = map["description"];
    this.timer = Duration(milliseconds: map["duration"]);
  }

  void showBottomSheetView(context) {
    TextEditingController _titleController =
        TextEditingController(text: this.title ?? "");
    TextEditingController _descriptionController =
        TextEditingController(text: this.description ?? "");
    TextEditingController _minuteController = TextEditingController(
        text: (this.timer.inMinutes % 60).toString() ?? "30");
    TextEditingController _hourController =
        TextEditingController(text: this.timer.inHours.toString() ?? "1");

    showModalBottomSheet(
        context: context,
        elevation: 5.0,
        enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            decoration: BoxDecoration(),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.words,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).disabledColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).disabledColor, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                    ),
                  ),
                  Divider(),
                  TextField(
                    controller: _descriptionController,
                    style: Theme.of(context).textTheme.bodyText1,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: Theme.of(context).textTheme.bodyText1,
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).disabledColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).disabledColor, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hourController,
                          style: Theme.of(context).textTheme.bodyText1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Hour",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _minuteController,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            labelText: "Minutes",
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Center(
                      child: Button("SAVE", Theme.of(context).primaryColor, () {
                    this.title = _titleController.value.text;
                    this.description = _descriptionController.value.text;

                    if (this.title.trim().isEmpty ||
                        this.description.trim().isEmpty) {
                      Flushbar(
                        icon: Icon(
                          EvaIcons.closeOutline,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        message: "Enter Meaningful Data",
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
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5.0,
                            spreadRadius: 3.0,
                          )
                        ],
                      )..show(context);
                      return;
                    }

                    Firestore.instance
                        .collection("Notes")
                        .document(this.id)
                        .setData({
                      "description": this.description,
                      "title": this.title,
                      "user": User.user.uid,
                      "duration": int.parse(_hourController.value.text) *
                              Duration.millisecondsPerHour +
                          int.parse(_minuteController.value.text) *
                              Duration.millisecondsPerMinute,
                    });
                    Navigator.of(context).pop();
                  }))
                ],
              ),
            ),
          );
        });
  }
}
