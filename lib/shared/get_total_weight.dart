import 'dart:collection';
import 'package:plastic_tracker/data/graph_input.dart';
import 'package:plastic_tracker/data/plastic_category.dart';

List<GraphInput> getTotalWeight(List<PlasticObject> list) {
  HashMap<DateTime, GraphInput> map = HashMap<DateTime, GraphInput>();
  // ignore: unused_local_variable
  for (PlasticObject p in list) {
    map.update(
        p.date,
        (graphInput) => new GraphInput(
            date: p.date, weight: (graphInput.getWeight() + p.weight)),
        ifAbsent: () => new GraphInput(date: p.date, weight: p.weight));
  }

  return map.values.toList();
}
