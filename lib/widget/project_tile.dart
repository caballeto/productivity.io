import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/screens/projects/project_view.dart';

class ProjectTile extends StatelessWidget {
  static final formatter = DateFormat('yyyy-MM-dd');

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
                if (project.name.isNotEmpty)
                  Text(project.name ?? '', style: TextStyle(fontSize: 19)),
                SizedBox(height: (project.name.isEmpty ? 0 : 14)),
                Text("Created at ${formatter.format(project.createdAt)}"),
                SizedBox(height: 14),
                Text("Worked for ${project.workedTime / (1000 * 60)} minutes")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
