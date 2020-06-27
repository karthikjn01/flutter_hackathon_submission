import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Components/NoteCard.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';

class Notepad extends StatefulWidget {
  Notepad({Key key}) : super(key: key);

  @override
  NotepadState createState() => NotepadState();
}

class NotepadState extends State<Notepad> {
  var data = [
    Note(
        "1", "Title 1", "description 1", Duration(hours: 1, minutes: 2), false),
    Note("2", "Title 2", "description 2", Duration(hours: 1, minutes: 20),
        false),
    Note("3", "Title 3", "description 3", Duration(hours: 1, minutes: 40),
        false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "TASKS",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Expanded(
          child: Container(
              child: ListView.builder(
            itemBuilder: (context, item) {
              return Dismissible(
                  key: GlobalKey(debugLabel: data[item].id),
                  background: Container(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("BEGIN",
                              style: Theme.of(context).textTheme.overline),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Theme.of(context).primaryColorDark,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("DELETE",
                              style: Theme.of(context).textTheme.overline),
                        ),
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) => Future.delayed(
                        Duration(milliseconds: 1),
                        () {
                          print("D: $direction");
                          return direction == DismissDirection.startToEnd
                              ? false
                              : true;
                        },
                      ),
                  child: NoteCard(data[item]));
            },
            itemCount: data.length,
          )),
        ),
      ],
    );
  }
}
