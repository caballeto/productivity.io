import 'package:flutter/material.dart';
import 'package:productivityio/screens/authenticate/authenticate.dart';
import 'package:productivityio/screens/editor/note_editor.dart';
import 'package:productivityio/screens/home/notes.dart';
import 'package:productivityio/screens/wrapper.dart';
import 'package:productivityio/shared/constants.dart';

class Router {
  static Route<dynamic> createRoute(RouteSettings settings) {
    debugPrint(settings.name);
    switch (settings.name) {
      case kWrapperRoute:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case kAuthRoute:
        return MaterialPageRoute(builder: (_) => Authenticate());
      case kNotesRoute:
        return MaterialPageRoute(builder: (_) => Notes());
      case kNoteEditorRoute:
        return MaterialPageRoute(builder: (_) => NoteEditor());
      default:
        return MaterialPageRoute(builder: (_) => Wrapper());
    }
  }
}