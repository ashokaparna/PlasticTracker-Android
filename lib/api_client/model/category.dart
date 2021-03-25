import 'package:json_annotation/json_annotation.dart';
import 'package:plastic_tracker/api_client/model/sub_category.dart';

part 'category.g.dart';

@JsonSerializable(anyMap: true)
class Category {
  Category({this.name, this.icon, this.subcategory});

  final String name;
  final String icon;
  final List<SubCategory> subcategory;

  factory Category.fromJson(Map json) => _$CategoryFromJson(json);

  static List<Category> fromJsonList(List<dynamic> jsonList) =>
      (jsonList).map((item) => Category.fromJson((item as Map))).toList();

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
