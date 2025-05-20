import 'models.dart';

part 'session.g.dart';

@JsonSerializable(explicitToJson: true)
class Session extends BaseModel {
  Session({
    this.activateAccount,
    this.billTo,
    this.currency,
    this.customLandingPage,
    this.customerWasUpdated,
    this.dashboardIsHomepage,
    this.deviceType,
    this.displayChangeCustomerLink,
    this.displayPricingAndInventory,
    this.email,
    this.firstName,
    this.fulfillmentMethod,
    this.hasDefaultCustomer,
    this.hasRfqUpdates,
    this.isAuthenticated,
    this.isGuest,
    this.isRestrictedProductRemovedFromCart,
    this.isSalesPerson,
    this.language,
    this.lastName,
    this.newPassword,
    this.password,
    this.persona,
    this.personas,
    this.pickUpWarehouse,
    this.redirectToChangeCustomerPageOnSignIn,
    this.rememberMe,
    this.resetPassword,
    this.resetToken,
    this.shipTo,
    this.userLabel,
    this.userName,
    this.userProfileId,
    this.userRoles,
  });

  /// Gets or sets a value indicating whether this instance is authenticated.
  bool? isAuthenticated;

  /// Gets or sets a value indicating whether this instance has RFQ updates.
  bool? hasRfqUpdates;

  /// Gets or sets the name of the user.
  String? userName;

  String? userProfileId;

  /// Gets or sets the user label.
  String? userLabel;

  /// Gets or sets the user roles.
  String? userRoles;

  /// Gets or sets the email.
  String? email;

  /// Gets or sets the password.
  String? password;

  /// Gets or sets the new password.
  String? newPassword;

  /// Gets or sets a value indicating whether this is a password reset request
  bool? resetPassword;

  /// Gets or sets a value indicating whether this is an account activation request
  bool? activateAccount;

  /// Gets or sets the reset token.
  String? resetToken;

  /// Gets or sets a value indicating whether display change customer link.
  bool? displayChangeCustomerLink;

  /// Gets or sets a value indicating whether redirect to change customer page on sign in.
  bool? redirectToChangeCustomerPageOnSignIn;

  /// Gets or sets the bill to.
  BillTo? billTo;

  /// Gets or sets the ship to.
  ShipTo? shipTo;

  /// Gets or sets the language.
  Language? language;

  /// Gets or sets the currency.
  Currency? currency;

  /// Gets or sets the type of the device.
  String? deviceType;

  /// Gets or sets the persona.
  String? persona;

  /// Gets or sets the persona.
  List<Persona>? personas;

  /// Gets or sets the dashboard is homepage.
  bool? dashboardIsHomepage;

  /// Gets or sets a value indicating whether current user profile has salesperson
  bool? isSalesPerson;

  /// Gets or sets the custom landing page.
  String? customLandingPage;

  /// Gets or sets a value indicating whether has default customer.
  bool? hasDefaultCustomer;

  /// Gets or sets a value indicating whether remember me.
  bool? rememberMe;

  /// Gets or sets a value indicating whether is restricted product removed from cart.
  bool? isRestrictedProductRemovedFromCart;

  /// Gets or sets the first name.
  String? firstName;

  String? lastName;

  /// Gets or sets a value indicating whether customer was updated.
  bool? customerWasUpdated;

  bool? isGuest;

  String? fulfillmentMethod;

  /// Gets or sets a value that indicate weather show/hide pricing and inventory menu
  bool? displayPricingAndInventory;

  Warehouse? pickUpWarehouse;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Persona {
  Persona({
    this.description,
    this.id,
    this.isDefault,
    this.name,
  });

  String? id;

  String? name;

  String? description;

  bool? isDefault;

  factory Persona.fromJson(Map<String, dynamic> json) =>
      _$PersonaFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaToJson(this);
}
