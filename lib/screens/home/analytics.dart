import 'package:flutter/material.dart';
import 'package:plastic_tracker/data/plastic_category.dart';
import 'package:plastic_tracker/data/sample_data.dart';
import 'package:plastic_tracker/screens/home/graph_display.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  List<PlasticObject> plasticData =
      plasticSampleData.map((psd) => new PlasticObject.fromJson(psd)).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(flex: 2, child: GraphTab()),
        Expanded(child: _plasticListView(plasticData)),
        // FutureBuilder<List<PlasticObject>>(
        //     future: plastic_data,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         List<PlasticObject> data = snapshot.data;
        //         return _plasticListView(data);
        //       } else if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       }
        //       return CircularProgressIndicator();
        //     })
      ],
    ));
  }

  _plasticListView(data) {
    return ListView.separated(
        itemCount: (data == null) ? 0 : data.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return _tile(data[index].subCategory, data[index].weight);
        });
  }

  _tile(String subCategory, int weight) => ListTile(
        title: Text(subCategory,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            )),
        subtitle: Text('Weight : ' + weight.toString() + 'g'),
        leading: Icon(
          Icons.circle,
          size: 20.0,
          color: Colors.blue[500],
        ),
      );
}
