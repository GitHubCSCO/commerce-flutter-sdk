import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsUseCase extends BaseUseCase {
  late ProductEntity? productParameter;
  late Session? session;
  late AccountSettings? accountSettings;
  late ProductSettings? productSettings;
  late ProductUnitOfMeasure? chosenUnitOfMeasure;

  ProductDetailsUseCase({
    this.productParameter,
    this.session,
    this.accountSettings,
    this.productSettings,
    this.chosenUnitOfMeasure,
  }) : super();

  Future<Result<ProductEntity, ErrorResponse>> getProductDetails(
      ProductEntity productParameter) async {
    // (await this.commerceAPIServiceProvider.getCatalogpagesService()
    //     .getProductCatalogInformation(this.productParameter.urlSegment));

    this.productParameter = productParameter;
    String? productId =
        this.productParameter?.styleParentId ?? this.productParameter?.id;

    if (productId == null) {
      return Failure(ErrorResponse(message: "Product id is null"));
    }

    // var includeAlternateInventory =
    //     !this.accountSettings.EnableWarehousePickup ||
    //         this.session.FulfillmentMethod != "PickUp";

    var includeAlternateInventory = true;

    var parameters = ProductQueryParameters(
      addToRecentlyViewed: true,
      applyPersonalization: true,
      includeAttributes: "IncludeOnProduct",
      includeAlternateInventory: includeAlternateInventory,
      expand:
          "documents,specifications,styledproducts,htmlcontent,attributes,crosssells,pricing,brand",
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProduct(productId, parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        final productEntity =
            ProductEntityMapper().toEntity(data?.product ?? Product());
        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }
}
