// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'models.dart';

part 'add_cart_model.g.dart';

@JsonSerializable()
class AddCartModel {
  String? billToId;

  String? shipToId;

  String? notes;

  String? vmiLocationId;

  AddCartModel({
    this.billToId,
    this.shipToId,
    this.notes,
    this.vmiLocationId,
  });

  factory AddCartModel.fromJson(Map<String, dynamic> json) =>
      _$AddCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartModelToJson(this);
}
