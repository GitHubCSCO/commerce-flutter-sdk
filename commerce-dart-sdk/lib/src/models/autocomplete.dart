import 'models.dart';

part 'autocomplete.g.dart';

@JsonSerializable()
class Autocomplete extends BaseModel {
  List<AutocompleteProduct>? products;

  Autocomplete({this.products});

  factory Autocomplete.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteToJson(this);
}

@JsonSerializable()
class AutocompleteProduct extends BaseModel {
  String? id;

  String? title;

  String? subtitle;

  String? image;

  String? name;

  String? erpNumber;

  String? url;

  String? manufacturerItemNumber;

  bool? isNameCustomerOverride;

  String? brandName;

  String? brandDetailPagePath;

  String? binNumber;

  AutocompleteProduct({
    this.id,
    this.title,
    this.subtitle,
    this.image,
    this.name,
    this.erpNumber,
    this.url,
    this.manufacturerItemNumber,
    this.isNameCustomerOverride,
    this.brandName,
    this.brandDetailPagePath,
    this.binNumber,
  });

  factory AutocompleteProduct.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteProductFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteProductToJson(this);
}

@JsonSerializable()
class AutocompleteBrand extends BaseModel {
  String? id;

  String? title;

  String? subtitle;

  String? url;

  String? image;

  String? productLineId;

  String? productLineName;

  AutocompleteBrand({
    this.id,
    this.title,
    this.subtitle,
    this.url,
    this.image,
    this.productLineId,
    this.productLineName,
  });

  factory AutocompleteBrand.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteBrandFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteBrandToJson(this);
}

@JsonSerializable()
class AutocompleteCategory extends BaseModel {
  String? id;

  String? title;

  String? subtitle;

  String? url;

  String? image;

  AutocompleteCategory({
    this.id,
    this.title,
    this.subtitle,
    this.url,
    this.image,
  });

  factory AutocompleteCategory.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteCategoryToJson(this);
}
