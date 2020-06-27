import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                note.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
