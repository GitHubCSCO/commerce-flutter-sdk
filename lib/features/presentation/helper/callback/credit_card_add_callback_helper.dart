import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CreditCardAddCallbackHelper {
  final AddCreditCardEntity addCreditCardEntity;
  final void Function(AccountPaymentProfile) onAddedCeditCard;
  final void Function()? onDeletedCreditCard;
  const CreditCardAddCallbackHelper({
    required this.addCreditCardEntity,
    required this.onAddedCeditCard,
    this.onDeletedCreditCard,
  });
}
