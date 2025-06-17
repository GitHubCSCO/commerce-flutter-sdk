// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductContent _$ProductContentFromJson(Map<String, dynamic> json) =>
    ProductContent(
      htmlContent: json['htmlContent'] as String?,
      metaDescription: json['metaDescription'] as String?,
      pageTitle: json['pageTitle'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      openGraphImage: json['openGraphImage'] as String?,
      openGraphTitle: json['openGraphTitle'] as String?,
      openGraphUrl: json['openGraphUrl'] as String?,
    );

Map<String, dynamic> _$ProductContentToJson(ProductContent instance) =>
    <String, dynamic>{
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.pageTitle case final value?) 'pageTitle': value,
      if (instance.metaDescription case final value?) 'metaDescription': value,
      if (instance.metaKeywords case final value?) 'metaKeywords': value,
      if (instance.openGraphTitle case final value?) 'openGraphTitle': value,
      if (instance.openGraphUrl case final value?) 'openGraphUrl': value,
      if (instance.openGraphImage case final value?) 'openGraphImage': value,
    };
