import 'package:flutter/material.dart';
import 'package:flutter_hackathon_submission/Components/NoteCard.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';

class Notepad extends StatefulWidget {
  @override
  _NotepadState createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  var data = [
    Note("title 1", "description 1", Duration(hours: 1, minutes: 2), false),
    Note("title 2", "description 2", Duration(hours: 1, minutes: 20), false),
    Note("title 3", "description 3", Duration(hours: 1, minutes: 40), false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (context, item) {
        return NoteCard(data[item]);
      },
      itemCount: data.length,
    ));
  }
}
