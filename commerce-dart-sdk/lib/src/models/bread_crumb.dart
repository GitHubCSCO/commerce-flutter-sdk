import 'models.dart';

part 'bread_crumb.g.dart';

@JsonSerializable()
class BreadCrumb {
  String? text;

  String? url;

  String? categoryId;

  BreadCrumb({
    this.text,
    this.url,
    this.categoryId,
  });

  factory BreadCrumb.fromJson(Map<String, dynamic> json) =>
      _$BreadCrumbFromJson(json);

  Map<String, dynamic> toJson() => _$BreadCrumbToJson(this);
}
