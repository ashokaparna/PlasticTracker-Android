import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        title: Text('Register'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _displayEmailInput(),
                _displayPasswordInput(),
                _displayRegisterButton(),
                _displayErrorText(),
              ],
            ),
          )),
    );
  }

  _displayEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Email',
            icon: Icon(Icons.email)),
        validator: (val) =>
            val.isEmpty || !val.contains('@') ? 'Enter an email' : null,
        onChanged: (val) {
          setState(() {
            email = val.trim();
          });
        },
      ),
    );
  }

  _displayPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Password',
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        validator: (val) =>
            val.length < 6 ? 'Enter a password 6+ chars long' : null,
        obscureText: _obscureText,
        onChanged: (val) {
          setState(() {
            password = val;
          });
        },
      ),
    );
  }

  _displayRegisterButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: ButtonTheme(
        minWidth: 200,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.blue[300],
          child: Text('Register', style: TextStyle(color: Colors.black)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              dynamic result =
                  await _auth.registerWithEmailAndPassword(email, password);
              String tempError = '';
              if (result.runtimeType == FirebaseAuthException) {
                if (result.code == 'weak-password') {
                  tempError = "password provided is too weak";
                } else if (result.code == 'email-already-in-use') {
                  tempError = "user id already exists";
                } else {
                  tempError = "unknown error";
                }
                setState(() {
                  error = tempError;
                });
              }
            }
          },
        ),
      ),
    );
  }

  _displayErrorText() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0)),
    );
  }
}
