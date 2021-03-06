import 'package:flutter/material.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:plastic_tracker/screens/wrapper.dart';
import 'package:plastic_tracker/screens/authenticate/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StreamProvider<AppUser>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
