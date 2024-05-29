import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';

class VMILocationSelectCallbackHelper {
  final void Function(CurrentLocationDataEntity)? onSelectVMILocation;

  const VMILocationSelectCallbackHelper({
    required this.onSelectVMILocation,
  });
}
