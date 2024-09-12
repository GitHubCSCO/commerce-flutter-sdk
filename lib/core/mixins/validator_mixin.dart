mixin ValidatorMixin {
  String? validateEmail(String? value,
      {String? emptyWarning, String? invalidWarning}) {
    if (value == null || value.isEmpty) {
      return emptyWarning ?? 'Email cannot be empty';
    }
    // Regular expression for basic email validation
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return invalidWarning ?? 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhoneNumber(String? value,
      {String? emptyWarning, String? invalidWarning}) {
    if (value == null || value.isEmpty) {
      return emptyWarning ?? 'Phone Number cannot be empty';
    }
    // Regular expression for basic phone number validation
    String pattern = r'^\+?[1-9]\d{1,14}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return invalidWarning ?? 'Enter a valid phone number';
    }
    return null;
  }
}
