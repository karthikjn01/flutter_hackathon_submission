import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        note.showBottomSheetView(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title.toUpperCase(),
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
