import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsAddtoCartEntity extends ProductDetailsBaseEntity {
  final bool? showHidePricing;
  final bool? shouldAddTopPadding;
  final bool? isAddToCartAllowed;
  final bool? addToCartButtonEnabled;
  final String? addToCartButtonText;
  final String? quantityText;
  final String? unitOfMeasurePickerTitle;
  final ProductUnitOfMeasureEntity? selectedUnitOfMeasure;
  final String? selectedUnitOfMeasureValueText;
  final bool? isUnitOfMeasuresVisible;
  final String? subtotalTitleText;
  final bool? isLoadingPrice;
  final String? subtotalValueText;

  const ProductDetailsAddtoCartEntity({
    this.showHidePricing,
    this.shouldAddTopPadding,
    this.isAddToCartAllowed,
    this.addToCartButtonEnabled,
    this.addToCartButtonText,
    this.quantityText,
    this.unitOfMeasurePickerTitle,
    this.selectedUnitOfMeasure,
    this.selectedUnitOfMeasureValueText,
    this.isUnitOfMeasuresVisible,
    this.subtotalTitleText,
    this.isLoadingPrice,
    this.subtotalValueText,
    required super.detailsSectionType,
  });

  @override
  ProductDetailsAddtoCartEntity copyWith({
    bool? showHidePricing,
    bool? shouldAddTopPadding,
    bool? isAddToCartAllowed,
    bool? addToCartButtonEnabled,
    String? addToCartButtonText,
    String? quantityText,
    String? unitOfMeasurePickerTitle,
    ProductUnitOfMeasureEntity? selectedUnitOfMeasure,
    String? selectedUnitOfMeasureValueText,
    bool? isUnitOfMeasuresVisible,
    String? subtotalTitleText,
    bool? isLoadingPrice,
    String? subtotalValueText,
    ProdcutDeatilsPageWidgets? detailsSectionType,
  }) {
    return ProductDetailsAddtoCartEntity(
      showHidePricing: showHidePricing ?? this.showHidePricing,
      shouldAddTopPadding: shouldAddTopPadding ?? this.shouldAddTopPadding,
      isAddToCartAllowed: isAddToCartAllowed ?? this.isAddToCartAllowed,
      addToCartButtonEnabled:
          addToCartButtonEnabled ?? this.addToCartButtonEnabled,
      addToCartButtonText: addToCartButtonText ?? this.addToCartButtonText,
      quantityText: quantityText ?? this.quantityText,
      unitOfMeasurePickerTitle:
          unitOfMeasurePickerTitle ?? this.unitOfMeasurePickerTitle,
      selectedUnitOfMeasure:
          selectedUnitOfMeasure ?? this.selectedUnitOfMeasure,
      selectedUnitOfMeasureValueText:
          selectedUnitOfMeasureValueText ?? this.selectedUnitOfMeasureValueText,
      isUnitOfMeasuresVisible:
          isUnitOfMeasuresVisible ?? this.isUnitOfMeasuresVisible,
      subtotalTitleText: subtotalTitleText ?? this.subtotalTitleText,
      isLoadingPrice: isLoadingPrice ?? this.isLoadingPrice,
      subtotalValueText: subtotalValueText ?? this.subtotalValueText,
      detailsSectionType: detailsSectionType ?? this.detailsSectionType,
    );
  }
}
