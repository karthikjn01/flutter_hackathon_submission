import 'package:flutter/widgets.dart';
import 'package:flutter_hackathon_submission/Structures/Note.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            note.title,
          ),
          Text(note.description),
        ],
      ),
    );
  }
}
