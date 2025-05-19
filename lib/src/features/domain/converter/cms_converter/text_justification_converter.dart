import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';

class TextJustificationConverter {
  static TextJustification convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "left":
        return TextJustification.left;
      case "center":
        return TextJustification.center;
      case "right":
        return TextJustification.right;
      default:
        return TextJustification.left;
    }
  }
}
