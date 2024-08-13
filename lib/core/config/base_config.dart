import 'package:json_annotation/json_annotation.dart';

part 'base_config.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseConfiguration {
  BaseConfiguration({
    this.shouldUseStaticDomain,
    this.domain,
    this.sandboxDomain,
    this.checkoutUrl,
    this.startingCategoryForBrowsing,
    this.hasCheckout,
    this.viewOnWebsiteEnabled,
    this.customHideCheckoutOrderNotes,
    this.firebaseAndroidApiKey,
    this.firebaseAndroidAppId,
    this.firebaseAndroidMessagingSenderId,
    this.firebaseAndroidProjectId,
    this.firebaseAndroidStorageBucket,
    this.firebaseIOSApiKey,
    this.firebaseIOSAppId,
    this.firebaseIOSMessagingSenderId,
    this.firebaseIOSProjectId,
    this.firebaseIOSStorageBucket,
    this.firebaseIOSBundleId,
    this.appCenterSecretiOS,
    this.appCenterSecretAndroid,
  });

  bool? shouldUseStaticDomain;

  String? domain;

  String? sandboxDomain;

  String? checkoutUrl;

  String? startingCategoryForBrowsing;

  bool? hasCheckout;

  bool? viewOnWebsiteEnabled;

  bool? customHideCheckoutOrderNotes;

  String? firebaseAndroidApiKey;

  String? firebaseAndroidAppId;

  String? firebaseAndroidMessagingSenderId;

  String? firebaseAndroidProjectId;

  String? firebaseAndroidStorageBucket;

  String? firebaseIOSApiKey;

  String? firebaseIOSAppId;

  String? firebaseIOSMessagingSenderId;

  String? firebaseIOSProjectId;

  String? firebaseIOSStorageBucket;

  String? firebaseIOSBundleId;

  String? appCenterSecretiOS;

  String? appCenterSecretAndroid;

  factory BaseConfiguration.fromJson(Map<String, dynamic> json) =>
      _$BaseConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$BaseConfigurationToJson(this);
}
