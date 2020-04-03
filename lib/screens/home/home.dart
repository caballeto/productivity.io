import 'package:flutter/material.dart';
import 'package:productivityio/services/auth.dart';
import 'package:productivityio/shared/nav_drawer.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Menu'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              label: Text('logout',  style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Text('Congratulations! You have successfully authenticated!')
          ],
        ),
      ),
    );
  }
}
