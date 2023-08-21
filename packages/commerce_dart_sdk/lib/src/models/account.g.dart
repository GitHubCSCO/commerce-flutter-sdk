// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account()
  ..uri = json['uri'] as String?
  ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  )
  ..id = json['id'] as String
  ..email = json['email'] as String
  ..userName = json['userName'] as String
  ..password = json['password'] as String
  ..isSubscribed = json['isSubscribed'] as bool?
  ..isGuest = json['isGuest'] as bool
  ..canApproveOrders = json['canApproveOrders'] as bool
  ..canViewApprovalOrders = json['canViewApprovalOrders'] as bool
  ..billToId = json['billToId'] as String?
  ..shipToId = json['shipToId'] as String?
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..role = json['role'] as String
  ..approver = json['approver'] as String
  ..isApproved = json['isApproved'] as bool?
  ..activationStatus = json['activationStatus'] as String
  ..defaultLocation = json['defaultLocation'] as String
  ..lastLoginOn = json['lastLoginOn'] == null
      ? null
      : DateTime.parse(json['lastLoginOn'] as String)
  ..availableApprovers = (json['availableApprovers'] as List<dynamic>)
      .map((e) => e as String)
      .toList()
  ..availableRoles =
      (json['availableRoles'] as List<dynamic>).map((e) => e as String).toList()
  ..setDefaultCustomer = json['setDefaultCustomer'] as bool
  ..defaultCustomerId = json['defaultCustomerId'] as String
  ..defaultFulfillmentMethod = json['defaultFulfillmentMethod'] as String
  ..defaultWarehouse =
      Warehouse.fromJson(json['defaultWarehouse'] as Map<String, dynamic>)
  ..defaultWarehouseId = json['defaultWarehouseId'] as String
  ..accessToken = json['accessToken'] as String
  ..vmiRole = json['vmiRole'] as String;

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'email': instance.email,
      'userName': instance.userName,
      'password': instance.password,
      'isSubscribed': instance.isSubscribed,
      'isGuest': instance.isGuest,
      'canApproveOrders': instance.canApproveOrders,
      'canViewApprovalOrders': instance.canViewApprovalOrders,
      'billToId': instance.billToId,
      'shipToId': instance.shipToId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'role': instance.role,
      'approver': instance.approver,
      'isApproved': instance.isApproved,
      'activationStatus': instance.activationStatus,
      'defaultLocation': instance.defaultLocation,
      'lastLoginOn': instance.lastLoginOn?.toIso8601String(),
      'availableApprovers': instance.availableApprovers,
      'availableRoles': instance.availableRoles,
      'setDefaultCustomer': instance.setDefaultCustomer,
      'defaultCustomerId': instance.defaultCustomerId,
      'defaultFulfillmentMethod': instance.defaultFulfillmentMethod,
      'defaultWarehouse': instance.defaultWarehouse.toJson(),
      'defaultWarehouseId': instance.defaultWarehouseId,
      'accessToken': instance.accessToken,
      'vmiRole': instance.vmiRole,
    };

Vmi _$VmiFromJson(Map<String, dynamic> json) => Vmi()
  ..uri = json['uri'] as String?
  ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  )
  ..vmiUsers = (json['vmiUsers'] as List<dynamic>)
      .map((e) => VmiUser.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$VmiToJson(Vmi instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'vmiUsers': instance.vmiUsers.map((e) => e.toJson()).toList(),
    };

VmiUser _$VmiUserFromJson(Map<String, dynamic> json) => VmiUser()
  ..uri = json['uri'] as String?
  ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  )
  ..userId = json['userId'] as String
  ..vmiLocationNames = (json['vmiLocationNames'] as List<dynamic>)
      .map((e) => e as String)
      .toList()
  ..vmiRoles =
      (json['vmiRoles'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$VmiUserToJson(VmiUser instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'userId': instance.userId,
      'vmiLocationNames': instance.vmiLocationNames,
      'vmiRoles': instance.vmiRoles,
    };
