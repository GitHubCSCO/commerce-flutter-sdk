// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrentLocationDataEntity extends Equatable {
  final String? firestLineValue;
  final String? secondLineValue;
  final String? thridLineValue;
  final String? locationName;
  final LatLong? latLong;
  final VmiLocationModel? vmiLocation;

  CurrentLocationDataEntity({
    this.vmiLocation,
    this.firestLineValue,
    this.secondLineValue,
    this.thridLineValue,
    this.locationName,
    this.latLong,
  });

  CurrentLocationDataEntity copyWith({
    String? firestLineValue,
    String? secondLineValue,
    String? thridLineValue,
    String? locationName,
    LatLong? latLong,
    VmiLocationModel? vmiLocation,
  }) {
    return CurrentLocationDataEntity(
      firestLineValue: firestLineValue ?? this.firestLineValue,
      secondLineValue: secondLineValue ?? this.secondLineValue,
      thridLineValue: thridLineValue ?? this.thridLineValue,
      locationName: locationName ?? this.locationName,
      latLong: latLong ?? this.latLong,
      vmiLocation: vmiLocation ?? this.vmiLocation,
    );
  }

  factory CurrentLocationDataEntity.fromVmiLocation(VmiLocationModel? value) {
    return CurrentLocationDataEntity(
        firestLineValue: isNullOrWhiteSpace(value?.customer?.address2)
            ? value?.customer?.address1
            : "${value?.customer?.address1}, ${value?.customer?.address2}",
        secondLineValue: isNullOrWhiteSpace(value?.customer?.state?.name) &&
                isNullOrWhiteSpace(value?.customer?.postalCode)
            ? "${value?.customer?.city}"
            : "${value?.customer?.city}, ${value?.customer?.state?.name} ${value?.customer?.postalCode}",
        thridLineValue: value?.customer?.phone,
        locationName: value?.name,
        vmiLocation: value);
  }

  @override
  List<Object?> get props {
    return [
      firestLineValue,
      secondLineValue,
      thridLineValue,
      locationName,
      latLong,
      vmiLocation
    ];
  }
}

bool isNullOrWhiteSpace(String? s) {
  return s == null || s.trim().isEmpty;
}
