import 'package:commerce_flutter_app/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailEntityMapper {
  ProductDetailEntity toEntity(ProductDetail? model) => ProductDetailEntity(
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
}
