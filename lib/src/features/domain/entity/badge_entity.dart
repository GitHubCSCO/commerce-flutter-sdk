// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class BadgeEntity extends Equatable {
  final String? id;
  final String? name;
  final String? tagName;
  final String? badgeStyle;
  final int? sortOrder;
  final String? badgeType;
  final bool? displayOnProductImages;
  final bool? displayOnBadgeWidget;
  final String? displayText;
  final String? textColorHexCode;
  final String? badgeColorHexCode;
  final String? largeImageBadgePath;
  final String? largeImageTextSize;
  final String? largeImagePlacement;
  final String? otherImageBadgePath;
  final String? otherImageTextSize;
  final String? otherImagePlacement;
  final String? imageAltText;
  final String? detailWidgetBadgeSize;

  const BadgeEntity({
    this.id,
    this.name,
    this.tagName,
    this.badgeStyle,
    this.sortOrder,
    this.badgeType,
    this.displayOnProductImages,
    this.displayOnBadgeWidget,
    this.displayText,
    this.textColorHexCode,
    this.badgeColorHexCode,
    this.largeImageBadgePath,
    this.largeImageTextSize,
    this.largeImagePlacement,
    this.otherImageBadgePath,
    this.otherImageTextSize,
    this.otherImagePlacement,
    this.imageAltText,
    this.detailWidgetBadgeSize,
  });

  @override
  List<Object?> get props => [id];
}
