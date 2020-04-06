import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/screens/projects/add_project_form.dart';
import 'package:productivityio/services/database.dart';
import 'package:productivityio/shared/nav_drawer.dart';
import 'package:productivityio/widget/project_list.dart';
import 'package:provider/provider.dart';


class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    void _showAddProjectPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddProjectForm(),
        );
      },
      backgroundColor: Colors.blueGrey[100]);
    }

    final user = Provider.of<User>(context);
    return StreamProvider<List<Project>>.value(
      value: DatabaseService(uid: user.uid).projects,
      child: Scaffold(
        drawer: NavDrawer(),
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text('Projects'),
        ),
        body: ProjectList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showAddProjectPanel(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
