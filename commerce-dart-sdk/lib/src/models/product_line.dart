import 'models.dart';

part 'product_line.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductLine {
  ProductLine({
    this.id,
    this.name,
  });

  String? id;

  String? name;

  factory ProductLine.fromJson(Map<String, dynamic> json) =>
      _$ProductLineFromJson(json);
  Map<String, dynamic> toJson() => _$ProductLineToJson(this);
}
