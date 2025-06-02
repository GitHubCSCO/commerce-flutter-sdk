import '../models.dart';

part 'get_site_message_collection_result.g.dart';

@JsonSerializable()
class GetSiteMessageCollectionResult {
  List<SiteMessage>? siteMessages;

  GetSiteMessageCollectionResult({this.siteMessages});

  factory GetSiteMessageCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$GetSiteMessageCollectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetSiteMessageCollectionResultToJson(this);
}
