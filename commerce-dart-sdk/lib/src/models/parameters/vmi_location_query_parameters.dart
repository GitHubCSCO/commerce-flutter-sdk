import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'vmi_location_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class BaseVmiLocationQueryParameters extends BaseQueryParameters {
  String? vmiLocationId;
  BaseVmiLocationQueryParameters({
    this.vmiLocationId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BaseVmiLocationQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiLocationQueryParameters extends BaseQueryParameters {
  String? userId;
  String? filter;
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  VmiLocationQueryParameters({
    this.userId,
    this.filter,
    this.expand = const [],
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiLocationQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiBinQueryParameters extends BaseVmiLocationQueryParameters {
  String? filter;
  String? searchCriteria;
  String? binNumberFrom;
  String? binNumberTo;
  DateTime? previousCountFromDate;
  DateTime? previousCountToDate;
  String expand;

  VmiBinQueryParameters({
    super.vmiLocationId,
    this.filter,
    this.searchCriteria,
    this.binNumberFrom,
    this.binNumberTo,
    this.previousCountFromDate,
    this.previousCountToDate,
    this.expand = '',
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiBinQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiCountQueryParameters extends BaseVmiLocationQueryParameters {
  String vmiBinId;

  VmiCountQueryParameters({
    required this.vmiBinId,
    super.page,
    super.pageSize,
    super.sort,
  }) : super(vmiLocationId: vmiBinId);

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiCountQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiNoteQueryParameters extends VmiCountQueryParameters {
  String? vmiNoteId;

  VmiNoteQueryParameters({
    required super.vmiBinId,
    this.vmiNoteId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiNoteQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiLocationDetailParameters extends BaseVmiLocationQueryParameters {
  List<String> expand;

  VmiLocationDetailParameters({
    required super.vmiLocationId,
    this.expand = const [],
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiLocationDetailParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiBinDetailParameters extends BaseVmiLocationQueryParameters {
  String vmiBinId;

  VmiBinDetailParameters({
    required super.vmiLocationId,
    required this.vmiBinId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiBinDetailParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiCountDetailParameters extends VmiBinDetailParameters {
  String vmiCountId;

  VmiCountDetailParameters({
    required super.vmiLocationId,
    required super.vmiBinId,
    required this.vmiCountId,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiCountDetailParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiNoteDetailParameters extends VmiBinDetailParameters {
  String vmiNoteId;

  VmiNoteDetailParameters({
    required super.vmiLocationId,
    required super.vmiBinId,
    required this.vmiNoteId,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiNoteDetailParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class VmiLocationProductParameters extends BaseVmiLocationQueryParameters {
  String searchCriteria;
  List<String> expand;
  String filter;

  VmiLocationProductParameters({
    required super.vmiLocationId,
    required this.searchCriteria,
    this.expand = const [],
    required this.filter,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$VmiLocationProductParametersToJson(this));
}
