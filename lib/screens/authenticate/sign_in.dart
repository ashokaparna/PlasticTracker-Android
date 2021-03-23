import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/auth.dart';
import 'package:plastic_tracker/screens/home/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        title: Text('Sign In'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _displayGoogleLoginButton(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  ' - or - ',
                  style: TextStyle(color: Colors.grey),
                ),
                _displayEmailInput(),
                _displayPasswordInput(),
                _displaySignInButton(),
                _displayErrorText(),
              ],
            ),
          )),
    );
  }

  _displayEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Email',
            icon: Icon(Icons.email)),
        validator: (val) =>
            val.isEmpty || !val.contains('@') ? 'Enter a valid email id' : null,
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

  _displaySignInButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: ButtonTheme(
        minWidth: 200.0,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            highlightElevation: 0.0,
            color: Colors.blue[300],
            child: Text('Sign In', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dynamic result =
                    await _auth.signInWithEmailAndPassword(email, password);
                String tempError = '';
                if (result.runtimeType == FirebaseAuthException) {
                  if (result.code == 'user-not-found') {
                    tempError = 'User id does not exist';
                  } else if (result.code == 'wrong-password') {
                    tempError = "wrong password provided for user";
                  } else {
                    tempError = "unknown error";
                  }
                  setState(() {
                    error = tempError;
                  });
                }
              }
            }),
      ),
    );
  }

  _displayGoogleLoginButton() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: ButtonTheme(
        minWidth: 200.0,
        child: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          highlightElevation: 0.0,
          icon: Icon(Icons.email, color: Colors.white),
          onPressed: () async {
            dynamic result = await _auth.signInWithGoogle();
            if (result != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Home();
                },
              ));
            }
          },
          label: Text('Sign in with Google',
              style: TextStyle(color: Colors.white)),
          color: Colors.redAccent,
        ),
      ),
    );
  }

  _displayErrorText() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(error,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 14.0)),
    );
  }
}
