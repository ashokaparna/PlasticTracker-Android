import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Plastic Tracker'),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        actions: <Widget>[
          FloatingActionButton(
            child: Text('Sign Out'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
