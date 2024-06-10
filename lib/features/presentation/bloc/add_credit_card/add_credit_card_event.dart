// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardEvent {}

class SetUpDataSourceEvent extends AddCreditCardEvent {}

class SavePaymentProfileEvent extends AddCreditCardEvent {
  final AccountPaymentProfile accountPaymentProfile;
  SavePaymentProfileEvent({
    required this.accountPaymentProfile,
  });
}
