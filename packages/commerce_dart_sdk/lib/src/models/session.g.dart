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

Map<String, dynamic> _$SessionToJson(Session instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('isAuthenticated', instance.isAuthenticated);
  writeNotNull('hasRfqUpdates', instance.hasRfqUpdates);
  writeNotNull('userName', instance.userName);
  writeNotNull('userProfileId', instance.userProfileId);
  writeNotNull('userLabel', instance.userLabel);
  writeNotNull('userRoles', instance.userRoles);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('newPassword', instance.newPassword);
  writeNotNull('resetPassword', instance.resetPassword);
  writeNotNull('activateAccount', instance.activateAccount);
  writeNotNull('resetToken', instance.resetToken);
  writeNotNull('displayChangeCustomerLink', instance.displayChangeCustomerLink);
  writeNotNull('redirectToChangeCustomerPageOnSignIn',
      instance.redirectToChangeCustomerPageOnSignIn);
  writeNotNull('billTo', instance.billTo?.toJson());
  writeNotNull('shipTo', instance.shipTo?.toJson());
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('currency', instance.currency?.toJson());
  writeNotNull('deviceType', instance.deviceType);
  writeNotNull('persona', instance.persona);
  writeNotNull('personas', instance.personas?.map((e) => e.toJson()).toList());
  writeNotNull('dashboardIsHomepage', instance.dashboardIsHomepage);
  writeNotNull('isSalesPerson', instance.isSalesPerson);
  writeNotNull('customLandingPage', instance.customLandingPage);
  writeNotNull('hasDefaultCustomer', instance.hasDefaultCustomer);
  writeNotNull('rememberMe', instance.rememberMe);
  writeNotNull('isRestrictedProductRemovedFromCart',
      instance.isRestrictedProductRemovedFromCart);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('customerWasUpdated', instance.customerWasUpdated);
  writeNotNull('isGuest', instance.isGuest);
  writeNotNull('fulfillmentMethod', instance.fulfillmentMethod);
  writeNotNull(
      'displayPricingAndInventory', instance.displayPricingAndInventory);
  writeNotNull('pickUpWarehouse', instance.pickUpWarehouse?.toJson());
  return val;
}

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      description: json['description'] as String?,
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('isDefault', instance.isDefault);
  return val;
}
