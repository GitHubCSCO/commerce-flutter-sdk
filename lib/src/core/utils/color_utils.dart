import 'dart:ui';

class ColorUtils {
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  static Color colorFromHexString(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // add alpha if it's not provided
    }

    final colorValue = int.tryParse(hexColor, radix: 16);
    return colorValue != null ? Color(colorValue) : const Color(0xFF000000);
  }

  static Color rgbaToColor(String rgba) {
    final regex = RegExp(r'rgba?\((\d+),\s*(\d+),\s*(\d+),\s*([\d.]+)\)');
    final match = regex.firstMatch(rgba);

    if (match == null) {
      return colorFromHexString(rgba);
    }

    int red = int.parse(match.group(1)!);
    int green = int.parse(match.group(2)!);
    int blue = int.parse(match.group(3)!);
    double alpha = double.parse(match.group(4)!);

    return Color.fromRGBO(red, green, blue, alpha);
  }
}
