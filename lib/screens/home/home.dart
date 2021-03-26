import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plastic_tracker/screens/categories/categories.dart';
import 'package:plastic_tracker/screens/home/analytics.dart';

import 'package:plastic_tracker/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  // List<Widget> _widgetOptionOnTap = [
  //   Analytics(),
  //   PlasticCategories(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65.0,
        title: Text(
          'Plastic Tracker',
          style: TextStyle(
            color: new Color(0xFF2699FB),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          _signOutButton(context),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Analytics(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        mini: true,
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  PlasticInputCategories()));
        },
      ),
    );
  }

  _signOutButton(context) {
    return FlatButton.icon(
        minWidth: 10.0,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to exit?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          print("you choose no");
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _auth.signOut();
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ));
        },
        label: Text(''),
        icon: Icon(Icons.person));
  }
}
