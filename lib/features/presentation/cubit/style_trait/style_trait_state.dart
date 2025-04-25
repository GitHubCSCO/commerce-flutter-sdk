import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:equatable/equatable.dart';

sealed class StyleTraitState extends Equatable {
  const StyleTraitState();

  @override
  List<Object> get props => [];
}

final class StyleTraitStateLoading extends StyleTraitState {}

final class StyleTraitStateLoaded extends StyleTraitState {
  final List<ProductDetailStyleTrait> styleTraitsEntity;

  StyleTraitStateLoaded({required this.styleTraitsEntity});
}

final class StyleTraitStateFailure extends StyleTraitState {}
