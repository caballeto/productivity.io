import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/screens/editor/note_editor.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/shared/utilities.dart';

class NoteTile extends StatelessWidget {
  static final formatter = DateFormat.yMMMMd('en_US');

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
            decoration: boxDecoration,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(formatTitle(title: note.title), style: TextStyle(fontSize: 18)),
                    Text(formatter.format(note.createdAt) ?? '')
                  ],
                ),
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
