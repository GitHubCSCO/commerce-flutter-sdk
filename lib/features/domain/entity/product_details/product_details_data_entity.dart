// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';

class ProductDetailsDataEntity extends Equatable {
  AccountSettings? accountSettings;
  ProductSettings? productSettings;
  bool? addToCartEnabled;
  bool? productPricingEnabled;
  RealTimeSupport? realtimeSupport;
  bool? realtimeProductPricingEnabled;
  bool? realtimeProductAvailabilityEnabled;
  bool? alternateUnitsOfMeasureEnabled;
  Session? session;
  bool? hasCheckout;
  ProductEntity? product;
  StyledProductEntity? styledProduct;
  ProductUnitOfMeasureEntity? chosenUnitOfMeasure;
  Map<String, ConfigSectionOptionEntity?>? selectedConfigurations;
  Map<String, List<StyleValueEntity>?>? availableStyleValues;
  Map<String, StyleValueEntity?>? selectedStyleValues;
  bool? isProductConfigurable;
  bool? isProductConfigurationCompleted;

  ProductDetailsDataEntity(
      {this.addToCartEnabled,
      this.productPricingEnabled,
      this.realtimeSupport,
      this.realtimeProductPricingEnabled,
      this.realtimeProductAvailabilityEnabled,
      this.alternateUnitsOfMeasureEnabled,
      this.session,
      this.hasCheckout,
      this.product,
      this.styledProduct,
      this.chosenUnitOfMeasure,
      this.selectedConfigurations,
      this.availableStyleValues,
      this.selectedStyleValues,
      this.productSettings,
      this.accountSettings,
      this.isProductConfigurable,
      this.isProductConfigurationCompleted});

  @override
  List<Object?> get props {
    return [
      addToCartEnabled,
      productPricingEnabled,
      realtimeSupport,
      realtimeProductPricingEnabled,
      realtimeProductAvailabilityEnabled,
      alternateUnitsOfMeasureEnabled,
      session,
      hasCheckout,
      product,
      styledProduct,
      chosenUnitOfMeasure,
      selectedConfigurations,
      availableStyleValues,
      selectedStyleValues,
      accountSettings,
      productSettings,
      isProductConfigurable,
      isProductConfigurationCompleted
    ];
  }

  ProductDetailsDataEntity copyWith(
      {bool? addToCartEnabled,
      bool? productPricingEnabled,
      RealTimeSupport? realtimeSupport,
      bool? realtimeProductPricingEnabled,
      bool? realtimeProductAvailabilityEnabled,
      bool? alternateUnitsOfMeasureEnabled,
      Session? session,
      bool? hasCheckout,
      ProductEntity? product,
      StyledProductEntity? styledProduct,
      ProductUnitOfMeasureEntity? chosenUnitOfMeasure,
      Map<String, ConfigSectionOptionEntity?>? selectedConfigurations,
      Map<String, List<StyleValueEntity>?>? availableStyleValues,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      AccountSettings? accountSettings,
      ProductSettings? productSettings,
      bool? isProductConfigurable,
      bool? isProductConfigurationCompleted}) {
    return ProductDetailsDataEntity(
        addToCartEnabled: addToCartEnabled ?? this.addToCartEnabled,
        productPricingEnabled:
            productPricingEnabled ?? this.productPricingEnabled,
        realtimeSupport: realtimeSupport ?? this.realtimeSupport,
        realtimeProductPricingEnabled:
            realtimeProductPricingEnabled ?? this.realtimeProductPricingEnabled,
        realtimeProductAvailabilityEnabled:
            realtimeProductAvailabilityEnabled ??
                this.realtimeProductAvailabilityEnabled,
        alternateUnitsOfMeasureEnabled: alternateUnitsOfMeasureEnabled ??
            this.alternateUnitsOfMeasureEnabled,
        session: session ?? this.session,
        hasCheckout: hasCheckout ?? this.hasCheckout,
        product: product ?? this.product,
        styledProduct: styledProduct ?? this.styledProduct,
        chosenUnitOfMeasure: chosenUnitOfMeasure ?? this.chosenUnitOfMeasure,
        selectedConfigurations:
            selectedConfigurations ?? this.selectedConfigurations,
        availableStyleValues: availableStyleValues ?? this.availableStyleValues,
        selectedStyleValues: selectedStyleValues ?? this.selectedStyleValues,
        accountSettings: accountSettings ?? this.accountSettings,
        productSettings: productSettings ?? this.productSettings,
        isProductConfigurable:
            isProductConfigurable ?? this.isProductConfigurable,
        isProductConfigurationCompleted: isProductConfigurationCompleted ??
            this.isProductConfigurationCompleted);
  }
}
