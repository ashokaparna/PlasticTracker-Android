import 'package:flutter/material.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/screens/categories/subcategories.dart';
import 'package:plastic_tracker/shared/loading.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:provider/provider.dart';

class PlasticInputCategories extends StatefulWidget {
  @override
  _PlasticInputCategoriesState createState() => _PlasticInputCategoriesState();
}

class _PlasticInputCategoriesState extends State<PlasticInputCategories> {
  List<Category> categories;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    final user = Provider.of<AppUser>(context);
    setState(() {
      loading = true;
    });
     _getCategories(user);
    setState(() {
      loading = false;
    });
    return loading
        ? Loading()
        : MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.9),
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (final cat in categories)
           new GridTile(
             child: new InkResponse (
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        PlasticInputSubCategories(category: cat)));
              },
              child: new Card(
                borderOnForeground: true,

              shape: new RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.white)
              ),
              color: Colors.blue.withOpacity(0.9),
              child: new Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Expanded(child: Image.network(cat.icon, width: 100, height: 100,)),
                      Text(cat.name.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
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

   _getCategories(AppUser user) async {
    APIClient client = new APIClient(user);
    categories = await client.getCategories();

    for(final cat in categories)
      print(cat.icon);
  }
}



