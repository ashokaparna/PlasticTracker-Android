import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/register.dart';
import 'package:plastic_tracker/screens/authenticate/sign_in.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptionOnTap = <Widget>[SignIn(), Register()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptionOnTap.elementAt(_selectedIndex),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            this._selectedIndex = index;
          });
        },
        activeColor: new Color(0xFF2699FB),
        items: [
          BottomNavigationBarItem(
              label: "Sign-In",
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
