import 'package:firebase_first/models/user.dart';
import 'package:firebase_first/screens/authenticate/authenticate.dart';
import 'package:firebase_first/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
