import 'package:json_annotation/json_annotation.dart';

part 'custom_config.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomConfiguration {
  CustomConfiguration({
    this.newStringConfig,
    this.newBoolConfig,
  });

  String? newStringConfig;

  bool? newBoolConfig;

  factory CustomConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CustomConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$CustomConfigurationToJson(this);
}
