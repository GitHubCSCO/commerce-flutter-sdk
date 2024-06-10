import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CreditCardAddCallbackHelper {
  final void Function(AccountPaymentProfile) onAddedCeditCard;
  const CreditCardAddCallbackHelper({
    required this.onAddedCeditCard,
  });
}
