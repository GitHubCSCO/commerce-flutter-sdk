import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaymentSummaryEntity {
  final Cart? cart;
  final CartSettings? cartSettings;
  final PromotionCollectionModel? promotions;
  final bool isCustomerOrderApproval;

  PaymentSummaryEntity({
    this.cart,
    required this.cartSettings,
    required this.promotions,
    required this.isCustomerOrderApproval,
  });

  PaymentSummaryEntity copyWith({
    Cart? cart,
    CartSettings? cartSettings,
    PromotionCollectionModel? promotions,
    bool? isCustomerOrderApproval,
  }) {
    return PaymentSummaryEntity(
      cart: cart ?? this.cart,
      cartSettings: cartSettings ?? this.cartSettings,
      promotions: promotions ?? this.promotions,
      isCustomerOrderApproval:
          isCustomerOrderApproval ?? this.isCustomerOrderApproval,
    );
  }
}
