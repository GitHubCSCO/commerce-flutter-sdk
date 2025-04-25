import 'dart:async';

import 'package:commerce_flutter_sdk/core/models/gogole_place.dart';
import 'package:commerce_flutter_sdk/core/models/lat_long.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IVmiService {
  VmiLocationModel? currentVmiLocation;

  void saveCurrentVmiLocation(VmiLocationModel vmiLocation);

  void updateCurrentVmiLocation();

  Future<VmiLocationModel?> getClosestVmiLocation();

  Future<LatLong?> getPlaceFromAddress(Address? address);

  Future<GooglePlace?> getPlace(String searchQuery);
}
