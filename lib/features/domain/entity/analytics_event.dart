class AnalyticsEvent {
  static const String eventPropertyScreenName = 'screen_name';

  final String eventName;
  final Map<String, String> properties = {};

  AnalyticsEvent(this.eventName, String area) {
    if (eventName.isEmpty) {
      throw ArgumentError('eventName cannot be null or empty');
    }
    if (area.isEmpty) {
      throw ArgumentError('area cannot be null or empty');
    }
    withProperty(name: eventPropertyScreenName, strValue: area);
  }

  AnalyticsEvent withProperty({required String name, String? strValue, bool? boolValue}) {
    if(strValue!=null){
      properties[name] = strValue;
    }
    if(boolValue!=null){
      properties[name] = boolValue.toString();
    }
    return this;
  }
}
