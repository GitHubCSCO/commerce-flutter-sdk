// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class ProductImageEntity extends Equatable {
  final String? id;
  final int? sortOrder;
  final String? name;
  final String? smallImagePath;
  final String? mediumImagePath;
  final String? largeImagePath;
  final String? altText;
  final String? imageType;

  const ProductImageEntity({
    this.id,
    this.sortOrder,
    this.name,
    this.smallImagePath,
    this.mediumImagePath,
    this.largeImagePath,
    this.altText,
    this.imageType,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ProductImageEntity copyWith({
    String? id,
    int? sortOrder,
    String? name,
    String? smallImagePath,
    String? mediumImagePath,
    String? largeImagePath,
    String? altText,
    String? imageType,
  }) {
    return ProductImageEntity(
      id: id ?? this.id,
      sortOrder: sortOrder ?? this.sortOrder,
      name: name ?? this.name,
      smallImagePath: smallImagePath ?? this.smallImagePath,
      mediumImagePath: mediumImagePath ?? this.mediumImagePath,
      largeImagePath: largeImagePath ?? this.largeImagePath,
      altText: altText ?? this.altText,
      imageType: imageType ?? this.imageType,
    );
  }
}
