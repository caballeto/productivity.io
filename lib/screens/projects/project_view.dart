import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/models/work_interval.dart';
import 'package:productivityio/services/database.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/shared/utilities.dart';
import 'package:productivityio/widget/work_time_chart.dart';
import 'package:provider/provider.dart';

class ProjectView extends StatefulWidget {
  final Project project;

  ProjectView({ this.project });

  @override
  _ProjectViewState createState() => _ProjectViewState(project: project);
}

class _ProjectViewState extends State<ProjectView> {
  static final formatter = DateFormat.yMMMMd('en_US');

  final Project project;
  final Stopwatch _timer_watch;
  
  Timer _timer;
  
  int _start;
  int _end;
  int _elapsedTime;

  _ProjectViewState({ this.project }) 
      : this._timer_watch = Stopwatch(),
        this._elapsedTime = 0;

  bool get _wasTracked => _timer_watch != null && _timer_watch.elapsedMilliseconds > 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final dbService = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
        leading: BackButton(
          onPressed: () {
            if (_wasTracked) {
              project.workedTime += _timer_watch.elapsedMilliseconds;
              dbService.saveProjectToFirestore(project);
            }
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: boxDecoration,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(project.name, style: TextStyle(fontSize: 22)),
                    SizedBox(height: 14.0),
                    Text("Created on ${formatter.format(project.createdAt)}",
                        style: TextStyle(
                          fontSize: 17,
                        )
                    ),
                    SizedBox(height: 16.0),
                    Text('${_formatTimer(Duration(milliseconds: _elapsedTime))}', style: TextStyle(fontSize: 16),),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton.icon(
                          label: Text('Track', style: TextStyle(color: Colors.white)),
                          color: Colors.blue[400],
                          onPressed: () async {
                            if (!_timer_watch.isRunning) {
                              _start = DateTime.now().millisecondsSinceEpoch;
                              _timer_watch.start();
                              _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
                                setState(() {
                                  _elapsedTime = _timer_watch.elapsedMilliseconds;
                                });
                              });
                            }
                          },
                          icon: IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                        FlatButton.icon(
                          label: Text('Stop', style: TextStyle(color: Colors.white)),
                          color: Colors.red[400],
                          onPressed: () async {
                            if (_timer_watch.isRunning) {
                              _end = DateTime.now().millisecondsSinceEpoch;
                              project.intervals.add(WorkInterval(start: _start, end: _end));
                              project.workedTime += _timer_watch.elapsedMilliseconds;
                              dbService.saveProjectToFirestore(project);
                              _timer_watch.stop();
                              _timer_watch.reset();
                              _timer.cancel();
                            }
                          },
                          icon: IconTheme(
                            data: IconThemeData(color: Colors.white),
                            child: Icon(Icons.stop),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),// summary and chart
            child: Container(
              decoration: boxDecoration,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text('Stats', style: TextStyle(fontSize: 22)),
                    SizedBox(height: 16.0),
                    Text('${formatDuration(time: project.workedTime)}', style: TextStyle(fontSize: 16.0),),
                    SizedBox(height: 16.0),
                    SizedBox(
                        height: 200.0,
                        child: WorkTimeChart(project.intervals)
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  String _formatTimer(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}
