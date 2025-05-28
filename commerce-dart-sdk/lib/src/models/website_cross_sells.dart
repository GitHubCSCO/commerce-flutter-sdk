import 'models.dart';

part 'website_cross_sells.g.dart';

@JsonSerializable()
class WebsiteCrosssells extends BaseModel {
  List<Product>? products;

  WebsiteCrosssells({this.products});

  factory WebsiteCrosssells.fromJson(Map<String, dynamic> json) =>
      _$WebsiteCrosssellsFromJson(json);

  Map<String, dynamic> toJson() => _$WebsiteCrosssellsToJson(this);
}
