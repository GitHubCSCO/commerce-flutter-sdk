import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

enum TextJustification {
  left,
  center,
  right,
}

class CarouselSlideWidgetEntity extends WidgetEntity {
  final String? imagePath;
  final String? link;
  final String? primaryText;
  final String? secondaryText;
  final bool? applyDarkOverlayToImage;
  final String? primaryTextColorHex;
  final String? secondaryTextColorHex;
  final TextJustification? textJustification;

  const CarouselSlideWidgetEntity({
    required this.imagePath,
    required this.link,
    required this.primaryText,
    required this.secondaryText,
    this.applyDarkOverlayToImage,
    required this.primaryTextColorHex,
    required this.secondaryTextColorHex,
    required this.textJustification,
  });

  @override
  List<Object?> get props => [
        imagePath,
        link,
        primaryText,
        secondaryText,
        applyDarkOverlayToImage,
        primaryTextColorHex,
        secondaryTextColorHex,
        textJustification,
      ];
}
