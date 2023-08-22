import 'models.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account extends BaseModel {
  Account({
    this.accessToken,
    this.activationStatus,
    this.approver,
    this.availableApprovers,
    this.availableRoles,
    this.billToId,
    this.canApproveOrders,
    this.canViewApprovalOrders,
    this.defaultCustomerId,
    this.defaultFulfillmentMethod,
    this.defaultLocation,
    this.defaultWarehouse,
    this.defaultWarehouseId,
    this.email,
    this.firstName,
    this.id,
    this.isApproved,
    this.isGuest,
    this.isSubscribed,
    this.lastLoginOn,
    this.lastName,
    this.password,
    this.requiresActivation,
    this.role,
    this.setDefaultCustomer,
    this.shipToId,
    this.userName,
    this.vmiRole,
  });

  ///  Gets or sets the identifier.
  String? id;

  ///  Gets or sets the email.
  String? email;

  ///  Gets or sets the name of the user.
  String? userName;

  ///  Gets or sets the password.
  String? password;

  ///  Gets or sets a value indicating whether this instance is subscribed.
  bool? isSubscribed;

  ///  Gets or sets a value indicating whether this instance is guest.
  bool? isGuest;

  ///  Gets or sets a value indicating whether this instance can approve orders.
  bool? canApproveOrders;

  ///  Gets or sets a value indicating whether this instance can view approval orders.
  bool? canViewApprovalOrders;

  ///  Gets or sets the bill to id.  Returned from creating a new account to return the new bill to id.
  String? billToId;

  ///  Gets or sets the ship to id.  Returned from creating a new account to return the new ship to id.
  String? shipToId;

  ///  Gets or sets the first name.
  String? firstName;

  ///  Gets or sets the last name.
  String? lastName;

  ///  Gets or sets the role.
  String? role;

  ///  Gets or sets the approver.
  String? approver;

  ///  Gets or sets a value indicating whether is approved.
  bool? isApproved;

  ///  Gets or sets the activation status
  String? activationStatus;

  ///  Gets or sets the default location.
  String? defaultLocation;

  ///  Gets or sets a last login on.
  DateTime? lastLoginOn;

  ///  Gets or sets the available approvers.
  List<String>? availableApprovers;

  ///  Gets or sets the available roles.
  List<String>? availableRoles;

  ///  Gets or sets a value indicating whether this account requires activation via email
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? requiresActivation;

  ///  Gets or sets a value indicating whether set default customer.
  bool? setDefaultCustomer;

  ///  Gets or sets the default customer id.
  String? defaultCustomerId;

  ///  Gets or sets the default fulfillment method.
  String? defaultFulfillmentMethod;

  ///  Gets or sets the default warehouse.
  Warehouse? defaultWarehouse;

  ///  Gets or sets the default warehouse id.
  String? defaultWarehouseId;

  ///  Gets or sets the AccessToken
  String? accessToken;

  ///  Gets or sets the VmiRole
  String? vmiRole;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Vmi extends BaseModel {
  Vmi({this.vmiUsers});

  List<VmiUser>? vmiUsers;

  factory Vmi.fromJson(Map<String, dynamic> json) => _$VmiFromJson(json);
  Map<String, dynamic> toJson() => _$VmiToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VmiUser extends BaseModel {
  VmiUser({
    this.userId,
    this.vmiLocationNames,
    this.vmiRoles,
  });

  String? userId;
  List<String>? vmiLocationNames;
  List<String>? vmiRoles;

  factory VmiUser.fromJson(Map<String, dynamic> json) =>
      _$VmiUserFromJson(json);
  Map<String, dynamic> toJson() => _$VmiUserToJson(this);
}
