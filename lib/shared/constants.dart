import 'package:flutter/material.dart';

const kWrapperRoute = '/';
const kAuthRoute = '/auth';
const kNotesRoute = '/notes';
const kNoteEditorRoute = '/note_editor';
const kProjectsRoute = '/projects';
const kDashboardRoute = '/dashboard';

final boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    border: Border.all(color: Color(0xFFDADCE0))
);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
  ),
);