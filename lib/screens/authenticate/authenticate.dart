import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/register.dart';
import 'package:plastic_tracker/screens/authenticate/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int index = 0;

  List<Widget> _widgetOptionOnTap = <Widget>[SignIn(), Register()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptionOnTap.elementAt(index),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.blue[700],
        currentIndex: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              label: "Log-In",
              icon: Icon(
                Icons.login,
              )),
          BottomNavigationBarItem(
              label: "Register", icon: Icon(Icons.person_add)),
        ],
      ),
    );
  }
}
