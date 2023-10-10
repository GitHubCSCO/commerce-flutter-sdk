class JsonEncodingMethods {
  JsonEncodingMethods._();

  static Map<String, dynamic> convertAttributesToString(dynamic data) {
    data.forEach((key, value) {
      if ((value is num) || (value is bool)) {
        data[key] = value.toString();
      }
    });

    return data;
  }
}
