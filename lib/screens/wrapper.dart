import 'package:flutter/material.dart';
import 'package:productivityio/models/user.dart';
import 'package:productivityio/screens/authenticate/authenticate.dart';
import 'package:productivityio/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
