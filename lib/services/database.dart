import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/models/project.dart';

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

  Stream<List<Project>> get projects {
    return projectsCollection(uid)
      .snapshots()
      .handleError((e) => debugPrint('query projects failed: $e'))
      .map((snapshot) => Project.fromQuery(snapshot));
  }

  Future<dynamic> saveProjectToFirestore(Project project) async {
    final collection = projectsCollection(uid);
    debugPrint('Saving ${project.id} to firestore');
    return project.id == null ? collection.add(project.toJson())
        : collection.document(project.id).updateData(project.toJson());
  }

  Future<dynamic> saveNoteToFirestore(Note note) async {
    final collection = notesCollection(uid);
    debugPrint('Saving ${note.id} to firestore');
    return note.id == null ? collection.add(note.toJson())
        : collection.document(note.id).updateData(note.toJson());
  }

  CollectionReference projectsCollection(String uid) {
    return Firestore.instance.collection('projects-$uid');
  }

  CollectionReference notesCollection(String uid) {
    return Firestore.instance.collection('notes-$uid');
  }
}