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
        GetProductCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.products?.map((e) => e.toJson()).toList() case final value?)
        'products': value,
      if (instance.categoryFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'categoryFacets': value,
      if (instance.attributeTypeFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'attributeTypeFacets': value,
      if (instance.brandFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'brandFacets': value,
      if (instance.productLineFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'productLineFacets': value,
      if (instance.didYouMeanSuggestions?.map((e) => e.toJson()).toList()
          case final value?)
        'didYouMeanSuggestions': value,
      if (instance.exactMatch case final value?) 'exactMatch': value,
      if (instance.notAllProductsFound case final value?)
        'notAllProductsFound': value,
      if (instance.notAllProductsAllowed case final value?)
        'notAllProductsAllowed': value,
      if (instance.originalQuery case final value?) 'originalQuery': value,
      if (instance.correctedQuery case final value?) 'correctedQuery': value,
      if (instance.searchTermRedirectUrl case final value?)
        'searchTermRedirectUrl': value,
      if (instance.priceRange?.toJson() case final value?) 'priceRange': value,
    };
