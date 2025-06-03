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
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.isAuthenticated case final value?) 'isAuthenticated': value,
      if (instance.hasRfqUpdates case final value?) 'hasRfqUpdates': value,
      if (instance.userName case final value?) 'userName': value,
      if (instance.userProfileId case final value?) 'userProfileId': value,
      if (instance.userLabel case final value?) 'userLabel': value,
      if (instance.userRoles case final value?) 'userRoles': value,
      if (instance.email case final value?) 'email': value,
      if (instance.password case final value?) 'password': value,
      if (instance.newPassword case final value?) 'newPassword': value,
      if (instance.resetPassword case final value?) 'resetPassword': value,
      if (instance.activateAccount case final value?) 'activateAccount': value,
      if (instance.resetToken case final value?) 'resetToken': value,
      if (instance.displayChangeCustomerLink case final value?)
        'displayChangeCustomerLink': value,
      if (instance.redirectToChangeCustomerPageOnSignIn case final value?)
        'redirectToChangeCustomerPageOnSignIn': value,
      if (instance.billTo?.toJson() case final value?) 'billTo': value,
      if (instance.shipTo?.toJson() case final value?) 'shipTo': value,
      if (instance.language?.toJson() case final value?) 'language': value,
      if (instance.currency?.toJson() case final value?) 'currency': value,
      if (instance.deviceType case final value?) 'deviceType': value,
      if (instance.persona case final value?) 'persona': value,
      if (instance.personas?.map((e) => e.toJson()).toList() case final value?)
        'personas': value,
      if (instance.dashboardIsHomepage case final value?)
        'dashboardIsHomepage': value,
      if (instance.isSalesPerson case final value?) 'isSalesPerson': value,
      if (instance.customLandingPage case final value?)
        'customLandingPage': value,
      if (instance.hasDefaultCustomer case final value?)
        'hasDefaultCustomer': value,
      if (instance.rememberMe case final value?) 'rememberMe': value,
      if (instance.isRestrictedProductRemovedFromCart case final value?)
        'isRestrictedProductRemovedFromCart': value,
      if (instance.firstName case final value?) 'firstName': value,
      if (instance.lastName case final value?) 'lastName': value,
      if (instance.customerWasUpdated case final value?)
        'customerWasUpdated': value,
      if (instance.isGuest case final value?) 'isGuest': value,
      if (instance.fulfillmentMethod case final value?)
        'fulfillmentMethod': value,
      if (instance.displayPricingAndInventory case final value?)
        'displayPricingAndInventory': value,
      if (instance.pickUpWarehouse?.toJson() case final value?)
        'pickUpWarehouse': value,
    };

Persona _$PersonaFromJson(Map<String, dynamic> json) => Persona(
      description: json['description'] as String?,
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };
