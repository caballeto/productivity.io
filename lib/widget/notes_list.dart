import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/widget/note_tile.dart';
import 'package:provider/provider.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context) ?? [];
    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => NoteTile(note: notes[index])
    );
  }
}

