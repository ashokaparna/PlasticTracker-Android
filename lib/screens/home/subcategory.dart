
import 'package:flutter/material.dart';

class SubCategoryPage extends StatelessWidget {
  final String category;

  const SubCategoryPage({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subcats = ['Bottle1','Bottle2','Bottle3'];
    var iconsArray = [Icons.phone, Icons.photo_album, Icons.phone];

    final title = 'SubCategory List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(category),
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(iconsArray[0]),
              title: Text(subcats[0]),
            ),
            ListTile(
              leading: Icon(iconsArray[1]),
              title: Text(subcats[1]),
            ),
            ListTile(
              leading: Icon(iconsArray[2]),
              title: Text(subcats[2]),
            ),
          ],
        ),
      ),
    );
  }
}

