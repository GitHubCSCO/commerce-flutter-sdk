// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PromoCodeState {}

class PromoCodeInitialState extends PromoCodeState {}

class PromoCodeLoadingState extends PromoCodeState {}

class PromoCodeLoadedState extends PromoCodeState {
  List<Promotion>? promotions;
  PromoCodeLoadedState({
    required this.promotions,
  });
}

class PromoCodeApplySuccessState extends PromoCodeState {}

class PromoCodeFailureState extends PromoCodeState {
  final String message;

  PromoCodeFailureState({required this.message});
}
