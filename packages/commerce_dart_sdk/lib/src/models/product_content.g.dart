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

Map<String, dynamic> _$ProductContentToJson(ProductContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('pageTitle', instance.pageTitle);
  writeNotNull('metaDescription', instance.metaDescription);
  writeNotNull('metaKeywords', instance.metaKeywords);
  writeNotNull('openGraphTitle', instance.openGraphTitle);
  writeNotNull('openGraphUrl', instance.openGraphUrl);
  writeNotNull('openGraphImage', instance.openGraphImage);
  return val;
}
