import 'package:firebase_first/services/auth.dart';
import 'package:firebase_first/shared/constants.dart';
import 'package:firebase_first/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register(this.toggleView);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Register '),
              elevation: 0.0,
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Sign in"),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'E-Mail'),
                      validator: (val) => val!.isEmpty ? "Enter E-Mail" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val!.length < 6
                          ? "Enter Password with 6+ chars"
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.registerInWithEmail(email, password);
                          if (result == null) {
                            setState(
                              () {
                                error = 'There is some error';
                                loading = false;
                              },
                            );
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
