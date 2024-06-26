part of 'saved_order_handler_cubit.dart';

enum SavedOrderHandlerStatus {
  initial,
  loading,
  shouldRefreshSavedOrder,
  shouldClearCart,
  failure,
}

class SavedOrderHandlerState extends Equatable {
  final SavedOrderHandlerStatus status;
  final Cart savedCart;

  const SavedOrderHandlerState({
    required this.status,
    required this.savedCart,
  });

  @override
  List<Object> get props => [status, savedCart];

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
