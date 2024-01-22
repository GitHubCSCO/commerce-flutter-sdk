extension UrlStringExtension on String {
  String makeValidUrl() {
    var trimmedDomainInput = trim();
    if (trimmedDomainInput.isEmpty) {
      return '';
    }

    // Add protocol if missing
    if (!trimmedDomainInput.startsWith('http://') &&
        !trimmedDomainInput.startsWith('https://')) {
      trimmedDomainInput = 'https://$trimmedDomainInput';
    }

    // Escape whitespace and other special characters
    trimmedDomainInput = Uri.encodeFull(trimmedDomainInput);

    // Check for well-formed URI
    if (!Uri.parse(trimmedDomainInput).isAbsolute) {
      return '';
    }

    return trimmedDomainInput;
  }
}
