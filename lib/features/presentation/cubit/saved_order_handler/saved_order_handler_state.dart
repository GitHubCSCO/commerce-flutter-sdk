part of 'saved_order_handler_cubit.dart';

enum SavedOrderHandlerStatus {
  initial,
  loading,
  shouldRefreshSavedOrder,
  failure,
}

class SavedOrderHandlerState extends Equatable {
  final SavedOrderHandlerStatus status;

  const SavedOrderHandlerState({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  SavedOrderHandlerState copyWith({
    SavedOrderHandlerStatus? status,
  }) {
    return SavedOrderHandlerState(
      status: status ?? this.status,
    );
  }
}
