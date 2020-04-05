import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/services/database.dart';
import 'package:provider/provider.dart';

class NoteEditor extends StatefulWidget {
  final Note note;

  const NoteEditor({Key key, this.note}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState(note);
}

class _NoteEditorState extends State<NoteEditor> {
  final Note _note;
  final Note _originNote;
  final TextEditingController _titleTextController;
  final TextEditingController _contentTextController;

  _NoteEditorState(Note note)
    : this._note = note ?? Note(),
    this._originNote = note?.copy() ?? Note(),
    this._titleTextController = TextEditingController(text: note?.title),
    this._contentTextController = TextEditingController(text: note?.content);

  bool get _isDirty => _note != _originNote;


  @override
  void initState() {
    super.initState();
    _titleTextController.addListener(() => _note.title = _titleTextController.text);
    _contentTextController.addListener(() => _note.content = _contentTextController.text);
  }


  @override
  void dispose() {
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final dbService = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        leading: BackButton(
          onPressed: () {
            if (_isDirty && (_note.id != null || _note.isNotEmpty)) {
              _note.modifiedAt = DateTime.now();
              dbService.saveNoteToFirestore(_note);
            }
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String action) {
              if (action == 'Delete') {
                _note.state = NoteState.deleted;
                dbService.saveNoteToFirestore(_note);
                Navigator.of(context).pop();
              } else {
                debugPrint('Invalid menu-item action.');
              }
            },
            itemBuilder: (context) {
              return popupActions.map((e) => PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              )).toList();
            },
          )
        ],
      ),
      backgroundColor: Colors.blue,
      body: DefaultTextStyle(
        style: TextStyle(
          fontSize: 18
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  style: TextStyle(fontSize: 18.0),
                  controller: _titleTextController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    counter: const SizedBox()
                  ),
                  maxLines: null,
                  maxLength: 1024,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _contentTextController,
                  decoration: const InputDecoration.collapsed(hintText: 'Note'),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> popupActions = const <String>['Delete'];