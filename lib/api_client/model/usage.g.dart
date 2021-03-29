// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usage _$UsageFromJson(Map json) {
  return Usage(
    category: json['category'] as String,
    weight: (json['weight'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UsageToJson(Usage instance) => <String, dynamic>{
      'category': instance.category,
      'weight': instance.weight,
    };
