// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductCollectionResult _$GetProductCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetProductCollectionResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryFacets: (json['categoryFacets'] as List<dynamic>?)
          ?.map((e) => CategoryFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributeTypeFacets: (json['attributeTypeFacets'] as List<dynamic>?)
          ?.map((e) => AttributeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      brandFacets: (json['brandFacets'] as List<dynamic>?)
          ?.map((e) => GenericFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
      productLineFacets: (json['productLineFacets'] as List<dynamic>?)
          ?.map((e) => ProductLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      didYouMeanSuggestions: (json['didYouMeanSuggestions'] as List<dynamic>?)
          ?.map((e) => SuggestionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      exactMatch: json['exactMatch'] as bool?,
      notAllProductsFound: json['notAllProductsFound'] as bool?,
      notAllProductsAllowed: json['notAllProductsAllowed'] as bool?,
      originalQuery: json['originalQuery'] as String?,
      correctedQuery: json['correctedQuery'] as String?,
      searchTermRedirectUrl: json['searchTermRedirectUrl'],
      priceRange: json['priceRange'] == null
          ? null
          : PriceRange.fromJson(json['priceRange'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetProductCollectionResultToJson(
    GetProductCollectionResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  writeNotNull('categoryFacets',
      instance.categoryFacets?.map((e) => e.toJson()).toList());
  writeNotNull('attributeTypeFacets',
      instance.attributeTypeFacets?.map((e) => e.toJson()).toList());
  writeNotNull(
      'brandFacets', instance.brandFacets?.map((e) => e.toJson()).toList());
  writeNotNull('productLineFacets',
      instance.productLineFacets?.map((e) => e.toJson()).toList());
  writeNotNull('didYouMeanSuggestions',
      instance.didYouMeanSuggestions?.map((e) => e.toJson()).toList());
  writeNotNull('exactMatch', instance.exactMatch);
  writeNotNull('notAllProductsFound', instance.notAllProductsFound);
  writeNotNull('notAllProductsAllowed', instance.notAllProductsAllowed);
  writeNotNull('originalQuery', instance.originalQuery);
  writeNotNull('correctedQuery', instance.correctedQuery);
  writeNotNull('searchTermRedirectUrl', instance.searchTermRedirectUrl);
  writeNotNull('priceRange', instance.priceRange?.toJson());
  return val;
}
