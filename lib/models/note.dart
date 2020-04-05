import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  String title;
  String content;
  NoteState state;
  final DateTime createdAt;
  DateTime modifiedAt;

  Note({
    this.id,
    this.title,
    this.content,
    this.state,
    DateTime createdAt,
    DateTime modifiedAt
  }) : this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  Note copy() => Note(
      id: id,
      title: title,
      content: content,
      state: state,
      createdAt: (createdAt == null ? DateTime.now() : createdAt),
      modifiedAt: modifiedAt
  );

  int get stateValue => (state ?? NoteState.unspecified).index;

  bool get isNotEmpty => title?.isNotEmpty == true || content?.isNotEmpty == true;

  @override
  bool operator ==(other) => other is Note &&
      (other.id ?? '') == (id ?? '') &&
      (other.title ?? '') == (title ?? '') &&
      (other.content ?? '') == (content ?? '') &&
      other.stateValue == stateValue;

  @override
  int get hashCode => id?.hashCode ?? super.hashCode;

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'state': stateValue,
    'createdAt': (createdAt ?? DateTime.now()).millisecondsSinceEpoch,
    'modifiedAt': (modifiedAt ?? DateTime.now()).millisecondsSinceEpoch
  };

  static List<Note> fromQuery(QuerySnapshot query) => query != null ? toNotes(query) : [];
}

enum NoteState {
  unspecified,
  deleted
}

List<Note> toNotes(QuerySnapshot query) => query.documents
    .map((e) => toNote(e))
    .where((e) => e != null && e.state != NoteState.deleted)
    .toList();

Note toNote(DocumentSnapshot doc) => doc.exists
    ? Note(
  id: doc.documentID,
  title: doc.data['title'],
  content: doc.data['content'],
  state: NoteState.values[doc.data['state'] ?? 0],
  createdAt: DateTime.fromMillisecondsSinceEpoch(doc.data['createdAt'] ?? 0),
  modifiedAt: DateTime.fromMillisecondsSinceEpoch(doc.data['modifiedAt'] ?? 0)
) : null;
