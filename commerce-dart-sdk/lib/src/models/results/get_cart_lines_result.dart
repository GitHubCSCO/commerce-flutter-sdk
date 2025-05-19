import '../models.dart';

part 'get_cart_lines_result.g.dart';

@JsonSerializable()
class GetCartLinesResult extends BaseModel {
  List<CartLine>? cartLines;

  GetCartLinesResult({this.cartLines});
  factory GetCartLinesResult.fromJson(Map<String, dynamic> json) =>
      _$GetCartLinesResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCartLinesResultToJson(this);
}
