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
      'htmlContent': instance.htmlContent,
      'pageTitle': instance.pageTitle,
      'metaDescription': instance.metaDescription,
      'metaKeywords': instance.metaKeywords,
      'openGraphTitle': instance.openGraphTitle,
      'openGraphUrl': instance.openGraphUrl,
      'openGraphImage': instance.openGraphImage,
    };
