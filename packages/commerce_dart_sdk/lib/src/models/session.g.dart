// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      activateAccount: json['activateAccount'] as bool?,
      billTo: json['billTo'] == null
          ? null
          : BillTo.fromJson(json['billTo'] as Map<String, dynamic>),
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      customLandingPage: json['customLandingPage'] as String?,
      customerWasUpdated: json['customerWasUpdated'] as bool?,
      dashboardIsHomepage: json['dashboardIsHomepage'] as bool?,
      deviceType: json['deviceType'] as String?,
      displayChangeCustomerLink: json['displayChangeCustomerLink'] as bool?,
      displayPricingAndInventory: json['displayPricingAndInventory'] as bool?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      fulfillmentMethod: json['fulfillmentMethod'] as String?,
      hasDefaultCustomer: json['hasDefaultCustomer'] as bool?,
      hasRfqUpdates: json['hasRfqUpdates'] as bool?,
      isAuthenticated: json['isAuthenticated'] as bool?,
      isGuest: json['isGuest'] as bool?,
      isRestrictedProductRemovedFromCart:
          json['isRestrictedProductRemovedFromCart'] as bool?,
      isSalesPerson: json['isSalesPerson'] as bool?,
      language: json['language'] == null
          ? null
          : Language.fromJson(json['language'] as Map<String, dynamic>),
      lastName: json['lastName'] as String?,
      newPassword: json['newPassword'] as String?,
      password: json['password'] as String?,
      persona: json['persona'] as String?,
      personas: (json['personas'] as List<dynamic>?)
          ?.map((e) => Persona.fromJson(e as Map<String, dynamic>))
          .toList(),
      pickUpWarehouse: json['pickUpWarehouse'] == null
          ? null
          : Warehouse.fromJson(json['pickUpWarehouse'] as Map<String, dynamic>),
      redirectToChangeCustomerPageOnSignIn:
          json['redirectToChangeCustomerPageOnSignIn'] as bool?,
      rememberMe: json['rememberMe'] as bool?,
      resetPassword: json['resetPassword'] as bool?,
      resetToken: json['resetToken'] as String?,
      shipTo: json['shipTo'] == null
          ? null
          : ShipTo.fromJson(json['shipTo'] as Map<String, dynamic>),
      userLabel: json['userLabel'] as String?,
      userName: json['userName'] as String?,
      userProfileId: json['userProfileId'] as String?,
      userRoles: json['userRoles'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'isAuthenticated': instance.isAuthenticated,
      'hasRfqUpdates': instance.hasRfqUpdates,
      'userName': instance.userName,
      'userProfileId': instance.userProfileId,
      'userLabel': instance.userLabel,
      'userRoles': instance.userRoles,
      'email': instance.email,
      'password': instance.password,
      'newPassword': instance.newPassword,
      'resetPassword': instance.resetPassword,
      'activateAccount': instance.activateAccount,
      'resetToken': instance.resetToken,
      'displayChangeCustomerLink': instance.displayChangeCustomerLink,
      'redirectToChangeCustomerPageOnSignIn':
          instance.redirectToChangeCustomerPageOnSignIn,
      'billTo': instance.billTo?.toJson(),
      'shipTo': instance.shipTo?.toJson(),
      'language': instance.language?.toJson(),
      'currency': instance.currency?.toJson(),
      'deviceType': instance.deviceType,
      'persona': instance.persona,
      'personas': instance.personas?.map((e) => e.toJson()).toList(),
      'dashboardIsHomepage': instance.dashboardIsHomepage,
      'isSalesPerson': instance.isSalesPerson,
      'customLandingPage': instance.customLandingPage,
      'hasDefaultCustomer': instance.hasDefaultCustomer,
      'rememberMe': instance.rememberMe,
      'isRestrictedProductRemovedFromCart':
          instance.isRestrictedProductRemovedFromCart,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'customerWasUpdated': instance.customerWasUpdated,
      'isGuest': instance.isGuest,
      'fulfillmentMethod': instance.fulfillmentMethod,
      'displayPricingAndInventory': instance.displayPricingAndInventory,
      'pickUpWarehouse': instance.pickUpWarehouse?.toJson(),
    };

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      description: json['description'] as String?,
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isDefault': instance.isDefault,
    };
