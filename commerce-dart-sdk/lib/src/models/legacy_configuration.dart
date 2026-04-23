import 'models.dart';

part 'legacy_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class LegacyConfiguration {
  LegacyConfiguration({
    this.configSections,
    this.hasDefaults,
    this.isKit,
  });

  List<ConfigSection>? configSections;

  bool? hasDefaults;

  bool? isKit;

  factory LegacyConfiguration.fromJson(Map<String, dynamic> json) =>
      _$LegacyConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$LegacyConfigurationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConfigSection {
  ConfigSection({
    this.id,
    this.sectionName,
    this.label,
    this.sortOrder,
    this.sectionOptions,
  });

  String? id;

  String? sectionName;

  String? label;

  int? sortOrder;

  List<ConfigSectionOption>? sectionOptions;

  factory ConfigSection.fromJson(Map<String, dynamic> json) =>
      _$ConfigSectionFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConfigSectionOption {
  ConfigSectionOption({
    this.id,
    this.productId,
    this.name,
    this.description,
    this.price,
    this.selected,
    this.sortOrder,
    this.quantity,
    this.cantBuy,
  });

  String? id;

  String? productId;

  String? name;

  String? description;

  num? price;

  bool? selected;

  int? sortOrder;

  num? quantity;

  bool? cantBuy;

  factory ConfigSectionOption.fromJson(Map<String, dynamic> json) =>
      _$ConfigSectionOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigSectionOptionToJson(this);
}
