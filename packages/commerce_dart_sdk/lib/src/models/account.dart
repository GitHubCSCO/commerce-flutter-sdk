import 'models.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account extends BaseModel {
  Account();

  ///  Gets or sets the identifier.
  late String id;

  ///  Gets or sets the email.
  late String email;

  ///  Gets or sets the name of the user.
  late String userName;

  ///  Gets or sets the password.
  late String password;

  ///  Gets or sets a value indicating whether this instance is subscribed.
  late bool? isSubscribed;

  ///  Gets or sets a value indicating whether this instance is guest.
  late bool isGuest;

  ///  Gets or sets a value indicating whether this instance can approve orders.
  late bool canApproveOrders;

  ///  Gets or sets a value indicating whether this instance can view approval orders.
  late bool canViewApprovalOrders;

  ///  Gets or sets the bill to id.  Returned from creating a new account to return the new bill to id.
  late String? billToId;

  ///  Gets or sets the ship to id.  Returned from creating a new account to return the new ship to id.
  late String? shipToId;

  ///  Gets or sets the first name.
  late String firstName;

  ///  Gets or sets the last name.
  late String lastName;

  ///  Gets or sets the role.
  late String role;

  ///  Gets or sets the approver.
  late String approver;

  ///  Gets or sets a value indicating whether is approved.
  late bool? isApproved;

  ///  Gets or sets the activation status
  late String activationStatus;

  ///  Gets or sets the default location.
  late String defaultLocation;

  ///  Gets or sets a last login on.
  late DateTime? lastLoginOn;

  ///  Gets or sets the available approvers.
  late List<String> availableApprovers;

  ///  Gets or sets the available roles.
  late List<String> availableRoles;

  ///  Gets or sets a value indicating whether this account requires activation via email
  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool? requiresActivation;

  ///  Gets or sets a value indicating whether set default customer.
  late bool setDefaultCustomer;

  ///  Gets or sets the default customer id.
  late String defaultCustomerId;

  ///  Gets or sets the default fulfillment method.
  late String defaultFulfillmentMethod;

  ///  Gets or sets the default warehouse.
  late Warehouse defaultWarehouse;

  ///  Gets or sets the default warehouse id.
  late String defaultWarehouseId;

  ///  Gets or sets the AccessToken
  late String accessToken;

  ///  Gets or sets the VmiRole
  late String vmiRole;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Vmi extends BaseModel {
  Vmi();

  late List<VmiUser> vmiUsers;

  factory Vmi.fromJson(Map<String, dynamic> json) => _$VmiFromJson(json);
  Map<String, dynamic> toJson() => _$VmiToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VmiUser extends BaseModel {
  VmiUser();

  late String userId;
  late List<String> vmiLocationNames;
  late List<String> vmiRoles;

  factory VmiUser.fromJson(Map<String, dynamic> json) =>
      _$VmiUserFromJson(json);
  Map<String, dynamic> toJson() => _$VmiUserToJson(this);
}
