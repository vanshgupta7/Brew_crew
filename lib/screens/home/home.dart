import 'package:firebase_first/models/brew.dart';
import 'package:firebase_first/models/user.dart';
import 'package:firebase_first/screens/home/brew_list.dart';
import 'package:firebase_first/screens/home/settings_form.dart';
import 'package:firebase_first/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_first/services/database.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    void showSetting() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(user!.uid).brewStream,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          actions: [
            FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            FlatButton.icon(
              onPressed: () => showSetting(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            )
          ],
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: BrewList(),
      ),
    );
  }
}
