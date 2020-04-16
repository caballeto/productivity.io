import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/screens/authenticate/authenticate.dart';
import 'package:productivityio/screens/dashboard/dashboard.dart';
import 'package:productivityio/screens/editor/note_editor.dart';
import 'package:productivityio/screens/home/home.dart';
import 'package:productivityio/screens/notes/notes.dart';
import 'package:productivityio/screens/projects/projects.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final String route;

  const Wrapper({Key key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      switch (route) {
        case kNotesRoute:
          return Notes();
        case kNoteEditorRoute:
          return NoteEditor();
        case kProjectsRoute:
          return Projects();
        case kDashboardRoute:
          return Dashboard();
        default:
          return Home();
      }
    }
  }
}
