import '../models.dart';

part 'dashboard_panels_result.g.dart';

@JsonSerializable()
class DashboardPanelsResult extends BaseModel {
  List<DashboardPanel>? dashboardPanels;

  DashboardPanelsResult({
    this.dashboardPanels,
  });

  factory DashboardPanelsResult.fromJson(Map<String, dynamic> json) =>
      _$DashboardPanelsResultFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardPanelsResultToJson(this);
}

@JsonSerializable()
class DashboardPanel {
  String? text;
  String? quickLinkText;
  String? url;
  int? count;
  bool? isPanel;
  bool? isQuickLink;
  String? panelType;
  int? order;
  int? quickLinkOrder;
  bool? openInNewTab;

  DashboardPanel({
    this.text,
    this.quickLinkText,
    this.url,
    this.count,
    this.isPanel,
    this.isQuickLink,
    this.panelType,
    this.order,
    this.quickLinkOrder,
    this.openInNewTab,
  });

  factory DashboardPanel.fromJson(Map<String, dynamic> json) =>
      _$DashboardPanelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardPanelToJson(this);
}
