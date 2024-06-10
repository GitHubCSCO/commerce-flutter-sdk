import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';

abstract class AddCreditCardState {}

class AddCreditCardInitialState extends AddCreditCardState {}

class AddCreditCardLoadingState extends AddCreditCardState {}

class AddCreditCardLoadedState extends AddCreditCardState {
  List<KeyValuePair<String, int>>? expirationMonths;
  List<KeyValuePair<int, int>>? expirationYears;
  final TokenExEntity? tokenExEntity;
  AddCreditCardLoadedState({
    this.expirationMonths,
    this.expirationYears,
    this.tokenExEntity,
  });
}

class SavedPaymentAddedSuccessState extends AddCreditCardState {
  final AccountPaymentProfile accountPaymentProfile;
  SavedPaymentAddedSuccessState({
    required this.accountPaymentProfile,
  });
}
