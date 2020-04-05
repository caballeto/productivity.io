import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({
    Key key,
    this.note
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'NoteItem${note.id}',
      child: DefaultTextStyle(
        style: TextStyle(
          color: Color(0x99000000),
          fontSize: 16,
          height: 1.3125
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(note.title ?? ''),
              SizedBox(height: 14),
              Flexible(
                flex: 1,
                child: Text(note.content ?? ''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
