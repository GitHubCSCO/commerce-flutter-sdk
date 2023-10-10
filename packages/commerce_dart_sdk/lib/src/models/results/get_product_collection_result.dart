// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../models.dart';

part 'get_product_collection_result.g.dart';

@JsonSerializable()
class GetProductCollectionResult extends BaseModel {
  Pagination? pagination;

  List<Product>? products;

  List<CategoryFacet>? categoryFacets;

  List<AttributeType>? attributeTypeFacets;

  List<GenericFacet>? brandFacets;

  List<ProductLine>? productLineFacets;

  List<SuggestionDto>? didYouMeanSuggestions;

  bool? exactMatch;

  bool? notAllProductsFound;

  bool? notAllProductsAllowed;

  String? originalQuery;

  String? correctedQuery;

  Object? searchTermRedirectUrl;

  // for V2:
  PriceRange? priceRange;

  GetProductCollectionResult({
    this.pagination,
    this.products,
    this.categoryFacets,
    this.attributeTypeFacets,
    this.brandFacets,
    this.productLineFacets,
    this.didYouMeanSuggestions,
    this.exactMatch,
    this.notAllProductsFound,
    this.notAllProductsAllowed,
    this.originalQuery,
    this.correctedQuery,
    this.searchTermRedirectUrl,
    this.priceRange,
  });

  factory GetProductCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$GetProductCollectionResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetProductCollectionResultToJson(this);
}
