part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductLoadEvent extends ProductEvent {
  final ProductPageEntity entity;

  ProductLoadEvent({required this.entity});
}
