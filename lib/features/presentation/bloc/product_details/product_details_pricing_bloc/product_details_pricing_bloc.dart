import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_pricing_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_pricing_bloc/product_details_pricing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPricingBloc
    extends Bloc<ProductDetailsPricingEvent, ProductDetailsPricingState> {
  final ProductDetailsPricingUseCase _productDetailsPricingUseCase;
  ProductDetailsPricingBloc(
      {required ProductDetailsPricingUseCase productDetailsPricingUseCase})
      : _productDetailsPricingUseCase = productDetailsPricingUseCase,
        super(ProductDetailsPricingInitial()) {
    on<LoadProductDetailsPricing>(_fetchProductDetailsPricing);
  }

  Future<void> _fetchProductDetailsPricing(ProductDetailsPricingEvent event,
      Emitter<ProductDetailsPricingState> emit) async {
    emit(ProductDetailsPricingLoading());
  }
}
