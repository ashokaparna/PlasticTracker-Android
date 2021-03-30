import 'package:flutter/material.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/api_client/model/sub_category.dart';
import 'package:plastic_tracker/user/app_user.dart';

class PlasticInputSubCategories extends StatefulWidget {
  final Category category;
  PlasticInputSubCategories({Key key, @required this.category}) : super(key: key);
  @override
  _PlasticInputSubCategoriesState createState() => _PlasticInputSubCategoriesState(subcategories: category.subcategory);
}

class _PlasticInputSubCategoriesState extends State<PlasticInputSubCategories> {
  List<SubCategory> subcategories;
  _PlasticInputSubCategoriesState({Key key, @required this.subcategories});
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.9),
        appBar: AppBar(
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop()
          ),
          title: Text('Sub-Categories'),

        ),
        body: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              for (final cat in subcategories)
                new GridTile(
                    child: new InkResponse (
                      onTap: () {
                        // Navigator.of(context).push(PageRouteBuilder(
                        //     opaque: false,
                        //     pageBuilder: (BuildContext context, _, __) =>
                        //         PlasticInputSubCategories(category: cat)));
                      },
                      child: new Card(
                          color: Colors.blue.withOpacity(0.9),
                          shape: new RoundedRectangleBorder(
                              side: new BorderSide(color: Colors.white)
                          ),
                          child: new Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Image.network(cat.icon, width: 100, height: 100)),
                                  Text(cat.name.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold,)),
                                ]
                            ),
                          )
                      ) ,
                    )),
            ]
        ),
      ),
    );
  }
}


