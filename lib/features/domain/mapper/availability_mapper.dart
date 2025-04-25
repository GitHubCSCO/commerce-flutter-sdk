import 'package:commerce_flutter_sdk/features/domain/entity/availability_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AvailabilityEntityMapper {
  static AvailabilityEntity toEntity(Availability? model) => AvailabilityEntity(
        messageType: model?.messageType,
        message: model?.message,
        requiresRealTimeInventory: model?.requiresRealTimeInventory,
      );
  static Availability toModel(AvailabilityEntity entity) => Availability(
        messageType: entity.messageType,
        message: entity.message,
        requiresRealTimeInventory: entity.requiresRealTimeInventory,
      );
}
