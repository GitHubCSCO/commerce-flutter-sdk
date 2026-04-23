import 'models.dart';

part 'badge.g.dart';

@JsonSerializable(explicitToJson: true)
class Badge {
  Badge({
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

  String? id;

  String? name;

  String? tagName;

  String? badgeStyle;

  int? sortOrder;

  String? badgeType;

  bool? displayOnProductImages;

  bool? displayOnBadgeWidget;

  String? displayText;

  String? textColorHexCode;

  String? badgeColorHexCode;

  String? largeImageBadgePath;

  String? largeImageTextSize;

  String? largeImagePlacement;

  String? otherImageBadgePath;

  String? otherImageTextSize;

  String? otherImagePlacement;

  String? imageAltText;

  String? detailWidgetBadgeSize;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
