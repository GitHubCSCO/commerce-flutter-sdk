import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_item_pricing_inventory_state.dart';

class OrderItemPricingInventoryCubit extends Cubit<OrderItemPricingInventoryState> {
  final OrderPricingInventoryUseCase _pricingInventoryUseCase;

  OrderItemPricingInventoryCubit({required OrderPricingInventoryUseCase pricingInventoryUseCase}):
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(OrderItemPricingInventoryInitial());

  Future<void> getPricingAndInventory(QuickOrderItemEntity quickOrderItemEntity, ProductSettings productSettings) async {
    emit(OrderItemPricingInventoryLoading());

    var product = quickOrderItemEntity.productEntity;

    if (product.quoteRequired ?? false) {
      quickOrderItemEntity.priceValueText = LocalizationConstants.requiresQuote;
      emit(OrderItemPricingInventoryLoaded());
      return;
    }

    if (quickOrderItemEntity.quantityOrdered < 1) {
      quickOrderItemEntity.extendedPriceValueText = '${CoreConstants.currencySymbol}${0.00.toStringAsFixed(2)}';
      emit(OrderItemSubTotalChange());
      emit(OrderItemPricingInventoryLoaded());
      return;
    }

    var productId = product.id;

    var isUserSignedIn = await _pricingInventoryUseCase.isAuthenticated();
    var isStorefrontAccessGranted = productSettings.storefrontAccess != StorefrontAccessConstants.signInRequiredToAddToCartOrSeePrices || isUserSignedIn;

    if (productSettings.canSeePrices! && isStorefrontAccessGranted) {
      if (productSettings.realTimePricing!) {
        List<ProductPriceQueryParameter> priceProducts = [
          ProductPriceQueryParameter(
            productId: productId,
            unitOfMeasure: product.selectedUnitOfMeasure,
            qtyOrdered: quickOrderItemEntity.quantityOrdered,
          ),
        ];

        RealTimePricingParameters parameter = RealTimePricingParameters(
          productPriceParameters: priceProducts,
        );
        var getProductRealTimePrices = await _pricingInventoryUseCase.getProductRealTimePrices(parameter);
        var pricing = getProductRealTimePrices?.realTimePricingResults?.firstWhere(
              (result) => result.productId == productId
        );
        quickOrderItemEntity.updatePricing(ProductPriceEntityMapper.toEntity(pricing), productSettings.canSeePrices!);

      } else {
        ProductPriceQueryParameter parameters = ProductPriceQueryParameter(
          qtyOrdered: quickOrderItemEntity.quantityOrdered,
          unitOfMeasure: product.selectedUnitOfMeasure,
        );

        var pricing = await _pricingInventoryUseCase.getProductPrice(productId!, parameters);
        quickOrderItemEntity.updatePricing(ProductPriceEntityMapper.toEntity(pricing), productSettings.canSeePrices!);
      }
    }
    emit(OrderItemSubTotalChange());

    var productAvailabilityEnabled = productSettings.showInventoryAvailability!;
    var showInventoryAvailability = false;
    if ((!product.isConfigured! || product.isFixedConfiguration!) && !product.isStyleProductParent!) {
      showInventoryAvailability = productAvailabilityEnabled;
    }
    showInventoryAvailability = product.availability?.message != null &&
        product.availability!.message!.isNotEmpty &&
        product.availability!.messageType != 0;

    quickOrderItemEntity.showInventoryAvailability = showInventoryAvailability;

    if (showInventoryAvailability) {
      if (productSettings.realTimeInventory!) {
        RealTimeInventoryParameters parameters = RealTimeInventoryParameters(
          productIds: [productId!],
        );

        var result = await _pricingInventoryUseCase.getProductRealTimeInventory(parameters);
        var inventory = result?.realTimeInventoryResults?.firstWhere(
              (result) => result.productId == product.id
        );

        if (inventory != null) {
          var availability = inventory.inventoryAvailabilityDtos?.firstWhere(
                (dto) => dto.unitOfMeasure?.toLowerCase() ==
                product.unitOfMeasure?.toLowerCase()
          ).availability;
          quickOrderItemEntity.availability = availability;
        }
      }
    }

    emit(OrderItemPricingInventoryLoaded());
  }

}
