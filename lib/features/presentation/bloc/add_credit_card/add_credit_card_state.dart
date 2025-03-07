import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';

abstract class AddCreditCardState {}

class AddCreditCardInitialState extends AddCreditCardState {}

class AddCreditCardLoadingState extends AddCreditCardState {}

class AddCreditCardLoadedState extends AddCreditCardState {
  List<KeyValuePair<String, int>>? expirationMonths;
  List<KeyValuePair<int, int>>? expirationYears;
  final TokenExEntity? tokenExEntity;
  final String? spreedlyEnvironmentKey;
  final WebsiteSettings? websiteSettings;

  AddCreditCardLoadedState(
      {this.expirationMonths,
      this.expirationYears,
      this.tokenExEntity,
      this.spreedlyEnvironmentKey,
      this.websiteSettings});
}

class SavedPaymentAddedSuccessState extends AddCreditCardState {
  final AccountPaymentProfile accountPaymentProfile;
  SavedPaymentAddedSuccessState({
    required this.accountPaymentProfile,
  });
}

class SavedPaymentAddedFailureState extends AddCreditCardState {
  final String errorMessage;
  SavedPaymentAddedFailureState({
    required this.errorMessage,
  });
}

class UseAsDefaultCardUpdatedState extends AddCreditCardState {}

class CreditCardDeletedSuccessState extends AddCreditCardState {}

class CreditCardDeletedFailureState extends AddCreditCardState {}
