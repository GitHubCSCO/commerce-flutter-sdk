class ChangeLanguageException implements Exception {
  final String message;
  ChangeLanguageException({required this.message});

  @override
  String toString() {
    return "ChangeLanguageException: $message";
  }
}

class LoadLanguageException implements Exception {
  final String message;
  LoadLanguageException({required this.message});

  @override
  String toString() {
    return "LoadLanguageException: $message";
  }
}

class GetTranslationException implements Exception {
  final String message;
  GetTranslationException({required this.message});

  @override
  String toString() {
    return "GetTranslationException: $message";
  }
}