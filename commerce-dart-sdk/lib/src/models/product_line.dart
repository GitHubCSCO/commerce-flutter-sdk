import 'models.dart';

part 'product_line.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductLine {
  ProductLine({
    this.count,
    this.id,
    this.name,
    this.selected,
  });

  String? id;

  String? name;

  int? count;

  bool? selected;

  factory ProductLine.fromJson(Map<String, dynamic> json) =>
      _$ProductLineFromJson(json);
  Map<String, dynamic> toJson() => _$ProductLineToJson(this);
}
