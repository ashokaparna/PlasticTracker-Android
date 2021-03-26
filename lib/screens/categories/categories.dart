import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/categories/subcategories.dart';

class PlasticInputCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return MaterialApp(
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
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,

              ),

            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_right),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) =>
                    PlasticInputSubCategories()));
          },
        ),
      ),
    );
  }
}
