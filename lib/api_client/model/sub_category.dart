import 'package:json_annotation/json_annotation.dart';
import 'package:plastic_tracker/api_client/model/size.dart';

part 'sub_category.g.dart';

@JsonSerializable(anyMap: true)
class SubCategory {
  SubCategory({this.name, this.icon, this.defaultWeight, this.sizes});

  final String name;
  final String icon;
  final double defaultWeight;
  final List<Size> sizes;

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
