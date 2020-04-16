import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/services/database.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/shared/nav_drawer.dart';
import 'package:productivityio/widget/global_stats.dart';
import 'package:productivityio/widget/total_stats.dart';
import 'package:productivityio/widget/work_time_chart.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final dbService = DatabaseService(uid: user.uid);
    return StreamProvider<List<Project>>.value(
      value: dbService.projects,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Dashboard')
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: boxDecoration,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('Global statistics', style: TextStyle(fontSize: 22)),
                      SizedBox(height: 16.0),
                      StreamProvider.value(
                          value: dbService.notes,
                          child: GlobalStats()
                      )
                    ],
                  ),
                ),
              ),
              TotalStats()
            ],
          ),
        ),
      ),
    );
  }
}
