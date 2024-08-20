import 'package:json_annotation/json_annotation.dart';

part 'base_configuration.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseConfiguration {
  BaseConfiguration({
    this.shouldUseStaticDomain,
    this.domain,
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

  BaseConfiguration copyWith({
    bool? shouldUseStaticDomain,
    String? domain,
    String? checkoutUrl,
    String? startingCategoryForBrowsing,
    bool? hasCheckout,
    bool? viewOnWebsiteEnabled,
    bool? customHideCheckoutOrderNotes,
    String? firebaseAndroidApiKey,
    String? firebaseAndroidAppId,
    String? firebaseAndroidMessagingSenderId,
    String? firebaseAndroidProjectId,
    String? firebaseAndroidStorageBucket,
    String? firebaseIOSApiKey,
    String? firebaseIOSAppId,
    String? firebaseIOSMessagingSenderId,
    String? firebaseIOSProjectId,
    String? firebaseIOSStorageBucket,
    String? firebaseIOSBundleId,
    String? appCenterSecretiOS,
    String? appCenterSecretAndroid,
  }) {
    return BaseConfiguration(
      shouldUseStaticDomain:
          shouldUseStaticDomain ?? this.shouldUseStaticDomain,
      domain: domain ?? this.domain,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      startingCategoryForBrowsing:
          startingCategoryForBrowsing ?? this.startingCategoryForBrowsing,
      hasCheckout: hasCheckout ?? this.hasCheckout,
      viewOnWebsiteEnabled: viewOnWebsiteEnabled ?? this.viewOnWebsiteEnabled,
      customHideCheckoutOrderNotes:
          customHideCheckoutOrderNotes ?? this.customHideCheckoutOrderNotes,
      firebaseAndroidApiKey:
          firebaseAndroidApiKey ?? this.firebaseAndroidApiKey,
      firebaseAndroidAppId: firebaseAndroidAppId ?? this.firebaseAndroidAppId,
      firebaseAndroidMessagingSenderId: firebaseAndroidMessagingSenderId ??
          this.firebaseAndroidMessagingSenderId,
      firebaseAndroidProjectId:
          firebaseAndroidProjectId ?? this.firebaseAndroidProjectId,
      firebaseAndroidStorageBucket:
          firebaseAndroidStorageBucket ?? this.firebaseAndroidStorageBucket,
      firebaseIOSApiKey: firebaseIOSApiKey ?? this.firebaseIOSApiKey,
      firebaseIOSAppId: firebaseIOSAppId ?? this.firebaseIOSAppId,
      firebaseIOSMessagingSenderId:
          firebaseIOSMessagingSenderId ?? this.firebaseIOSMessagingSenderId,
      firebaseIOSProjectId: firebaseIOSProjectId ?? this.firebaseIOSProjectId,
      firebaseIOSStorageBucket:
          firebaseIOSStorageBucket ?? this.firebaseIOSStorageBucket,
      firebaseIOSBundleId: firebaseIOSBundleId ?? this.firebaseIOSBundleId,
      appCenterSecretiOS: appCenterSecretiOS ?? this.appCenterSecretiOS,
      appCenterSecretAndroid:
          appCenterSecretAndroid ?? this.appCenterSecretAndroid,
    );
  }
}
