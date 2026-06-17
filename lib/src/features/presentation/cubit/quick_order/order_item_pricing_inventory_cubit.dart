import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quick_order_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/quick_order_usecase/order_pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order_item_pricing_inventory_state.dart';

class OrderItemPricingInventoryCubit
    extends Cubit<OrderItemPricingInventoryState> {
  final OrderPricingInventoryUseCase _pricingInventoryUseCase;

  OrderItemPricingInventoryCubit(
      {required OrderPricingInventoryUseCase pricingInventoryUseCase})
      : _pricingInventoryUseCase = pricingInventoryUseCase,
        super(OrderItemPricingInventoryInitial());

  Future<void> getPricingAndInventory(QuickOrderItemEntity quickOrderItemEntity,
      ProductSettings productSettings) async {
    emit(OrderItemPricingInventoryLoading());

    var product = quickOrderItemEntity.productEntity;

    if (product.quoteRequired ?? false) {
      quickOrderItemEntity.priceValueText =
          LocalizationConstants.requiresQuote.localized();
      emit(OrderItemPricingInventoryLoaded());
      return;
    }

    if (quickOrderItemEntity.quantityOrdered < 1) {
      quickOrderItemEntity.extendedPriceValueText =
          '${CoreConstants.currencySymbol}${0.00.toStringAsFixed(2)}';
      emit(OrderItemSubTotalChange());
      emit(OrderItemPricingInventoryLoaded());
      return;
    }

    var productId = product.id;

    var isUserSignedIn = await _pricingInventoryUseCase.isAuthenticated();
    if (isClosed) {
      return;
    }
    var isStorefrontAccessGranted = productSettings.storefrontAccess !=
            StorefrontAccessConstants.signInRequiredToAddToCartOrSeePrices ||
        isUserSignedIn;

    if ((productSettings.canSeePrices ?? false) && isStorefrontAccessGranted) {
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
      var getProductRealTimePrices =
          await _pricingInventoryUseCase.getProductRealTimePrices(parameter);
      if (isClosed) {
        return;
      }
      var pricing = getProductRealTimePrices?.realTimePricingResults
          ?.where((result) => result.productId == productId)
          .firstOrNull;

      if (pricing != null) {
        quickOrderItemEntity.updatePricing(
          ProductPriceEntityMapper.toEntity(pricing),
          productSettings.canSeePrices!,
          showSavingsAmount: productSettings.showSavingsAmount ?? true,
          showSavingsPercent: productSettings.showSavingsPercent ?? true,
        );
      } else {
        // Last-resort fallback to the static unitListPrice from the product
        // root if realtime pricing returned nothing.
        final qty = quickOrderItemEntity.quantityOrdered;
        final listPrice = product.unitListPrice;
        final fallbackPricing = ProductPriceEntity(
          productId: productId,
          isOnSale: false,
          unitListPrice: listPrice,
          unitListPriceDisplay: product.unitListPriceDisplay,
          unitNetPrice: listPrice,
          unitNetPriceDisplay: product.unitListPriceDisplay,
          extendedUnitNetPrice: listPrice != null ? listPrice * qty : null,
        );
        quickOrderItemEntity.updatePricing(
          fallbackPricing,
          productSettings.canSeePrices!,
          showSavingsAmount: productSettings.showSavingsAmount ?? true,
          showSavingsPercent: productSettings.showSavingsPercent ?? true,
        );
      }
    }
    emit(OrderItemSubTotalChange());

    var productAvailabilityEnabled = productSettings.showInventoryAvailability!;
    var showInventoryAvailability = false;
    if ((!(product.isConfigured ?? false) ||
            (product.isFixedConfiguration ?? false)) &&
        !(product.isVariantParent ?? false)) {
      showInventoryAvailability = productAvailabilityEnabled;
    }

    quickOrderItemEntity.showInventoryAvailability = showInventoryAvailability;

    if (showInventoryAvailability) {
      if (productSettings.realTimeInventory!) {
        RealTimeInventoryParameters parameters = RealTimeInventoryParameters(
          productIds: [productId!],
        );

        var result = await _pricingInventoryUseCase
            .getProductRealTimeInventory(parameters);
        if (isClosed) {
          return;
        }
        var inventory = result?.realTimeInventoryResults
            ?.where((result) => result.productId == product.id)
            .firstOrNull;

        if (inventory != null) {
          var availability = inventory.inventoryAvailabilityDtos
              ?.where((dto) =>
                  (dto.unitOfMeasure?.toLowerCase() ?? '') ==
                  (product.unitOfMeasure?.toLowerCase() ?? ''))
              .firstOrNull
              ?.availability;
          quickOrderItemEntity.availability = availability;
        }
      }
    }

    emit(OrderItemPricingInventoryLoaded());
  }
}
