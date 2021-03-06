import 'package:flutter/material.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:plastic_tracker/screens/authenticate/authenticate.dart';
import 'package:plastic_tracker/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
