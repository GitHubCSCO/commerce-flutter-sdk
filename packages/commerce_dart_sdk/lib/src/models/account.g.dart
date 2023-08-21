// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      accessToken: json['accessToken'] as String?,
      activationStatus: json['activationStatus'] as String?,
      approver: json['approver'] as String?,
      availableApprovers: (json['availableApprovers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      availableRoles: (json['availableRoles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      billToId: json['billToId'] as String?,
      canApproveOrders: json['canApproveOrders'] as bool?,
      canViewApprovalOrders: json['canViewApprovalOrders'] as bool?,
      defaultCustomerId: json['defaultCustomerId'] as String?,
      defaultFulfillmentMethod: json['defaultFulfillmentMethod'] as String?,
      defaultLocation: json['defaultLocation'] as String?,
      defaultWarehouse: json['defaultWarehouse'] == null
          ? null
          : Warehouse.fromJson(
              json['defaultWarehouse'] as Map<String, dynamic>),
      defaultWarehouseId: json['defaultWarehouseId'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      id: json['id'] as String?,
      isApproved: json['isApproved'] as bool?,
      isGuest: json['isGuest'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
      lastLoginOn: json['lastLoginOn'] == null
          ? null
          : DateTime.parse(json['lastLoginOn'] as String),
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      setDefaultCustomer: json['setDefaultCustomer'] as bool?,
      shipToId: json['shipToId'] as String?,
      userName: json['userName'] as String?,
      vmiRole: json['vmiRole'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

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
      'defaultWarehouse': instance.defaultWarehouse?.toJson(),
      'defaultWarehouseId': instance.defaultWarehouseId,
      'accessToken': instance.accessToken,
      'vmiRole': instance.vmiRole,
    };

Vmi _$VmiFromJson(Map<String, dynamic> json) => Vmi(
      vmiUsers: (json['vmiUsers'] as List<dynamic>?)
          ?.map((e) => VmiUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$VmiToJson(Vmi instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'vmiUsers': instance.vmiUsers?.map((e) => e.toJson()).toList(),
    };

VmiUser _$VmiUserFromJson(Map<String, dynamic> json) => VmiUser(
      userId: json['userId'] as String?,
      vmiLocationNames: (json['vmiLocationNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      vmiRoles: (json['vmiRoles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$VmiUserToJson(VmiUser instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'userId': instance.userId,
      'vmiLocationNames': instance.vmiLocationNames,
      'vmiRoles': instance.vmiRoles,
    };
