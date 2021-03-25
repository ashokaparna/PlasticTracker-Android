import 'package:json_annotation/json_annotation.dart';

part 'usage.g.dart';

@JsonSerializable(anyMap: true)
class Usage {
  Usage({this.category, this.weight});

  String category;
  double weight;

  factory Usage.fromJson(Map json) =>
      json == null ? Usage() : _$UsageFromJson(json);

  static List<Usage> fromJsonList(List<dynamic> jsonList) =>
      (jsonList).map((item) => Usage.fromJson((item as Map))).toList();

  static Map<String, List<Usage>> fromJsonMap(Map json) {
    Map<String, List<Usage>> map = Map();
    json.entries.forEach((element) {
      map[element.key] = Usage.fromJsonList(element.value);
    });
    return map;
  }

  Map<String, dynamic> toJson() => _$UsageToJson(this);

  static List<Map<String, dynamic>> toJsonList(List<Usage> usages) =>
      usages.map((e) => e.toJson()).toList();
}
