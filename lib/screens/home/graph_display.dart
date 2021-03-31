import 'package:flutter/material.dart';
import 'package:plastic_tracker/data/graph_input.dart';
import 'package:plastic_tracker/data/get_total_weight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraphTab extends StatefulWidget {
  @override
  _GraphTabState createState() => _GraphTabState();
}

class _GraphTabState extends State<GraphTab>
    with SingleTickerProviderStateMixin {
  List<GraphInput> dailyGraphData;
  List<GraphInput> weeklyGraphData;
  List<GraphInput> monthlyGraphData;
  TabController _controller;
  TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    super.initState();
    this._getDailyInput();
    this._getWeeklyInput();
    this._getMonthlyInput();
    _controller = new TabController(length: 3, vsync: this);
    _tooltipBehavior = TooltipBehavior(
        header: 'Date : Weight(g)',
        enable: true,
        borderColor: Colors.white,
        tooltipPosition: TooltipPosition.pointer,
        borderWidth: 2,
        color: Colors.lightBlue);
  }

  Future<void> _getDailyInput() async {
    var res = await getDailyGraphInput();
    setState(() {
      dailyGraphData = res;
    });
  }
  Future<void> _getWeeklyInput() async {
    var res = await getWeeklyGraphInput();
    setState(() {
      weeklyGraphData = res;
    });
  }
  Future<void> _getMonthlyInput() async {
    var res = await getMonthlyGraphInput();
    setState(() {
      monthlyGraphData = res;
    });
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
                    child: chart2(),
                  ),
                  Container(
                    child: chart3(),
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
    return  SfCartesianChart(
        legend: Legend(
          height: '15.0',
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis:CategoryAxis(
          isVisible: true,
          interval: 1,
          majorTickLines: MajorTickLines(size: 0.0),
          minorGridLines: MinorGridLines(width: 0.0),
            majorGridLines: MajorGridLines(width: 0.0),
        ),
        primaryYAxis: NumericAxis(
            isVisible: false
        ),
        series: <ChartSeries>[
          ColumnSeries<GraphInput, String>(
              borderColor: Colors.grey[500],
              borderWidth:1.5,
              color: new Color(0xFF7FC4FD),
              width: 0.8,
              enableTooltip: true,
              name: 'Weight (grams)',
              dataLabelSettings: DataLabelSettings(
                textStyle : TextStyle(color: Colors.black, ),
                offset: Offset(0,-5),
                  isVisible: true
              ),
              dataSource: dailyGraphData,
              xValueMapper: (GraphInput gi, _) => getDailyDate(gi.date),
              yValueMapper: (GraphInput gi, _) => gi.weight)
        ]);
  }

  getDailyDate(String strDate){
    DateTime date = DateFormat('yyyy_M_d').parse(strDate);
    return DateFormat('E, d').format(date);
  }

  chart2() {
    return SfCartesianChart(
        legend: Legend(
          height: '15.0',
            isVisible: true,
            position: LegendPosition.bottom,
        ),
        tooltipBehavior: _tooltipBehavior,
      primaryXAxis:CategoryAxis(
        isVisible: true,
        interval: 1,
        majorTickLines: MajorTickLines(size: 0.0),
        minorGridLines: MinorGridLines(width: 0.0),
        majorGridLines: MajorGridLines(width: 0.0),
      ),
      primaryYAxis: NumericAxis(
          isVisible: false,
      ),
        series: <ChartSeries>[
          ColumnSeries<GraphInput, String>(
              borderColor: Colors.grey[500],
              borderWidth:1.5,
              name: 'Weight (grams)',
              color: new Color(0xFF7FC4FD),
              width: 0.6,
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                  textStyle : TextStyle(color: Colors.black,),
                  offset: Offset(0,-5),
                  isVisible: true
              ),
              dataSource: weeklyGraphData,
              xValueMapper: (GraphInput gi, _) => getWeeklyDate(gi.date),
              yValueMapper: (GraphInput gi, _) => gi.weight)
        ]);
  }

  getWeeklyDate(String strDate){
    var lst = strDate.split('_');
    return "WEEK : " + lst[1];
  }

  chart3() {
    return SfCartesianChart(
        legend: Legend(
          height: '15.0',
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: _tooltipBehavior,
      primaryXAxis:CategoryAxis(
        isVisible: true,
        interval: 1,
        majorTickLines: MajorTickLines(size: 0.0),
        minorGridLines: MinorGridLines(width: 0.0),
        majorGridLines: MajorGridLines(width: 0.0),
      ),
      primaryYAxis: NumericAxis(
          isVisible: false,
    ),
        series: <ChartSeries>[
          ColumnSeries<GraphInput, String>(
              borderColor: Colors.grey[500],
              borderWidth:1.5,
              name: 'Weight (grams)',
              color: new Color(0xFF7FC4FD),
              width: 0.8,
              enableTooltip: true,
              dataLabelSettings: DataLabelSettings(
                  textStyle : TextStyle(color: Colors.black,),
                  offset: Offset(0,-5),
                  isVisible: true
              ),
              dataSource: monthlyGraphData,
              xValueMapper: (GraphInput gi, _) => getMonthlyDate(gi.date),
              yValueMapper: (GraphInput gi, _) => gi.weight)
        ]);
  }

  getMonthlyDate(String strDate){
    DateTime date = DateFormat('yyyy_M').parse(strDate);
    return DateFormat('MMM, yy').format(date);
  }


}
