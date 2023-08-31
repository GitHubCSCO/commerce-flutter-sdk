extension CompatibilityExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNullorWhitespace {
    return this == null || this!.trim().isEmpty;
  }
}
