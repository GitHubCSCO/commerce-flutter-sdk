class TelemetryEvent {
  final String? eventName;
  final String? screenName;
  final Map<String, String> properties;

  TelemetryEvent({
    this.eventName,
    this.screenName,
    Map<String, String>? properties,
  }) : properties = properties ?? {} {
    if ((eventName == null || eventName!.isEmpty) &&
        (screenName == null || screenName!.isEmpty)) {
      throw ArgumentError(
          'Either eventName or screenName must be provided and non-empty.');
    }
  }

  TelemetryEvent withProperty(
      {required String name, String? strValue, bool? boolValue}) {
    if (strValue != null) {
      properties[name] = strValue;
    }
    if (boolValue != null) {
      properties[name] = boolValue.toString();
    }
    return this;
  }
}
