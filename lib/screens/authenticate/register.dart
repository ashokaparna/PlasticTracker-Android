import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tracker/services/auth.dart';
import 'package:plastic_tracker/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool _obscureText = true;
  String username = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(children: <Widget>[
                  _displayScreenText(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _displayUsernameInput(),
                        _displayEmailInput(),
                        _displayPasswordInput(),
                        _displayRegisterButton(),
                        _displayErrorText(),
                      ],
                    ),
                  ),
                ])),
          );
  }

  _displayScreenText() {
    return Padding(
        padding: EdgeInsets.only(top: 125.0),
        child: Text('Create an Account',
            style: TextStyle(
              color: new Color(0xFF2699FB),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )));
  }

  _displayUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 80.0),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: new Color(0xFF7FC4FD)),
            hintText: 'Username',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            )),
        validator: (val) => val.isEmpty ? 'Enter a username' : null,
        onChanged: (val) {
          setState(() {
            username = val.trim();
          });
        },
      ),
    );
  }

  _displayEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: new Color(0xFF7FC4FD)),
            hintText: 'Email',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            )),
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
            hintStyle: TextStyle(color: new Color(0xFF7FC4FD)),
            hintText: 'Password',
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
                  Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            ),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: new Color(0xFF2699FB)),
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
            )),
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
      child: FlatButton(
        minWidth: 300.0,
        height: 50.0,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4.0)),
        color: new Color(0xFF2699FB),
        child: Text('REGISTER',
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
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
                loading = false;
              });
            } else {
              _auth.addUserToDb(
                  FirebaseAuth.instance.currentUser.uid, email, username);
            }
          }
        },
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
