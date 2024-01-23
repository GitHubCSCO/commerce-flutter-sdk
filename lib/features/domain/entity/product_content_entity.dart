// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductContentEntity extends Equatable {
  final String? htmlContent;
  final String? metaDescription;
  final String? pageTitle;
  final String? metaKeywords;
  final String? openGraphImage;
  final String? openGraphTitle;
  final String? openGraphUrl;

  const ProductContentEntity({
    this.htmlContent,
    this.metaDescription,
    this.pageTitle,
    this.metaKeywords,
    this.openGraphImage,
    this.openGraphTitle,
    this.openGraphUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ProductContentEntity copyWith({
    String? htmlContent,
    String? metaDescription,
    String? pageTitle,
    String? metaKeywords,
    String? openGraphImage,
    String? openGraphTitle,
    String? openGraphUrl,
  }) {
    return ProductContentEntity(
      htmlContent: htmlContent ?? this.htmlContent,
      metaDescription: metaDescription ?? this.metaDescription,
      pageTitle: pageTitle ?? this.pageTitle,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      openGraphImage: openGraphImage ?? this.openGraphImage,
      openGraphTitle: openGraphTitle ?? this.openGraphTitle,
      openGraphUrl: openGraphUrl ?? this.openGraphUrl,
    );
  }
}
