import 'package:flutter/material.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/api_client/model/sub_category.dart';
import 'package:plastic_tracker/screens/categories/usage_input.dart';

class PlasticInputSubCategories extends StatefulWidget {
  final Category category;
  PlasticInputSubCategories({Key key, @required this.category}) : super(key: key);
  @override
  _PlasticInputSubCategoriesState createState() => _PlasticInputSubCategoriesState(category: category, subcategories: category.subcategory);
}

class _PlasticInputSubCategoriesState extends State<PlasticInputSubCategories> {
  Category category;
  List<SubCategory> subcategories;
  // ignore: unused_element
  _PlasticInputSubCategoriesState({Key key, this.category, @required this.subcategories});
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.0),
          elevation: 0.0,
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
            padding: EdgeInsets.all(20.0),
            children: [
              for (final cat in subcategories)
                new GridTile(
                    child: new InkResponse (
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                            PlasticInputUsage(subcategory: cat, category: category,)));
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(cat.name.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold,)),
                                  ),
                                ]
                            ),
                          )
                      ) ,
                    )),
            ]
        ),
      );
  }
}
