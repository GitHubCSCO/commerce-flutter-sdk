import 'package:commerce_flutter_sdk/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailEntityMapper {
  static ProductDetailEntity toEntity(ProductDetail? model) =>
      ProductDetailEntity(
        name: model?.name,
        modelNumber: model?.modelNumber,
        sku: model?.sku,
        upcCode: model?.upcCode,
        unspsc: model?.unspsc,
        productCode: model?.productCode,
        priceCode: model?.priceCode,
        sortOrder: model?.sortOrder,
        multipleSaleQty: model?.multipleSaleQty,
        canBackOrder: model?.canBackOrder,
        roundingRule: model?.roundingRule,
        replacementProductId: model?.replacementProductId,
        isHazardousGood: model?.isHazardousGood,
        hasMsds: model?.hasMsds,
        isSpecialOrder: model?.isSpecialOrder,
        isGiftCard: model?.isGiftCard,
        allowAnyGiftCardAmount: model?.allowAnyGiftCardAmount,
        taxCode1: model?.taxCode1,
        taxCode2: model?.taxCode2,
        taxCategory: model?.taxCategory,
        vatCodeId: model?.vatCodeId,
        shippingClassification: model?.shippingClassification,
        shippingLength: model?.shippingLength,
        shippingWidth: model?.shippingWidth,
        shippingHeight: model?.shippingHeight,
        shippingWeight: model?.shippingWeight,
        configuration: LegacyConfigurationEntityMapper()
            .toEntity(model?.configuration ?? LegacyConfiguration()),
      );

  static ProductDetail? toModel(ProductDetailEntity entity) => ProductDetail(
        name: entity.name,
        modelNumber: entity.modelNumber,
        sku: entity.sku,
        upcCode: entity.upcCode,
        unspsc: entity.unspsc,
        productCode: entity.productCode,
        priceCode: entity.priceCode,
        sortOrder: entity.sortOrder,
        multipleSaleQty: entity.multipleSaleQty,
        canBackOrder: entity.canBackOrder,
        roundingRule: entity.roundingRule,
        replacementProductId: entity.replacementProductId,
        isHazardousGood: entity.isHazardousGood,
        hasMsds: entity.hasMsds,
        isSpecialOrder: entity.isSpecialOrder,
        isGiftCard: entity.isGiftCard,
        allowAnyGiftCardAmount: entity.allowAnyGiftCardAmount,
        taxCode1: entity.taxCode1,
        taxCode2: entity.taxCode2,
        taxCategory: entity.taxCategory,
        vatCodeId: entity.vatCodeId,
        shippingClassification: entity.shippingClassification,
        shippingLength: entity.shippingLength,
        shippingWidth: entity.shippingWidth,
        shippingHeight: entity.shippingHeight,
        shippingWeight: entity.shippingWeight,
        configuration:
            LegacyConfigurationEntityMapper().toModel(entity.configuration),
      );
}
