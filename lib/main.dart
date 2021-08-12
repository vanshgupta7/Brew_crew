import 'package:firebase_first/models/user.dart';
import 'package:firebase_first/screens/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_first/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
