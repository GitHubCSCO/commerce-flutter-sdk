// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardEvent {}

class SetUpDataSourceEvent extends AddCreditCardEvent {
  AddCreditCardEntity? addCreditCardEntity;
  SetUpDataSourceEvent({
    this.addCreditCardEntity,
  });
}

class SavePaymentProfileEvent extends AddCreditCardEvent {
  final AccountPaymentProfile accountPaymentProfile;
  SavePaymentProfileEvent({
    required this.accountPaymentProfile,
  });
}

class UpdateUseAsDefaultCardEvent extends AddCreditCardEvent {}

class DeletCreditCardEvent extends AddCreditCardEvent {
  final AccountPaymentProfile accountPaymentProfile;
  DeletCreditCardEvent({
    required this.accountPaymentProfile,
  });
}
