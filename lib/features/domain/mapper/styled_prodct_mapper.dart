import 'package:commerce_flutter_sdk/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/product_image_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/style_value_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/warehouse_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class StyledProductEntityMapper {
  StyledProductEntity toEntity(StyledProduct model) => StyledProductEntity(
        productId: model.productId,
        name: model.name,
        shortDescription: model.shortDescription,
        erpNumber: model.erpNumber,
        mediumImagePath: model.mediumImagePath,
        smallImagePath: model.smallImagePath,
        largeImagePath: model.largeImagePath,
        qtyOnHand: model.qtyOnHand,
        numberInCart: model.numberInCart,
        pricing:
            ProductPriceEntityMapper.toEntity(model.pricing ?? ProductPrice()),
        quoteRequired: model.quoteRequired,
        styleValues: model.styleValues
            ?.map((styleValue) => StyleValueEntityMapper.toEntity(styleValue))
            .toList(),
        availability: AvailabilityEntityMapper.toEntity(
            model.availability ?? Availability()),
        productUnitOfMeasures: model.productUnitOfMeasures
            ?.map((productUnitOfMeasure) =>
                ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure))
            .toList(),
        productImages: model.productImages
            ?.map((productImage) =>
                ProductImageEntityMapper.toEntity(productImage))
            .toList(),
        warehouses: model.warehouses
            ?.map((warehouse) => WarehouseEntityMapper.toEntity(warehouse))
            .toList(),
        trackInventory: model.trackInventory,
        properties: model.properties,
        allowZeroPricing: model.allowZeroPricing,
      );
  StyledProduct toModel(StyledProductEntity entity) => StyledProduct(
        productId: entity.productId,
        name: entity.name,
        shortDescription: entity.shortDescription,
        erpNumber: entity.erpNumber,
        mediumImagePath: entity.mediumImagePath,
        smallImagePath: entity.smallImagePath,
        largeImagePath: entity.largeImagePath,
        qtyOnHand: entity.qtyOnHand,
        numberInCart: entity.numberInCart,
        pricing: ProductPriceEntityMapper.toModel(
            entity.pricing ?? const ProductPriceEntity()),
        quoteRequired: entity.quoteRequired,
        styleValues: entity.styleValues
            ?.map((styleValue) => StyleValueEntityMapper.toModel(styleValue))
            .toList(),
        availability: AvailabilityEntityMapper.toModel(
            entity.availability ?? const AvailabilityEntity()),
        productUnitOfMeasures: entity.productUnitOfMeasures
            ?.map((productUnitOfMeasure) =>
                ProductUnitOfMeasureEntityMapper.toModel(productUnitOfMeasure))
            .toList(),
        productImages: entity.productImages
            ?.map((productImage) =>
                ProductImageEntityMapper.toModel(productImage))
            .toList(),
        warehouses: entity.warehouses
            ?.map((warehouse) => WarehouseEntityMapper.toModel(warehouse))
            .toList(),
        trackInventory: entity.trackInventory,
        allowZeroPricing: entity.allowZeroPricing,
      )..properties = entity.properties;
}
