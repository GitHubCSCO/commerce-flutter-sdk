import 'models.dart';

part 'salesperson_list_dto.g.dart';

@JsonSerializable()
class SalespersonListDto extends BaseModel {
  String? name;

  String? salespersonNumber;

  SalespersonListDto({
    this.name,
    this.salespersonNumber,
  });

  factory SalespersonListDto.fromJson(Map<String, dynamic> json) =>
      _$SalespersonListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SalespersonListDtoToJson(this);
}
