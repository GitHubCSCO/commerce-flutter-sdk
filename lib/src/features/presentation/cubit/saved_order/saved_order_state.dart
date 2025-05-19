part of 'saved_order_cubit.dart';

class SavedOrderState extends Equatable {
  final OrderStatus status;
  final CartSortOrder sortOrder;
  final CartSettings cartSettings;
  final CartCollectionModel cartCollectionModel;
  final bool? hidePricingEnable;
  final String? errorMessage;

  const SavedOrderState(
      {required this.status,
      required this.sortOrder,
      required this.cartSettings,
      required this.cartCollectionModel,
      this.hidePricingEnable,
      this.errorMessage});

  @override
  List<Object> get props => [
        status,
        sortOrder,
        cartSettings,
        cartCollectionModel,
        hidePricingEnable ?? false,
        errorMessage ?? ''
      ];

  SavedOrderState copyWith(
      {OrderStatus? status,
      CartSortOrder? sortOrder,
      CartSettings? cartSettings,
      CartCollectionModel? cartCollectionModel,
      bool? hidePricingEnable,
      String? errorMessage}) {
    return SavedOrderState(
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      cartSettings: cartSettings ?? this.cartSettings,
      cartCollectionModel: cartCollectionModel ?? this.cartCollectionModel,
      hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
