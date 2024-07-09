import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_carousel_state.dart';

class ProductCarouselCubit extends Cubit<ProductCarouselState> {
  final ProductCarouselUseCase _productCarouselUseCase;

  ProductCarouselCubit({required ProductCarouselUseCase productCarouselUseCase})
      : _productCarouselUseCase = productCarouselUseCase,
        super(ProductCarouselInitialState());

  Future<void> getCarouselProducts(
      ProductCarouselWidgetEntity widgetEntity) async {
    if (isClosed) {
      return;
    }
    emit(ProductCarouselLoadedState(
        productCarouselList: widgetEntity.productCarouselList!,
        isPricingLoading: true));

    final productPricingEnabled =
        await _productCarouselUseCase.getProductPricingEnable();
    final productAvailabilityEnabled = await _productCarouselUseCase.getProductInventoryAvailable();

    final productList = widgetEntity.productCarouselList
            ?.map((productCarousel) => productCarousel.product)
            .toList() ??
        [];

    final realTimeResult = await _productCarouselUseCase.getRealtimeSupportType();

    if (productPricingEnabled && realTimeResult != null) {
      if (realTimeResult == RealTimeSupport.RealTimePricingOnly ||
              realTimeResult ==
                  RealTimeSupport.RealTimePricingWithInventoryIncluded ||
              realTimeResult == RealTimeSupport.RealTimePricingAndInventory) {
        final productPriceParameters = productList
            .map((product) => ProductPriceQueryParameter(
                  productId: product!.id,
                  qtyOrdered: 1,
                  unitOfMeasure: product.unitOfMeasure,
                ))
            .toList();

        final parameter = RealTimePricingParameters(
            productPriceParameters: productPriceParameters);

        final pricingResult =
            await _productCarouselUseCase.getRealTimePricing(parameter);

        switch (pricingResult) {
          case Success():
            for (var productEntity in productList) {
              var matchingPrice = pricingResult.value?.realTimePricingResults
                  ?.firstWhere((o) => o.productId == productEntity!.id);
              productEntity?.pricing =
                  ProductPriceEntityMapper().toEntity(matchingPrice);
            }
          case Failure():
          default:
        }
      }
    }

    // if (productAvailabilityEnabled && realTimeResult != null) {
    //   if (realTimeResult == RealTimeSupport.NoRealTimePricingAndInventory ||
    //       realTimeResult == RealTimeSupport.RealTimePricingAndInventory ||
    //       realTimeResult == RealTimeSupport.RealTimePricingWithInventoryIncluded ||
    //       realTimeResult == RealTimeSupport.RealTimeInventory) {
    //     final inventoryProducts = productList.map((product) => product?.id ?? '').toList();
    //     final parameters = RealTimeInventoryParameters(
    //       productIds: inventoryProducts,
    //     );
    //
    //     final realTimeInventoryResult = (await _productCarouselUseCase.getRealTimeInventory(parameters)).getResultSuccessValue();
    //
    //     if (realTimeInventoryResult?.realTimeInventoryResults != null) {
    //       for (ProductInventory realTimeInventory in realTimeInventoryResult?.realTimeInventoryResults ?? []) {
    //         for (var productEntity in productList) {
    //           if (realTimeInventory.productId == productEntity?.id) {
    //             var product = productEntity;
    //             late AvailabilityEntity? productAvailability;
    //             final qtyOnHand = realTimeInventory.qtyOnHand;
    //
    //             var inventoryAvailability = realTimeInventory.inventoryAvailabilityDtos
    //                 ?.singleWhere(
    //                     (ia) => ia.unitOfMeasure == product?.unitOfMeasure);
    //             if (inventoryAvailability != null) {
    //               productAvailability = AvailabilityEntityMapper().toEntity(inventoryAvailability.availability);
    //             } else {
    //               productAvailability = AvailabilityEntityMapper().toEntity(Availability(messageType: 0));
    //             }
    //
    //             product?.productUnitOfMeasures?.forEach((productUnitOfMeasureEntity) {
    //               var unitOfMeasureAvailability = realTimeInventory
    //                   .inventoryAvailabilityDtos
    //                   ?.singleWhere((i) => i.unitOfMeasure == productUnitOfMeasureEntity.unitOfMeasure);
    //
    //               late Availability? availability;
    //               if (unitOfMeasureAvailability != null) {
    //                 availability = unitOfMeasureAvailability.availability;
    //               } else {
    //                 availability = Availability(messageType: 0);
    //               }
    //
    //               productUnitOfMeasureEntity.copyWith(
    //                 availability: AvailabilityEntityMapper().toEntity(availability),
    //               );
    //             });
    //
    //             if (product != null && (product.isStyleProductParent ?? false) &&
    //                 product.productUnitOfMeasures != null &&
    //                 product.selectedUnitOfMeasure != null) {
    //               var productUnitOfMeasure = product.productUnitOfMeasures
    //                   ?.singleWhere(
    //                       (uom) => uom.unitOfMeasure == product.selectedUnitOfMeasure);
    //               if (productUnitOfMeasure != null &&
    //                   productUnitOfMeasure.availability != null) {
    //                 productAvailability = productUnitOfMeasure.availability;
    //               }
    //             }
    //
    //             product?.copyWith(
    //               availability: productAvailability,
    //               qtyOnHand: qtyOnHand
    //             );
    //           }
    //         }
    //       }
    //     } else {
    //       for (var product in productList) {
    //         final productAvailability = Availability(
    //           messageType: 0,
    //           message: LocalizationConstants.unableToRetrieveInventory,
    //         );
    //
    //         product?.copyWith(
    //           availability: AvailabilityEntityMapper().toEntity(productAvailability),
    //         );
    //       }
    //     }
    //   }
    // }

    emit(ProductCarouselLoadedState(
        productCarouselList: widgetEntity.productCarouselList!,
        isPricingLoading: false));
  }
}

enum RealTimeSupport {
  NoRealTimePricingAndInventory,
  RealTimePricingOnly,
  RealTimePricingWithInventoryIncluded,
  RealTimePricingAndInventory,
  RealTimeInventory
}
