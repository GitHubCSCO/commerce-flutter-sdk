import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_status_mapping_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderStatusMappingMapper {
  static OrderStatusMappingEntity toEntity(OrderStatusMapping? model) =>
      OrderStatusMappingEntity(
        id: model?.id,
        erpOrderStatus: model?.erpOrderStatus,
        displayName: model?.displayName,
        isDefault: model?.isDefault,
        allowRma: model?.allowRma,
        allowCancellation: model?.allowCancellation,
      );
}
