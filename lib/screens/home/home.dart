import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/authenticate/auth.dart';
import 'package:plastic_tracker/screens/home/subcategory.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  var arr = ['Bottles','Bags','Cups'];
  var iconsArray = [Icons.phone, Icons.photo_album, Icons.phone];

  @override
  Widget build(BuildContext context) {
    final title = 'Category List';
    return MaterialApp(
      title: title,
      home: Scaffold(
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
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(iconsArray[0]),
              title: Text(arr[0]),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubCategoryPage(category: arr[0])),
                );
              },
            ),
            ListTile(
              leading: Icon(iconsArray[1]),
              title: Text(arr[1]),
            ),
            ListTile(
              leading: Icon(iconsArray[2]),
              title: Text(arr[2]),
            ),
          ],
        ),
      ),
    );
  }
}
