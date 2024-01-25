import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AvailabilityEntityMapper {
  AvailabilityEntity toEntity(Availability model) => AvailabilityEntity(
        messageType: model.messageType,
        message: model.message,
        requiresRealTimeInventory: model.requiresRealTimeInventory,
      );
}
