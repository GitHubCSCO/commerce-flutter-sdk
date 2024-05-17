// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrentLocationDataEntity extends Equatable {
  final String? firestLineValue;
  final String? secondLineValue;
  final String? thridLineValue;
  final String? locationName;
  CurrentLocationDataEntity({
    this.firestLineValue,
    this.secondLineValue,
    this.thridLineValue,
    this.locationName,
  });

  CurrentLocationDataEntity copyWith({
    String? firestLineValue,
    String? secondLineValue,
    String? thridLineValue,
    String? locationName,
  }) {
    return CurrentLocationDataEntity(
      firestLineValue: firestLineValue ?? this.firestLineValue,
      secondLineValue: secondLineValue ?? this.secondLineValue,
      thridLineValue: thridLineValue ?? this.thridLineValue,
      locationName: locationName ?? this.locationName,
    );
  }

  factory CurrentLocationDataEntity.fromVmiLocation(VmiLocationModel? value) {
    return CurrentLocationDataEntity(
      firestLineValue: isNullOrWhiteSpace(value?.customer.address2)
          ? value?.customer.address1
          : "${value?.customer.address1}, ${value?.customer.address2}",
      secondLineValue: isNullOrWhiteSpace(value?.customer.state?.name) &&
              isNullOrWhiteSpace(value?.customer.postalCode)
          ? "${value?.customer.city}"
          : "${value?.customer.city}, ${value?.customer.state?.name} ${value?.customer.postalCode}",
      thridLineValue: value?.customer.phone,
      locationName: value?.name,
    );
  }

  @override
  List<Object?> get props {
    return [
      firestLineValue,
      secondLineValue,
      thridLineValue,
      locationName,
    ];
  }
}

bool isNullOrWhiteSpace(String? s) {
  return s == null || s.trim().isEmpty;
}
