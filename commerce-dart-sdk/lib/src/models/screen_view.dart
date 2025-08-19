import 'package:json_annotation/json_annotation.dart';

part 'screen_view.g.dart';

@JsonSerializable()
class ScreenView {
  final String? screenName;
  final Map<String, dynamic>? properties;

  ScreenView({
    this.screenName,
    this.properties,
  });

  factory ScreenView.fromJson(Map<String, dynamic> json) =>
      _$ScreenViewFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenViewToJson(this);
}
