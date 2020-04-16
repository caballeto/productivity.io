import 'package:flutter/material.dart';
import 'package:productivityio/screens/notes/notes.dart';
import 'package:productivityio/services/auth.dart';
import 'package:productivityio/shared/constants.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(kDashboardRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Projects'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(kProjectsRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Notes'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(kNotesRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
