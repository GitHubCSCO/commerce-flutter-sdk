// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogPage _$CatalogPageFromJson(Map<String, dynamic> json) => CatalogPage(
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      brandId: json['brandId'] as String?,
      productLineId: json['productLineId'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      title: json['title'] as String?,
      metaDescription: json['metaDescription'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      canonicalPath: json['canonicalPath'] as String?,
      alternateLanguageUrls:
          (json['alternateLanguageUrls'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      isReplacementProduct: json['isReplacementProduct'] as bool?,
      breadCrumbs: (json['breadCrumbs'] as List<dynamic>?)
          ?.map((e) => BreadCrumb.fromJson(e as Map<String, dynamic>))
          .toList(),
      obsoletePath: json['obsoletePath'] as bool?,
      needRedirect: json['needRedirect'] as bool?,
      redirectUrl: json['redirectUrl'] as String?,
      primaryImagePath: json['primaryImagePath'] as String?,
      openGraphTitle: json['openGraphTitle'] as String?,
      openGraphImage: json['openGraphImage'] as String?,
      openGraphUrl: json['openGraphUrl'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CatalogPageToJson(CatalogPage instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.category?.toJson() case final value?) 'category': value,
      if (instance.brandId case final value?) 'brandId': value,
      if (instance.productLineId case final value?) 'productLineId': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.title case final value?) 'title': value,
      if (instance.metaDescription case final value?) 'metaDescription': value,
      if (instance.metaKeywords case final value?) 'metaKeywords': value,
      if (instance.canonicalPath case final value?) 'canonicalPath': value,
      if (instance.alternateLanguageUrls case final value?)
        'alternateLanguageUrls': value,
      if (instance.isReplacementProduct case final value?)
        'isReplacementProduct': value,
      if (instance.breadCrumbs?.map((e) => e.toJson()).toList()
          case final value?)
        'breadCrumbs': value,
      if (instance.obsoletePath case final value?) 'obsoletePath': value,
      if (instance.needRedirect case final value?) 'needRedirect': value,
      if (instance.redirectUrl case final value?) 'redirectUrl': value,
      if (instance.primaryImagePath case final value?)
        'primaryImagePath': value,
      if (instance.openGraphTitle case final value?) 'openGraphTitle': value,
      if (instance.openGraphImage case final value?) 'openGraphImage': value,
      if (instance.openGraphUrl case final value?) 'openGraphUrl': value,
    };
