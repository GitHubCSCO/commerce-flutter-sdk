part of 'custom_configuration.dart';

CustomConfiguration _$CustomConfigurationFromJson(Map<String, dynamic> json) => CustomConfiguration(
      newStringConfig: json['newStringConfig'] as String,
      newBoolConfig: json['newBoolConfig'] as bool,
    );

Map<String, dynamic> _$CustomConfigurationToJson(CustomConfiguration instance) => <String, dynamic>{ 
      'newStringConfig': instance.newStringConfig,
      'newBoolConfig': instance.newBoolConfig,
    };