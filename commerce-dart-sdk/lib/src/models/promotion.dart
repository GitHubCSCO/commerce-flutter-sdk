import 'models.dart';

part 'promotion.g.dart';

@JsonSerializable()
class AddPromotion extends BaseModel {
  String? promotionCode;

  AddPromotion({this.promotionCode});

  factory AddPromotion.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionToJson(this);
}

@JsonSerializable()
class PromotionCollectionModel extends AddPromotion {
  List<Promotion>? promotions;

  PromotionCollectionModel({this.promotions});

  factory PromotionCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionCollectionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PromotionCollectionModelToJson(this);
}

@JsonSerializable()
class Promotion extends BaseModel {
  /// Gets or sets the id.
  String? id;

  /// Gets or sets the promotion code.
  String? promotionCode;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the amount.
  num? amount;

  /// Gets or sets the amount display.
  String? amountDisplay;

  /// Gets or sets a value indicating whether promotion applied.
  bool? promotionApplied;

  /// Gets or sets the message.
  String? message;

  /// Gets or sets the order line id.
  String? orderLineId;

  /// Gets or sets the promotion result type.
  String? promotionResultType;

  Promotion({
    this.id,
    this.promotionCode,
    this.name,
    this.amount,
    this.amountDisplay,
    this.promotionApplied,
    this.message,
    this.orderLineId,
    this.promotionResultType,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}
