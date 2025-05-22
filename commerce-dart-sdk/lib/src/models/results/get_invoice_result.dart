import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'get_invoice_result.g.dart';

@JsonSerializable()
class GetInvoiceResult extends BaseModel {
  Pagination? pagination;

  List<Invoice>? invoices;

  GetInvoiceResult({
    this.pagination,
    this.invoices,
  });

  factory GetInvoiceResult.fromJson(Map<String, dynamic> json) =>
      _$GetInvoiceResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvoiceResultToJson(this);
}
