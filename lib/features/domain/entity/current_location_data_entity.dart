// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/core/models/lat_long.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrentLocationDataEntity extends Equatable {
  final String? firestLineValue;
  final String? secondLineValue;
  final String? thridLineValue;
  final String? locationName;
  final LatLong? latLong;
  final VmiLocationModel? vmiLocation;
  final String? id;

  CurrentLocationDataEntity({
    this.id,
    this.vmiLocation,
    this.firestLineValue,
    this.secondLineValue,
    this.thridLineValue,
    this.locationName,
    this.latLong,
  });

  CurrentLocationDataEntity copyWith(
      {String? firestLineValue,
      String? secondLineValue,
      String? thridLineValue,
      String? locationName,
      LatLong? latLong,
      VmiLocationModel? vmiLocation,
      String? id}) {
    return CurrentLocationDataEntity(
      id: id ?? this.id,
      firestLineValue: firestLineValue ?? this.firestLineValue,
      secondLineValue: secondLineValue ?? this.secondLineValue,
      thridLineValue: thridLineValue ?? this.thridLineValue,
      locationName: locationName ?? this.locationName,
      latLong: latLong ?? this.latLong,
      vmiLocation: vmiLocation ?? this.vmiLocation,
    );
  }

  factory CurrentLocationDataEntity.fromVmiLocation(VmiLocationModel? value) {
    String? getFirstLineValue() {
      final address1 = value?.customer?.address1;
      final address2 = value?.customer?.address2;

      if (isNullOrWhiteSpace(address1) && isNullOrWhiteSpace(address2))
        return null;
      if (isNullOrWhiteSpace(address1)) return address2;
      if (isNullOrWhiteSpace(address2)) return address1;
      return "$address1, $address2";
    }

    String? getSecondLineValue() {
      final city = value?.customer?.city;
      final state = value?.customer?.state?.name;
      final postalCode = value?.customer?.postalCode;

      if (isNullOrWhiteSpace(city) &&
          isNullOrWhiteSpace(state) &&
          isNullOrWhiteSpace(postalCode)) return null;

      final statePostal = [
        if (!isNullOrWhiteSpace(state)) state,
        if (!isNullOrWhiteSpace(postalCode)) postalCode,
      ].join(' ');

      final parts = [
        if (!isNullOrWhiteSpace(city)) city,
        if (!isNullOrWhiteSpace(statePostal)) statePostal,
      ];

      return parts.join(', ');
    }

    return CurrentLocationDataEntity(
        firestLineValue: getFirstLineValue(),
        secondLineValue: getSecondLineValue(),
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
      vmiLocation,
      id
    ];
  }
}

bool isNullOrWhiteSpace(String? s) {
  return s == null || s.trim().isEmpty;
}
