// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Size _$SizeFromJson(Map json) {
  return Size(
    name: json['name'] as String,
    weight: (json['weight'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
    };
