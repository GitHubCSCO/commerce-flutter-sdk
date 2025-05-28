extension StringFormatExtension on String {
  String format(List<dynamic>? replacements) {
    if (replacements == null || replacements.isEmpty) {
      return this;
    }

    var index = 0;
    return replaceAllMapped(RegExp(r'%s'), (match) {
      if (index >= replacements.length) {
        return this;
      }
      return replacements[index++].toString();
    });
  }

  String capitalize() {
    if (this == null || this.isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + this.substring(1);
  }
}
