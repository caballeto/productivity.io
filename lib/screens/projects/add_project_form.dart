import 'package:flutter/material.dart';
import 'package:productivityio/models/project.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/services/database.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:provider/provider.dart';

class AddProjectForm extends StatefulWidget {
  final Project project;

  AddProjectForm({Project project}) : this.project = project ?? Project();

  @override
  _AddProjectFormState createState() => _AddProjectFormState();
}

class _AddProjectFormState extends State<AddProjectForm> {
  final _formKey = GlobalKey<FormState>();

  String _projectName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Enter project settings'),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: widget.project?.name ?? '',
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _projectName = val),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.purple[400],
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white)
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  widget.project.name = _projectName;
                  await DatabaseService(uid: user.uid)
                      .saveProjectToFirestore(widget.project);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      );
  }
}
