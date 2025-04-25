// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/features/domain/entity/current_location_data_entity.dart';

class VMILocationDataEntity extends Equatable {
  List<CurrentLocationDataEntity> currentLocationDataList;
  VMILocationDataEntity({
    required this.currentLocationDataList,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
