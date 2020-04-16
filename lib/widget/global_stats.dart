import 'package:flutter/material.dart';
import 'package:productivityio/models/note.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/shared/utilities.dart';
import 'package:provider/provider.dart';

class GlobalStats extends StatefulWidget {
  @override
  _GlobalStatsState createState() => _GlobalStatsState();
}

class _GlobalStatsState extends State<GlobalStats> {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context) ?? [];
    final projects = Provider.of<List<Project>>(context) ?? [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.timer, size: 40.0),
              SizedBox(height: 10.0),
              Text('${formatDuration(time: getAllTime(projects), seconds: false)}')
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.view_list, size: 40.0),
              SizedBox(height: 10.0),
              Text('${projects.length} projects')
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Icon(Icons.create, size: 40.0),
              SizedBox(height: 10.0),
              Text('${notes.length} notes')
            ],
          ),
        ),
      ],
    );
  }
}
