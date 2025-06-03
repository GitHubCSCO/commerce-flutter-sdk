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
        DashboardPanelsResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.dashboardPanels?.map((e) => e.toJson()).toList()
          case final value?)
        'dashboardPanels': value,
    };

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

Map<String, dynamic> _$DashboardPanelToJson(DashboardPanel instance) =>
    <String, dynamic>{
      if (instance.text case final value?) 'text': value,
      if (instance.quickLinkText case final value?) 'quickLinkText': value,
      if (instance.url case final value?) 'url': value,
      if (instance.count case final value?) 'count': value,
      if (instance.isPanel case final value?) 'isPanel': value,
      if (instance.isQuickLink case final value?) 'isQuickLink': value,
      if (instance.panelType case final value?) 'panelType': value,
      if (instance.order case final value?) 'order': value,
      if (instance.quickLinkOrder case final value?) 'quickLinkOrder': value,
      if (instance.openInNewTab case final value?) 'openInNewTab': value,
    };
