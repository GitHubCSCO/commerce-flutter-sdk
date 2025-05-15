import 'package:json_annotation/json_annotation.dart';

part 'sort_options.g.dart';

@JsonSerializable()
class SortOption {
  String? displayName;
  String? sortType;

  SortOption({
    this.displayName,
    this.sortType,
  });

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      _$SortOptionFromJson(json);
  Map<String, dynamic> toJson() => _$SortOptionToJson(this);
}
