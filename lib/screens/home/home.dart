import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plastic_tracker/screens/categories/categories.dart';
import 'package:plastic_tracker/api_client/client.dart';
import 'package:plastic_tracker/api_client/model/category.dart';
import 'package:plastic_tracker/api_client/model/usage.dart';
import 'package:plastic_tracker/screens/home/analytics.dart';
import 'package:plastic_tracker/services/auth.dart';
import 'package:plastic_tracker/user/app_user.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  // List<Widget> _widgetOptionOnTap = [
  //   Analytics(),
  //   PlasticCategories(),
  // ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65.0,
        title: Text(
          'Plastic Tracker',
          style: TextStyle(
            color: new Color(0xFF2699FB),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          _signOutButton(context),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Analytics(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        mini: true,
        onPressed: () async {
          _testApiClient(user);
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  PlasticInputCategories()));
        },
      ),
    );
  }

  _signOutButton(context) {
    return FlatButton.icon(
        minWidth: 10.0,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to exit?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          print("you choose no");
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _auth.signOut();
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ));
        },
        label: Text(''),
        icon: Icon(Icons.person));
  }

  // TODO: For reference only. Remove after actual implementation is in place.
  _testApiClient(AppUser user) async {
    APIClient client = new APIClient(user);
    Usage usage = new Usage(category: "Bottles", weight: 10.0);
    await client.addUsage(usage);
    List<Category> categories = await client.getCategories();
    Map<String, List<Usage>> weeklyUsages = await client.getWeeklyUsages();
    Map<String, List<Usage>> monthlyUsages = await client.getMonthlyUsages();
    Map<String, List<Usage>> dailyUsages = await client.getDailyUsages();
  }
}
