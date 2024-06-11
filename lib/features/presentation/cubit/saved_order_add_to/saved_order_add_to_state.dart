part of 'saved_order_add_to_cubit.dart';

enum SavedOrderAddToStatus {
  initial,
  loading,
  shouldRefreshSavedOrder,
  failure,
}

class SavedOrderAddToState extends Equatable {
  final SavedOrderAddToStatus status;

  const SavedOrderAddToState({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  SavedOrderAddToState copyWith({
    SavedOrderAddToStatus? status,
  }) {
    return SavedOrderAddToState(
      status: status ?? this.status,
    );
  }
}
