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
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.email case final value?) 'email': value,
      if (instance.userName case final value?) 'userName': value,
      if (instance.password case final value?) 'password': value,
      if (instance.isSubscribed case final value?) 'isSubscribed': value,
      if (instance.isGuest case final value?) 'isGuest': value,
      if (instance.canApproveOrders case final value?)
        'canApproveOrders': value,
      if (instance.canViewApprovalOrders case final value?)
        'canViewApprovalOrders': value,
      if (instance.billToId case final value?) 'billToId': value,
      if (instance.shipToId case final value?) 'shipToId': value,
      if (instance.firstName case final value?) 'firstName': value,
      if (instance.lastName case final value?) 'lastName': value,
      if (instance.role case final value?) 'role': value,
      if (instance.approver case final value?) 'approver': value,
      if (instance.isApproved case final value?) 'isApproved': value,
      if (instance.activationStatus case final value?)
        'activationStatus': value,
      if (instance.defaultLocation case final value?) 'defaultLocation': value,
      if (instance.lastLoginOn?.toIso8601String() case final value?)
        'lastLoginOn': value,
      if (instance.availableApprovers case final value?)
        'availableApprovers': value,
      if (instance.availableRoles case final value?) 'availableRoles': value,
      if (instance.setDefaultCustomer case final value?)
        'setDefaultCustomer': value,
      if (instance.defaultCustomerId case final value?)
        'defaultCustomerId': value,
      if (instance.defaultFulfillmentMethod case final value?)
        'defaultFulfillmentMethod': value,
      if (instance.defaultWarehouse?.toJson() case final value?)
        'defaultWarehouse': value,
      if (instance.defaultWarehouseId case final value?)
        'defaultWarehouseId': value,
      if (instance.accessToken case final value?) 'accessToken': value,
      if (instance.vmiRole case final value?) 'vmiRole': value,
    };

Vmi _$VmiFromJson(Map<String, dynamic> json) => Vmi(
      vmiUsers: (json['vmiUsers'] as List<dynamic>?)
          ?.map((e) => VmiUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiToJson(Vmi instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.vmiUsers?.map((e) => e.toJson()).toList() case final value?)
        'vmiUsers': value,
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
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiUserToJson(VmiUser instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.userId case final value?) 'userId': value,
      if (instance.vmiLocationNames case final value?)
        'vmiLocationNames': value,
      if (instance.vmiRoles case final value?) 'vmiRoles': value,
    };
