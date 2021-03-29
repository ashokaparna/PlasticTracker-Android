// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map json) {
  return Category(
    name: json['name'] as String,
    icon: json['icon'] as String,
    subcategory: (json['subcategory'] as List)
        ?.map((e) => e == null
            ? null
            : SubCategory.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'subcategory': instance.subcategory,
    };
