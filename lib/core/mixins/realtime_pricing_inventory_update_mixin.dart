import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin RealtimePricingInventoryUpdateMixin {
  Future<List<ProductEntity>> updateProductPricingAndInventoryAvailability(
      PricingInventoryUseCase pricingInventoryUseCase, List<Product>? products,
      {bool onlyPricing = false}) async {
    final productPricingEnabled =
        await pricingInventoryUseCase.getProductPricingEnable();
    final productAvailabilityEnabled =
        await pricingInventoryUseCase.getProductInventoryAvailable();

    final productList = products
            ?.map((product) => ProductEntityMapper().toEntity(product))
            .toList() ??
        [];

    final realTimeResult =
        await pricingInventoryUseCase.getRealtimeSupportType();

    if (productPricingEnabled && realTimeResult != null) {
      if (realTimeResult == RealTimeSupport.RealTimePricingOnly ||
          realTimeResult ==
              RealTimeSupport.RealTimePricingWithInventoryIncluded ||
          realTimeResult == RealTimeSupport.RealTimePricingAndInventory) {
        final productPriceParameters = productList
            .map((product) => ProductPriceQueryParameter(
                  productId: product.id,
                  qtyOrdered: 1,
                  unitOfMeasure: product.unitOfMeasure,
                ))
            .toList();

        final parameter = RealTimePricingParameters(
            productPriceParameters: productPriceParameters);

        final pricingResult =
            await pricingInventoryUseCase.getRealTimePricing(parameter);

        switch (pricingResult) {
          case Success():
            for (var productEntity in productList) {
              var matchingPrice = pricingResult.value?.realTimePricingResults
                  ?.firstWhere((o) => o.productId == productEntity.id);
              productEntity.pricing =
                  ProductPriceEntityMapper.toEntity(matchingPrice);
            }
          case Failure():
          default:
        }
      }
    }

    if (!onlyPricing & productAvailabilityEnabled && realTimeResult != null) {
      if (realTimeResult == RealTimeSupport.NoRealTimePricingAndInventory ||
          realTimeResult == RealTimeSupport.RealTimePricingAndInventory ||
          realTimeResult ==
              RealTimeSupport.RealTimePricingWithInventoryIncluded ||
          realTimeResult == RealTimeSupport.RealTimeInventory) {
        final inventoryProducts =
            productList.map((product) => product?.id ?? '').toList();
        final parameters = RealTimeInventoryParameters(
          productIds: inventoryProducts,
        );

        final realTimeInventoryResult =
            (await pricingInventoryUseCase.getRealTimeInventory(parameters))
                .getResultSuccessValue();

        if (realTimeInventoryResult?.realTimeInventoryResults != null) {
          for (ProductInventory realTimeInventory
              in realTimeInventoryResult?.realTimeInventoryResults ?? []) {
            for (var productEntity in productList) {
              if (realTimeInventory.productId == productEntity?.id) {
                var product = productEntity;
                late AvailabilityEntity? productAvailability;
                final qtyOnHand = realTimeInventory.qtyOnHand;

                var inventoryAvailability =
                    realTimeInventory.inventoryAvailabilityDtos?.singleWhere(
                        (ia) => ia.unitOfMeasure == product.unitOfMeasure,
                        orElse: () => InventoryAvailability());
                if (inventoryAvailability != null &&
                    inventoryAvailability.availability != null) {
                  productAvailability = AvailabilityEntityMapper.toEntity(
                      inventoryAvailability.availability);
                } else {
                  productAvailability = AvailabilityEntityMapper.toEntity(
                      Availability(messageType: 0));
                }

                product.productUnitOfMeasures
                    ?.forEach((productUnitOfMeasureEntity) {
                  var unitOfMeasureAvailability =
                      realTimeInventory.inventoryAvailabilityDtos?.singleWhere(
                    (i) =>
                        i.unitOfMeasure ==
                        productUnitOfMeasureEntity.unitOfMeasure,
                    orElse: () => InventoryAvailability(),
                  );

                  late Availability? availability;
                  if (unitOfMeasureAvailability != null &&
                      unitOfMeasureAvailability.availability != null) {
                    availability = unitOfMeasureAvailability.availability;
                  } else {
                    availability = Availability(messageType: 0);
                  }

                  productUnitOfMeasureEntity.copyWith(
                    availability:
                        AvailabilityEntityMapper.toEntity(availability),
                  );
                });

                if ((product.isStyleProductParent ?? false) &&
                    product.productUnitOfMeasures != null &&
                    product.selectedUnitOfMeasure != null) {
                  var productUnitOfMeasure =
                      product.productUnitOfMeasures?.singleWhere(
                    (uom) => uom.unitOfMeasure == product.selectedUnitOfMeasure,
                    orElse: () => const ProductUnitOfMeasureEntity(),
                  );

                  if (productUnitOfMeasure != null &&
                      productUnitOfMeasure.availability != null) {
                    productAvailability = productUnitOfMeasure.availability;
                  }
                }

                product.availability = productAvailability;
              }
            }
          }
        } else {
          for (var product in productList) {
            final productAvailability = Availability(
              messageType: 0,
              message: LocalizationConstants.unableToRetrieveInventory,
            );

            product.availability =
                AvailabilityEntityMapper.toEntity(productAvailability);
          }
        }
      }
    }

    return productList;
  }
}
