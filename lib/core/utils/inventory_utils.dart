import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InventoryUtils {
  static bool isInventoryPerWarehouseButtonShownAsync(
      ProductSettings? productSettings,
      {bool isProductDetailPage = false}) {
    bool inventoryPerWarehouseEnabled = false;

    if (productSettings != null) {
      inventoryPerWarehouseEnabled =
          productSettings.showInventoryAvailability! &&
              productSettings.displayInventoryPerWarehouse!;
      inventoryPerWarehouseEnabled = inventoryPerWarehouseEnabled &&
          (!productSettings.displayInventoryPerWarehouseOnlyOnProductDetail! ||
              (productSettings
                      .displayInventoryPerWarehouseOnlyOnProductDetail! &&
                  isProductDetailPage));
    }

    return inventoryPerWarehouseEnabled;
  }
}
