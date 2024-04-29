import 'package:equatable/equatable.dart';

class SortOptionEntity extends Equatable {
  final String? displayName;
  final String? sortType;

  const SortOptionEntity({
    required this.displayName,
    required this.sortType,
  });

  @override
  List<Object?> get props => [displayName, sortType];

  SortOptionEntity copyWith({
    String? displayName,
    String? sortType,
  }) {
    return SortOptionEntity(
      displayName: displayName ?? this.displayName,
      sortType: sortType ?? this.sortType,
    );
  }
}
