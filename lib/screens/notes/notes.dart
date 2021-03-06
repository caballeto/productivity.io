import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/widget/notes_list.dart';
import 'package:productivityio/services/database.dart';
import 'package:productivityio/shared/nav_drawer.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Note>>.value(
      value: DatabaseService(uid: user.uid).notes,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text('Notes'),
        ),
        body: NotesList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed(kNoteEditorRoute),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
      ),
    );
  }
}
