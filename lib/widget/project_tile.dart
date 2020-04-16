import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/screens/projects/project_view.dart';
import 'package:productivityio/shared/utilities.dart';

class ProjectTile extends StatelessWidget {
  static final formatter = DateFormat.yMMMMd('en_US');

  final Project project;

  ProjectTile({ this.project });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProjectView(project: project)
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Color(0xFFDADCE0))
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(formatTitle(title: project.name), style: TextStyle(fontSize: 19),),
                    Text(formatter.format(project.createdAt) ?? '')
                  ],
                ),
                SizedBox(height: 14),
                Text("Worked for ${formatDuration(time: project.workedTime)}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
