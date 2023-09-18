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

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('userName', instance.userName);
  writeNotNull('password', instance.password);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull('isGuest', instance.isGuest);
  writeNotNull('canApproveOrders', instance.canApproveOrders);
  writeNotNull('canViewApprovalOrders', instance.canViewApprovalOrders);
  writeNotNull('billToId', instance.billToId);
  writeNotNull('shipToId', instance.shipToId);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('role', instance.role);
  writeNotNull('approver', instance.approver);
  writeNotNull('isApproved', instance.isApproved);
  writeNotNull('activationStatus', instance.activationStatus);
  writeNotNull('defaultLocation', instance.defaultLocation);
  writeNotNull('lastLoginOn', instance.lastLoginOn?.toIso8601String());
  writeNotNull('availableApprovers', instance.availableApprovers);
  writeNotNull('availableRoles', instance.availableRoles);
  writeNotNull('setDefaultCustomer', instance.setDefaultCustomer);
  writeNotNull('defaultCustomerId', instance.defaultCustomerId);
  writeNotNull('defaultFulfillmentMethod', instance.defaultFulfillmentMethod);
  writeNotNull('defaultWarehouse', instance.defaultWarehouse?.toJson());
  writeNotNull('defaultWarehouseId', instance.defaultWarehouseId);
  writeNotNull('accessToken', instance.accessToken);
  writeNotNull('vmiRole', instance.vmiRole);
  return val;
}

Vmi _$VmiFromJson(Map<String, dynamic> json) => Vmi(
      vmiUsers: (json['vmiUsers'] as List<dynamic>?)
          ?.map((e) => VmiUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$VmiToJson(Vmi instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('vmiUsers', instance.vmiUsers?.map((e) => e.toJson()).toList());
  return val;
}

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

Map<String, dynamic> _$VmiUserToJson(VmiUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('userId', instance.userId);
  writeNotNull('vmiLocationNames', instance.vmiLocationNames);
  writeNotNull('vmiRoles', instance.vmiRoles);
  return val;
}
