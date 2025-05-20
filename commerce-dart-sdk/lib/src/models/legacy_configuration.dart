import 'models.dart';

part 'legacy_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class LegacyConfiguration {
  LegacyConfiguration({
    this.hasDefaults,
    this.isKit,
    this.sections,
  });

  List<ConfigSection>? sections;

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
    this.options,
    this.sectionName,
    this.sortOrder,
  });

  String? sectionName;

  List<ConfigSectionOption>? options;

  // for V2
  String? id;

  int? sortOrder;

  factory ConfigSection.fromJson(Map<String, dynamic> json) =>
      _$ConfigSectionFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigSectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConfigSectionOption {
  ConfigSectionOption({
    this.description,
    this.id,
    this.name,
    this.price,
    this.productId,
    this.productName,
    this.quantity,
    this.sectionName,
    this.sectionOptionId,
    this.selected,
    this.sortOrder,
    this.userProductPrice,
  });

  String? sectionOptionId;

  String? sectionName;

  String? productName;

  String? productId;

  String? description;

  num? price;

  bool? userProductPrice;

  bool? selected;

  int? sortOrder;

  // for V2
  String? id;

  String? name;

  num? quantity;

  factory ConfigSectionOption.fromJson(Map<String, dynamic> json) =>
      _$ConfigSectionOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigSectionOptionToJson(this);
}
