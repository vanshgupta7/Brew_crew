import 'package:firebase_first/models/user.dart';
import 'package:firebase_first/services/database.dart';
import 'package:firebase_first/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_first/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentname = '';
  String _currentsuugar = '0';
  int _currentstrength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userdata = snapshot.data;
          return Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  "Update your settings",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userdata!.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please enter name' : null,
                  onChanged: (val) => setState(() => _currentname = val),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value:
                      _currentsuugar == '0' ? userdata.sugar : _currentsuugar,
                  items: sugars.map((val) {
                    return DropdownMenuItem(
                      child: Text("$val sugars"),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (val) =>
                      setState(() => _currentsuugar = val.toString()),
                ),
                SizedBox(height: 20),
                Slider(
                  value: (_currentstrength == 100
                          ? userdata.strength
                          : _currentstrength)
                      .toDouble(),
                  onChanged: (val) =>
                      setState(() => _currentstrength = val.round()),
                  activeColor: Colors.brown[_currentstrength],
                  inactiveColor: Colors.brown[_currentstrength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                ),
                RaisedButton(
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await DatabaseService(user.uid).updateUserData(
                          _currentsuugar == '0'
                              ? userdata.sugar
                              : _currentsuugar,
                          _currentname == '' ? userdata.name : _currentname,
                          _currentstrength == 100
                              ? userdata.strength
                              : _currentstrength);
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
