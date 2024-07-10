// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';

abstract class RequestQuoteState {}

class RequestQuoteInitial extends RequestQuoteState {}

class RequestQuoteCartLinesLoading extends RequestQuoteState {}

class RequestQuoteCartLinesLoaded extends RequestQuoteState {
  final List<CartLineEntity> cartLineEntities;
  RequestQuoteCartLinesLoaded({
    required this.cartLineEntities,
  });
}

class RequestQuoteCartLinesError extends RequestQuoteState {
  final String message;
  RequestQuoteCartLinesError({
    required this.message,
  });
}

class DeleteCartLineSuccessState extends RequestQuoteState {}
class DeleteCartLineErrorState extends RequestQuoteState {}
