import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tracker/services/auth.dart';
import 'package:plastic_tracker/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool _obscureText = true;
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
                child: Column(
                  children: <Widget>[
                    _displayScreenText(),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _displayEmailInput(),
                          _displayPasswordInput(),
                          _displaySignInButton(),
                          _displayErrorText(),
                        ],
                      ),
                    ),
                  ],
                )));
  }

  _displayScreenText() {
    return Padding(
        padding: EdgeInsets.only(top: 125.0),
        child: Text('Sign In',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: new Color(0xFF2699FB),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )));
  }

  _displayEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 80.0),
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
          hintStyle: TextStyle(color: new Color(0xFF7FC4FD)),
          hintText: 'Password',
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
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
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
      child: FlatButton(
          minWidth: 300.0,
          height: 50.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4.0)),
          color: new Color(0xFF2699FB),
          child: Text('SIGN IN',
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              setState(() => loading = true);
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
                  loading = true;
                });
              }
            }
          }),
    );
  }

  // _displayGoogleLoginButton() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 100),
  //     child: ButtonTheme(
  //       minWidth: 200.0,
  //       child: RaisedButton.icon(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(40.0),
  //         ),
  //         highlightElevation: 0.0,
  //         icon: Icon(Icons.email, color: Colors.white),
  //         onPressed: () async {
  //           dynamic result = await _auth.signInWithGoogle();
  //           if (result != null) {
  //             Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) {
  //                 return Home();
  //               },
  //             ));
  //           }
  //         },
  //         label: Text('Sign in with Google',
  //             style: TextStyle(color: Colors.white)),
  //         color: Colors.redAccent,
  //       ),
  //     ),
  //   );
  // }

  _displayErrorText() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(error,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 14.0)),
    );
  }
}
