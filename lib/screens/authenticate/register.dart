import 'package:flutter/material.dart';
import 'package:productivityio/services/auth.dart';
import 'package:productivityio/shared/constants.dart';
import 'package:productivityio/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Register into productivity.io'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => widget.toggleView(),
              icon: Icon(Icons.person),
              label: Text('Login')
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 15.0)
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Password have more than 6 characters' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      print(result);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign up with those credentials';
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Text('Or',
                    style: TextStyle(fontSize: 20)
                ),
                SizedBox(height: 20.0),
                _signInButton()
              ],
            ),
          )
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        dynamic result = await _auth.signInWithGoogle();
        if (result == null) {
          setState(() => error = 'Could not sign in with those credentials.');
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign In with Google',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
