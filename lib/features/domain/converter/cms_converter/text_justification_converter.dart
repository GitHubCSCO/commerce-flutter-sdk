import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';

class TextJustificationConverter {
  static TextJustification convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "left":
        return TextJustification.left;
      case "cache":
        return TextJustification.cache;
      case "right":
        return TextJustification.right;
      default:
        return TextJustification.left;
    }
  }
}
