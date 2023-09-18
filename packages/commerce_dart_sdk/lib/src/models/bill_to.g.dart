// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_to.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillTo _$BillToFromJson(Map<String, dynamic> json) => BillTo(
      accountsReceivable: json['accountsReceivable'] == null
          ? null
          : AccountsReceivable.fromJson(
              json['accountsReceivable'] as Map<String, dynamic>),
      budgetEnforcementLevel: json['budgetEnforcementLevel'] as String?,
      costCodeTitle: json['costCodeTitle'] as String?,
      costCodes: (json['costCodes'] as List<dynamic>?)
          ?.map((e) => CostCode.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerCurrencySymbol: json['customerCurrencySymbol'] as String?,
      isDefault: json['isDefault'] as bool?,
      isGuest: json['isGuest'] as bool?,
      shipTos: (json['shipTos'] as List<dynamic>?)
          ?.map((e) => ShipTo.fromJson(e as Map<String, dynamic>))
          .toList(),
      shipTosUri: json['shipTosUri'] as String?,
      validation: json['validation'] == null
          ? null
          : CustomerValidationDto.fromJson(
              json['validation'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      )
      ..id = json['id'] as String?
      ..customerNumber = json['customerNumber'] as String?
      ..customerSequence = json['customerSequence'] as String?
      ..customerName = json['customerName'] as String?
      ..label = json['label'] as String?
      ..firstName = json['firstName'] as String?
      ..lastName = json['lastName'] as String?
      ..companyName = json['companyName'] as String?
      ..attention = json['attention'] as String?
      ..address1 = json['address1'] as String?
      ..address2 = json['address2'] as String?
      ..address3 = json['address3'] as String?
      ..address4 = json['address4'] as String?
      ..city = json['city'] as String?
      ..postalCode = json['postalCode'] as String?
      ..state = json['state'] == null
          ? null
          : State.fromJson(json['state'] as Map<String, dynamic>)
      ..country = json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>)
      ..phone = json['phone'] as String?
      ..fullAddress = json['fullAddress'] as String?
      ..email = json['email'] as String?
      ..fax = json['fax'] as String?
      ..isVmiLocation = json['isVmiLocation'] as bool?;

Map<String, dynamic> _$BillToToJson(BillTo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('customerNumber', instance.customerNumber);
  writeNotNull('customerSequence', instance.customerSequence);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('label', instance.label);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('companyName', instance.companyName);
  writeNotNull('attention', instance.attention);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('address3', instance.address3);
  writeNotNull('address4', instance.address4);
  writeNotNull('city', instance.city);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('state', instance.state?.toJson());
  writeNotNull('country', instance.country?.toJson());
  writeNotNull('phone', instance.phone);
  writeNotNull('fullAddress', instance.fullAddress);
  writeNotNull('email', instance.email);
  writeNotNull('fax', instance.fax);
  writeNotNull('isVmiLocation', instance.isVmiLocation);
  writeNotNull('shipTosUri', instance.shipTosUri);
  writeNotNull('isGuest', instance.isGuest);
  writeNotNull('budgetEnforcementLevel', instance.budgetEnforcementLevel);
  writeNotNull('costCodeTitle', instance.costCodeTitle);
  writeNotNull('customerCurrencySymbol', instance.customerCurrencySymbol);
  writeNotNull(
      'costCodes', instance.costCodes?.map((e) => e.toJson()).toList());
  writeNotNull('shipTos', instance.shipTos?.map((e) => e.toJson()).toList());
  writeNotNull('validation', instance.validation?.toJson());
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('accountsReceivable', instance.accountsReceivable?.toJson());
  return val;
}

CostCode _$CostCodeFromJson(Map<String, dynamic> json) => CostCode(
      code: json['CostCode'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CostCodeToJson(CostCode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('CostCode', instance.code);
  writeNotNull('description', instance.description);
  writeNotNull('isActive', instance.isActive);
  return val;
}
