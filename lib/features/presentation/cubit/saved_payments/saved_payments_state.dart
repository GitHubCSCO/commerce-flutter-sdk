// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class SavedPaymentsState {}

class SavedPaymentsInitialState extends SavedPaymentsState {}

class SavedPaymentsLoadingState extends SavedPaymentsState {}

class SavedPaymentsLoadedState extends SavedPaymentsState {
  List<AccountPaymentProfile>? accountPaymentProfiles;
  SavedPaymentsLoadedState({
    required this.accountPaymentProfiles,
  });
}

class SavedPaymentsFailureState extends SavedPaymentsState {}
