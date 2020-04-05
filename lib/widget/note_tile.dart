import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/screens/editor/note_editor.dart';
import 'package:productivityio/shared/constants.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  NoteTile({ this.note });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NoteEditor(note: note)
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Color(0xFFDADCE0))
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(note.title ?? '', style: TextStyle(fontSize: 18)),
                SizedBox(height: 14),
                Flexible(
                  flex: 1,
                  child: Text(
                    note.content ?? '',
                    maxLines: 8,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
