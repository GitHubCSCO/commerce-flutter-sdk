part of 'saved_order_handler_cubit.dart';

enum SavedOrderHandlerStatus {
  initial,
  loading,
  shouldRefreshSavedOrder,
  shouldClearCart,
  failure,
}

class SavedOrderHandlerState {
  final SavedOrderHandlerStatus status;
  final Cart savedCart;

  const SavedOrderHandlerState({
    required this.status,
    required this.savedCart,
  });

  SavedOrderHandlerState copyWith({
    SavedOrderHandlerStatus? status,
    Cart? savedCart,
  }) {
    return SavedOrderHandlerState(
      status: status ?? this.status,
      savedCart: savedCart ?? this.savedCart,
    );
  }
}
