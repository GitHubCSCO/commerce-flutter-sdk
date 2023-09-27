import 'package:json_annotation/json_annotation.dart';

part 'base_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class BaseQueryParameters {
  int? page;
  int? pageSize;
  String? sort;

  Map<String, dynamic> toJson() => _$BaseQueryParametersToJson(this);
}
