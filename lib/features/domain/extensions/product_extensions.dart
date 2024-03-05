import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension ProductExtensions on ProductEntity? {

  String getUnitOfMeasure() {
    return (this != null && this!.unitOfMeasureDescription.isNullOrEmpty ? this?.unitOfMeasureDisplay : this?.unitOfMeasureDescription) ?? '';
  }

  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

extension StyledProductExtensions on StyledProductEntity? {
  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

// extension CartLineExtensions on CartLine {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }

// extension OrderLineExtensions on OrderLine {
//   String getProductNumber() {
//     return productErpNumber ?? '';
//   }
// }

// extension WishListLineExtensions on WishListLine {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }

// extension InvoiceLineExtensions on InvoiceLine {
//   String getProductNumber() {
//     return productErpNumber ?? '';
//   }
// }

// extension AutocompleteProductExtensions on AutocompleteProduct {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }

// extension QuoteLineExtensions on QuoteLine {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }
