// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

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
