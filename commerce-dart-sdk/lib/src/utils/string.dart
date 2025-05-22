extension CompatibilityExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNullorWhitespace {
    return this == null || this!.trim().isEmpty;
  }

  bool equalsIgnoreCase(String? string) {
    return this?.toLowerCase() == string?.toLowerCase();
  }

  String? stripHtml() {
    return this?.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
