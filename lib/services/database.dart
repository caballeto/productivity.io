import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:productivityio/models/note.dart';

class DatabaseService {
  final String uid;

  DatabaseService({ this.uid });

  Stream<List<Note>> get notes {
    return notesCollection(uid)
      .where('state', isEqualTo: 0)
      .snapshots()
      .handleError((e) => debugPrint('query notes failed: $e'))
      .map((snapshot) => Note.fromQuery(snapshot));
  }

  Future<dynamic> saveNoteToFirestore(Note note) async {
    final collection = notesCollection(uid);
    debugPrint('Saving ${note.id} to firestore');
    return note.id == null ? collection.add(note.toJson())
        : collection.document(note.id).updateData(note.toJson());
  }

  CollectionReference notesCollection(String uid) {
    return Firestore.instance.collection('notes-$uid');
  }
}