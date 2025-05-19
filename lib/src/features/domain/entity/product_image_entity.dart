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
  List<Object?> get props => [
        id,
        sortOrder,
        name,
        smallImagePath,
        mediumImagePath,
        largeImagePath,
        altText,
        imageType,
      ];

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

  factory ProductImageEntity.fromJson(Map<String, dynamic> json) {
    return ProductImageEntity(
      id: json['id'] as String?,
      sortOrder: json['sortOrder'] as int?,
      name: json['name'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      largeImagePath: json['largeImagePath'] as String?,
      altText: json['altText'] as String?,
      imageType: json['imageType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sortOrder': sortOrder,
      'name': name,
      'smallImagePath': smallImagePath,
      'mediumImagePath': mediumImagePath,
      'largeImagePath': largeImagePath,
      'altText': altText,
      'imageType': imageType,
    };
  }
}
