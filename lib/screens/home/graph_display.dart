import 'package:flutter/material.dart';
import 'package:plastic_tracker/data/graph_input.dart';
import 'package:plastic_tracker/data/plastic_category.dart';
import 'package:plastic_tracker/data/sample_data.dart';
import 'package:plastic_tracker/shared/get_total_weight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphTab extends StatefulWidget {
  @override
  _GraphTabState createState() => _GraphTabState();
}

class _GraphTabState extends State<GraphTab>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<GraphInput> plasticData = getTotalWeight(
      plasticSampleData.map((e) => new PlasticObject.fromJson(e)).toList());

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: new Color(0xFFF1F9FF),
            child: TabBar(
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.blue,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              controller: _controller,
              tabs: [
                Tab(
                  text: "DAILY",
                ),
                Tab(
                  text: "WEEKLY",
                ),
                Tab(
                  text: "MONTHLY",
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Container(
                    child: chart1(),
                  ),
                  Container(
                    child: Icon(Icons.graphic_eq),
                  ),
                  Container(
                    child: Icon(Icons.line_style),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  chart1() {
    return SfCartesianChart(
        primaryXAxis: DateTimeAxis(
            minimum: DateTime.now(),
            maximum: DateTime.now().subtract(Duration(days: 7)),
            isVisible: true,
            interval: 1,
            intervalType: DateTimeIntervalType.days,
            majorTickLines: MajorTickLines(size: 0.0),
            minorGridLines: MinorGridLines(width: 0.0),
            majorGridLines: MajorGridLines(width: 0.0)),
        primaryYAxis: NumericAxis(
            isVisible: false,
            majorTickLines: MajorTickLines(size: 0.0),
            minorGridLines: MinorGridLines(width: 0.0),
            majorGridLines: MajorGridLines(width: 0.0)),
        series: <ChartSeries>[
          ColumnSeries<GraphInput, DateTime>(
              color: new Color(0xFF7FC4FD),
              width: 0.4,
              enableTooltip: true,
              yAxisName: 'Weight in  grams',
              dataSource: plasticData,
              xValueMapper: (GraphInput gi, _) => gi.date,
              yValueMapper: (GraphInput gi, _) => gi.weight)
        ]);
  }
}
