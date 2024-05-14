// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AvailabilityEntity extends Equatable {
  final int? messageType;
  final String? message;
  final bool? requiresRealTimeInventory;

  const AvailabilityEntity({
    this.messageType,
    this.message,
    this.requiresRealTimeInventory,
  });

  @override
  List<Object?> get props => [
        messageType,
        message,
        requiresRealTimeInventory,
      ];

  AvailabilityEntity copyWith({
    int? messageType,
    String? message,
    bool? requiresRealTimeInventory,
  }) {
    return AvailabilityEntity(
      messageType: messageType ?? this.messageType,
      message: message ?? this.message,
      requiresRealTimeInventory:
          requiresRealTimeInventory ?? this.requiresRealTimeInventory,
    );
  }
}
