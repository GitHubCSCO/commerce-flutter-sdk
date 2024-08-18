import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'custom_configuration.g.dart';

/// {@template custom_configuration}
/// CustomConfiguration description
/// {@endtemplate}
@JsonSerializable()
class CustomConfiguration extends Equatable {
  /// {@macro custom_configuration}
  const CustomConfiguration({ 
  required this.newStringConfig,
  required this.newBoolConfig,
  });

    /// Creates a CustomConfiguration from Json map
  factory CustomConfiguration.fromJson(Map<String, dynamic> data) => _$CustomConfigurationFromJson(data);

  /// A description for newStringConfig
  @JsonKey(name: 'newStringConfig')
  final String newStringConfig;

  /// A description for newBoolConfig
  @JsonKey(name: 'newBoolConfig')
  final bool newBoolConfig;

    /// Creates a copy of the current CustomConfiguration with property changes
  CustomConfiguration copyWith({ 
    String? newStringConfig,
    bool? newBoolConfig,
  }) {
    return CustomConfiguration(
      newStringConfig: newStringConfig ?? this.newStringConfig,
      newBoolConfig: newBoolConfig ?? this.newBoolConfig,
    );
  }


    @override
  List<Object?> get props => [
        newStringConfig,
        newBoolConfig,
      ];

    /// Creates a Json map from a CustomConfiguration
  Map<String, dynamic> toJson() => _$CustomConfigurationToJson(this);

    /// Creates a toString() override for CustomConfiguration
  @override
  String toString() => 'CustomConfiguration(newStringConfig: $newStringConfig, newBoolConfig: $newBoolConfig)';
}
