import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:plastic_tracker/data/plastic_category.dart';

class PlasticBarChart extends StatelessWidget {
  final List<PlasticObject> data;

  PlasticBarChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PlasticObject, DateTime>> series = [
      charts.Series(
        data: data,
        id: 'PlasticUsage',
        domainFn: (PlasticObject ser, _) => ser.date,
        measureFn: (PlasticObject ser, _) => ser.weight,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      defaultInteractions: false,
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }
}
