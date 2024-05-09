import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';

class QuickOrderItemEntity {

  ProductEntity productEntity;
  int quantityOrdered;

  QuickOrderItemEntity(this.productEntity, this.quantityOrdered);

  QuickOrderItemEntity copyWith({
    ProductEntity? productEntity,
    int? quantityOrdered,
  }) {
    return QuickOrderItemEntity(
      productEntity ?? this.productEntity,
      quantityOrdered ?? this.quantityOrdered,
    );
  }

}