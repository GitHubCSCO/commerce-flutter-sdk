import 'package:commerce_flutter_sdk/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsStandardConfigurationEntity
    extends ProductDetailsBaseEntity {
  final List<ConfigSectionEntity>? configSectionOptions;
  final ConfigSectionOption? selectedOption;

  const ProductDetailsStandardConfigurationEntity(
      {this.configSectionOptions,
      this.selectedOption,
      required super.detailsSectionType});

  @override
  ProductDetailsStandardConfigurationEntity copyWith(
      {List<ConfigSectionEntity>? configSectionOptions,
      ConfigSectionOption? selectedOption,
      ProdcutDeatilsPageWidgets? detailsSectionType}) {
    return ProductDetailsStandardConfigurationEntity(
        configSectionOptions: configSectionOptions,
        selectedOption: selectedOption,
        detailsSectionType: detailsSectionType!);
  }

  @override
  List<Object?> get props => [configSectionOptions, selectedOption];
}
