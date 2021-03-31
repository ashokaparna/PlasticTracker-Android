import 'package:flutter/material.dart';
import 'package:plastic_tracker/screens/home/graph_display.dart';
import 'package:plastic_tracker/screens/home/usage_list_display.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(flex: 1, child: GraphTab()),
        Container(height: 5, color: Colors.blue.shade100,),
        Expanded(child: PlasticUsageList()),
      ],
    ));
  }
}
