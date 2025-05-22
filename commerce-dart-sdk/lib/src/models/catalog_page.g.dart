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

Map<String, dynamic> _$CatalogPageToJson(CatalogPage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('category', instance.category?.toJson());
  writeNotNull('brandId', instance.brandId);
  writeNotNull('productLineId', instance.productLineId);
  writeNotNull('productId', instance.productId);
  writeNotNull('productName', instance.productName);
  writeNotNull('title', instance.title);
  writeNotNull('metaDescription', instance.metaDescription);
  writeNotNull('metaKeywords', instance.metaKeywords);
  writeNotNull('canonicalPath', instance.canonicalPath);
  writeNotNull('alternateLanguageUrls', instance.alternateLanguageUrls);
  writeNotNull('isReplacementProduct', instance.isReplacementProduct);
  writeNotNull(
      'breadCrumbs', instance.breadCrumbs?.map((e) => e.toJson()).toList());
  writeNotNull('obsoletePath', instance.obsoletePath);
  writeNotNull('needRedirect', instance.needRedirect);
  writeNotNull('redirectUrl', instance.redirectUrl);
  writeNotNull('primaryImagePath', instance.primaryImagePath);
  writeNotNull('openGraphTitle', instance.openGraphTitle);
  writeNotNull('openGraphImage', instance.openGraphImage);
  writeNotNull('openGraphUrl', instance.openGraphUrl);
  return val;
}
