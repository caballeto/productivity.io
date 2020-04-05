import 'package:flutter/material.dart';
import 'package:productivityio/route/router.dart';
import 'package:productivityio/services/auth.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:productivityio/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: Router.createRoute,
        initialRoute: kWrapperRoute,
      ),
    );
  }
}

