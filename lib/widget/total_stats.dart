import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/work_interval.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/shared/utilities.dart';
import 'package:productivityio/widget/work_time_chart.dart';
import 'package:provider/provider.dart';

class TotalStats extends StatefulWidget {
  @override
  _TotalStatsState createState() => _TotalStatsState();
}

class _TotalStatsState extends State<TotalStats> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>>(context) ?? [];
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: boxDecoration,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Stats', style: TextStyle(fontSize: 22)),
              SizedBox(height: 16.0),
              Text('${formatDuration(time: getAllTime(projects))}', style: TextStyle(fontSize: 16.0),),
              SizedBox(height: 16.0),
              SizedBox(
                  height: 200.0,
                  child: WorkTimeChart(getAllIntervals(projects))
              )
            ],
          ),
        ),
      ),
    );
  }
}
