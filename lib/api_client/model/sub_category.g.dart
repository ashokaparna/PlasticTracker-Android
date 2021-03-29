// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategory _$SubCategoryFromJson(Map json) {
  return SubCategory(
    name: json['name'] as String,
    icon: json['icon'] as String,
    defaultWeight: (json['defaultWeight'] as num)?.toDouble(),
    sizes: (json['sizes'] as List)
        ?.map((e) => e == null ? null : Size.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'defaultWeight': instance.defaultWeight,
      'sizes': instance.sizes,
    };
