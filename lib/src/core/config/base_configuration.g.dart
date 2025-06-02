// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseConfiguration _$BaseConfigurationFromJson(Map<String, dynamic> json) =>
    BaseConfiguration(
      domain: json['domain'] as String?,
      checkoutUrl: json['checkoutUrl'] as String?,
      startingCategoryForBrowsing:
          json['startingCategoryForBrowsing'] as String?,
      hasCheckout: json['hasCheckout'] as bool?,
      viewOnWebsiteEnabled: json['viewOnWebsiteEnabled'] as bool?,
      customHideCheckoutOrderNotes:
          json['customHideCheckoutOrderNotes'] as bool?,
      firebaseAndroidApiKey: json['firebaseAndroidApiKey'] as String?,
      firebaseAndroidAppId: json['firebaseAndroidAppId'] as String?,
      firebaseAndroidMessagingSenderId:
          json['firebaseAndroidMessagingSenderId'] as String?,
      firebaseAndroidProjectId: json['firebaseAndroidProjectId'] as String?,
      firebaseAndroidStorageBucket:
          json['firebaseAndroidStorageBucket'] as String?,
      firebaseIOSApiKey: json['firebaseIOSApiKey'] as String?,
      firebaseIOSAppId: json['firebaseIOSAppId'] as String?,
      firebaseIOSMessagingSenderId:
          json['firebaseIOSMessagingSenderId'] as String?,
      firebaseIOSProjectId: json['firebaseIOSProjectId'] as String?,
      firebaseIOSStorageBucket: json['firebaseIOSStorageBucket'] as String?,
      firebaseIOSBundleId: json['firebaseIOSBundleId'] as String?,
      appCenterSecretiOS: json['appCenterSecretiOS'] as String?,
      appCenterSecretAndroid: json['appCenterSecretAndroid'] as String?,
    );

Map<String, dynamic> _$BaseConfigurationToJson(BaseConfiguration instance) =>
    <String, dynamic>{
      'domain': instance.domain,
      'checkoutUrl': instance.checkoutUrl,
      'startingCategoryForBrowsing': instance.startingCategoryForBrowsing,
      'hasCheckout': instance.hasCheckout,
      'viewOnWebsiteEnabled': instance.viewOnWebsiteEnabled,
      'customHideCheckoutOrderNotes': instance.customHideCheckoutOrderNotes,
      'firebaseAndroidApiKey': instance.firebaseAndroidApiKey,
      'firebaseAndroidAppId': instance.firebaseAndroidAppId,
      'firebaseAndroidMessagingSenderId':
          instance.firebaseAndroidMessagingSenderId,
      'firebaseAndroidProjectId': instance.firebaseAndroidProjectId,
      'firebaseAndroidStorageBucket': instance.firebaseAndroidStorageBucket,
      'firebaseIOSApiKey': instance.firebaseIOSApiKey,
      'firebaseIOSAppId': instance.firebaseIOSAppId,
      'firebaseIOSMessagingSenderId': instance.firebaseIOSMessagingSenderId,
      'firebaseIOSProjectId': instance.firebaseIOSProjectId,
      'firebaseIOSStorageBucket': instance.firebaseIOSStorageBucket,
      'firebaseIOSBundleId': instance.firebaseIOSBundleId,
      'appCenterSecretiOS': instance.appCenterSecretiOS,
      'appCenterSecretAndroid': instance.appCenterSecretAndroid,
    };
