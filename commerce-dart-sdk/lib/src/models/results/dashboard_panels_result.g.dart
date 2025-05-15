// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_panels_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardPanelsResult _$DashboardPanelsResultFromJson(
        Map<String, dynamic> json) =>
    DashboardPanelsResult(
      dashboardPanels: (json['dashboardPanels'] as List<dynamic>?)
          ?.map((e) => DashboardPanel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$DashboardPanelsResultToJson(
    DashboardPanelsResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('dashboardPanels',
      instance.dashboardPanels?.map((e) => e.toJson()).toList());
  return val;
}

DashboardPanel _$DashboardPanelFromJson(Map<String, dynamic> json) =>
    DashboardPanel(
      text: json['text'] as String?,
      quickLinkText: json['quickLinkText'] as String?,
      url: json['url'] as String?,
      count: (json['count'] as num?)?.toInt(),
      isPanel: json['isPanel'] as bool?,
      isQuickLink: json['isQuickLink'] as bool?,
      panelType: json['panelType'] as String?,
      order: (json['order'] as num?)?.toInt(),
      quickLinkOrder: (json['quickLinkOrder'] as num?)?.toInt(),
      openInNewTab: json['openInNewTab'] as bool?,
    );

Map<String, dynamic> _$DashboardPanelToJson(DashboardPanel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('text', instance.text);
  writeNotNull('quickLinkText', instance.quickLinkText);
  writeNotNull('url', instance.url);
  writeNotNull('count', instance.count);
  writeNotNull('isPanel', instance.isPanel);
  writeNotNull('isQuickLink', instance.isQuickLink);
  writeNotNull('panelType', instance.panelType);
  writeNotNull('order', instance.order);
  writeNotNull('quickLinkOrder', instance.quickLinkOrder);
  writeNotNull('openInNewTab', instance.openInNewTab);
  return val;
}
