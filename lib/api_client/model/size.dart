import 'package:json_annotation/json_annotation.dart';

part 'size.g.dart';

@JsonSerializable(anyMap: true)
class Size {
  Size({this.name, this.weight});

  final String name;
  final double weight;

  factory Size.fromJson(Map json) =>
      _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
