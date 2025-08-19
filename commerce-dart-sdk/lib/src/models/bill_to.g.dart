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
        (k, e) => MapEntry(k, e as String?),
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
          : StateModel.fromJson(json['state'] as Map<String, dynamic>)
      ..country = json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>)
      ..phone = json['phone'] as String?
      ..fullAddress = json['fullAddress'] as String?
      ..email = json['email'] as String?
      ..fax = json['fax'] as String?
      ..isVmiLocation = json['isVmiLocation'] as bool?;

Map<String, dynamic> _$BillToToJson(BillTo instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.customerNumber case final value?) 'customerNumber': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.label case final value?) 'label': value,
      if (instance.firstName case final value?) 'firstName': value,
      if (instance.lastName case final value?) 'lastName': value,
      if (instance.companyName case final value?) 'companyName': value,
      if (instance.attention case final value?) 'attention': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.address3 case final value?) 'address3': value,
      if (instance.address4 case final value?) 'address4': value,
      if (instance.city case final value?) 'city': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.state?.toJson() case final value?) 'state': value,
      if (instance.country?.toJson() case final value?) 'country': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.fullAddress case final value?) 'fullAddress': value,
      if (instance.email case final value?) 'email': value,
      if (instance.fax case final value?) 'fax': value,
      if (instance.isVmiLocation case final value?) 'isVmiLocation': value,
      if (instance.shipTosUri case final value?) 'shipTosUri': value,
      if (instance.isGuest case final value?) 'isGuest': value,
      if (instance.budgetEnforcementLevel case final value?)
        'budgetEnforcementLevel': value,
      if (instance.costCodeTitle case final value?) 'costCodeTitle': value,
      if (instance.customerCurrencySymbol case final value?)
        'customerCurrencySymbol': value,
      if (instance.costCodes?.map((e) => e.toJson()).toList() case final value?)
        'costCodes': value,
      if (instance.shipTos?.map((e) => e.toJson()).toList() case final value?)
        'shipTos': value,
      if (instance.validation?.toJson() case final value?) 'validation': value,
      if (instance.isDefault case final value?) 'isDefault': value,
      if (instance.accountsReceivable?.toJson() case final value?)
        'accountsReceivable': value,
    };

CostCode _$CostCodeFromJson(Map<String, dynamic> json) => CostCode(
      code: json['CostCode'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$CostCodeToJson(CostCode instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.code case final value?) 'CostCode': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isActive case final value?) 'isActive': value,
    };
