import 'package:firebase_first/screens/authenticate/register.dart';
import 'package:firebase_first/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return SignIn(toggleView);
    } else {
      return Register(toggleView);
    }
  }
}
