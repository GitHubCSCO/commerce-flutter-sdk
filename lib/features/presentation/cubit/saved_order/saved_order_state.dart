part of 'saved_order_cubit.dart';

class SavedOrderState extends Equatable {
  final OrderStatus status;
  final CartSortOrder sortOrder;
  final CartSettings cartSettings;
  final CartCollectionModel cartCollectionModel;

  const SavedOrderState({
    required this.status,
    required this.sortOrder,
    required this.cartSettings,
    required this.cartCollectionModel,
  });

  @override
  List<Object> get props => [
        status,
        sortOrder,
        cartSettings,
        cartCollectionModel,
      ];

  SavedOrderState copyWith({
    OrderStatus? status,
    CartSortOrder? sortOrder,
    CartSettings? cartSettings,
    CartCollectionModel? cartCollectionModel,
  }) {
    return SavedOrderState(
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      cartSettings: cartSettings ?? this.cartSettings,
      cartCollectionModel: cartCollectionModel ?? this.cartCollectionModel,
    );
  }
}
