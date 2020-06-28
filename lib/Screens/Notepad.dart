import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Components/NoteCard.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';
import 'package:flutter_hackathon_submission/Utils/User.dart';

import 'FocusPage.dart';

class Notepad extends StatefulWidget {
  Notepad({Key key}) : super(key: key);

  @override
  NotepadState createState() => NotepadState();
}

class NotepadState extends State<Notepad> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(User.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "TASKS",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1,
            ),
          ),
        ),
        Expanded(
          child: Container(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("Notes")
                    .where("user", isEqualTo: User.user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null || snapshot.data.documents.length == 0) {
                    return Container();
                  }

                  List<Note> data = [];

                  snapshot.data.documents.forEach((v) {
                    data.add(Note.fromJson(v.data, v.documentID));
                  });

                  return ListView.builder(
                    itemBuilder: (context, item) {
                      return Dismissible(
                          key: GlobalKey(debugLabel: data[item].id),
                          background: Container(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text("BEGIN",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .overline),
                                ),
                              ],
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Theme
                                .of(context)
                                .primaryColorDark,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text("DELETE",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .overline),
                                ),
                              ],
                            ),
                          ),
                          confirmDismiss: (direction) =>
                              Future.delayed(
                                Duration(milliseconds: 1),
                                    () {
                                  print("D: $direction");

                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => FocusPage(data[item])));
                                  }else{
                                    Firestore.instance.collection("Notes").document(data[item].id).delete();
                                  }


                                  return direction ==
                                      DismissDirection.startToEnd
                                      ? false
                                      : true;
                                },
                              ),
                          child: NoteCard(data[item]));
                    },
                    itemCount: snapshot.data.documents.length,
                  );
                },
              )),
        ),
      ],
    );
  }
}
