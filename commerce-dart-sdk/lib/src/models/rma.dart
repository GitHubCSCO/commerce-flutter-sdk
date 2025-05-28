import 'models.dart';

part 'rma.g.dart';

@JsonSerializable()
class Rma extends BaseModel {
  String? orderNumber;

  String? notes;

  String? message;

  List<RmaLine>? rmaLines;

  Rma({
    this.orderNumber,
    this.notes,
    this.message,
    this.rmaLines,
  });

  factory Rma.fromJson(Map<String, dynamic> json) => _$RmaFromJson(json);

  Map<String, dynamic> toJson() => _$RmaToJson(this);
}

@JsonSerializable()
class RmaLine {
  num? line;

  int? rmaQtyRequested;

  String? rmaReasonCode;

  RmaLine({
    this.line,
    this.rmaQtyRequested,
    this.rmaReasonCode,
  });

  factory RmaLine.fromJson(Map<String, dynamic> json) =>
      _$RmaLineFromJson(json);

  Map<String, dynamic> toJson() => _$RmaLineToJson(this);
}
