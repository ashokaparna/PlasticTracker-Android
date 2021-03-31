import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/screens/categories/subcategories.dart';
import 'package:plastic_tracker/shared/loading.dart';
import 'package:plastic_tracker/user/app_user.dart';

class PlasticInputCategories extends StatefulWidget {
  @override
  _PlasticInputCategoriesState createState() => _PlasticInputCategoriesState();
}

class _PlasticInputCategoriesState extends State<PlasticInputCategories> {
  List<Category> categories;
  final user = AppUser(uid: FirebaseAuth.instance.currentUser.uid);

  void initState(){
    super.initState();
    this._getCategories();
  }

  Future<void> _getCategories() async {
    APIClient client = new APIClient(user);
    var res = await client.getCategories();
    setState((){
      categories = res;
    });
  }

  @override
  Widget build(BuildContext context) {

    return categories == null ? Loading() : Scaffold(
        backgroundColor: Colors.blue.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.0),
          elevation: 0.0,
          leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop()
          ),
          title: Text('Categories'),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: EdgeInsets.all(20.0),
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
                              side: new BorderSide(color: Colors.white, width : 1.0)
                          ),
                          color: Colors.blue.withOpacity(0.9),
                          child: new Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Image.network(cat.icon, width: 100, height: 100,)),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(cat.name.toUpperCase(), textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
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
