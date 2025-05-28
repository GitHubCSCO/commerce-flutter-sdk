import 'models.dart';

part 'settings.g.dart';

@JsonSerializable()
class Settings extends BaseModel {
  SettingsCollection? settingsCollection;

  Settings({
    this.settingsCollection,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@JsonSerializable()
class SettingsCollection {
  AccountSettings? accountSettings;

  CartSettings? cartSettings;

  ProductSettings? productSettings;

  SearchSettings? searchSettings;

  CustomerSettings? customerSettings;

  InvoiceSettings? invoiceSettings;

  OrderSettings? orderSettings;

  QuoteSettings? quoteSettings;

  WishListSettings? wishListSettings;

  WebsiteSettings? websiteSettings;

  PickUpSettings? pickUpSettings;

  SettingsCollection({
    this.accountSettings,
    this.cartSettings,
    this.productSettings,
    this.searchSettings,
    this.customerSettings,
    this.invoiceSettings,
    this.orderSettings,
    this.quoteSettings,
    this.wishListSettings,
    this.websiteSettings,
    this.pickUpSettings,
  });

  factory SettingsCollection.fromJson(Map<String, dynamic> json) =>
      _$SettingsCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsCollectionToJson(this);
}

@JsonSerializable()
class AccountSettings extends BaseModel {
  /// Gets or sets a value indicating whether creating an account is allowed.
  bool? allowCreateAccount;

  /// Gets or sets a value indicating whether guest checkout is allowed.
  bool? allowGuestCheckout;

  /// Gets or sets a value indicating whether subscribe to news letter is allowed.
  bool? allowSubscribeToNewsLetter;

  /// Gets or sets a value indicating whether select customer is required on sign in.
  bool? requireSelectCustomerOnSignIn;

  /// Gets or sets the minimum length of the password.
  int? passwordMinimumLength;

  /// Gets or sets the minimum required length for a password.
  int? passwordMinimumRequiredLength;

  /// Gets or sets a value indicating whether a special character is required in a password.
  bool? passwordRequiresSpecialCharacter;

  /// Gets or sets a value indicating whether an uppercase letter is required in a password.
  bool? passwordRequiresUppercase;

  /// Gets or sets a value indicating whether a lowercase letter is required in a password.
  bool? passwordRequiresLowercase;

  bool? rememberMe;

  /// Gets or sets a value indicating whether a digit is required in a password.
  bool? passwordRequiresDigit;

  /// Gets or sets the days to retain user.
  int? daysToRetainUser;

  /// Gets or sets a value indicating whether email uses as user name.
  bool? useEmailAsUserName;

  bool? enableWarehousePickup;

  bool? logOutUserAfterPasswordChange;

  AccountSettings({
    this.allowCreateAccount,
    this.allowGuestCheckout,
    this.allowSubscribeToNewsLetter,
    this.requireSelectCustomerOnSignIn,
    this.passwordMinimumLength,
    this.passwordMinimumRequiredLength,
    this.passwordRequiresSpecialCharacter,
    this.passwordRequiresUppercase,
    this.passwordRequiresLowercase,
    this.rememberMe,
    this.passwordRequiresDigit,
    this.daysToRetainUser,
    this.useEmailAsUserName,
    this.enableWarehousePickup,
    this.logOutUserAfterPasswordChange,
  });

  factory AccountSettings.fromJson(Map<String, dynamic> json) =>
      _$AccountSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountSettingsToJson(this);
}

@JsonSerializable()
class CartSettings extends BaseModel {
  /// Gets or sets a value indicating whether [show request delivery date].
  bool? canRequestDeliveryDate;

  /// Gets or sets a value indicating whether this instance can requisition.
  bool? canRequisition;

  /// Gets or sets a value indicating whether this instance can edit cost code.
  bool? canEditCostCode;

  /// Gets or sets a value of maximum delivery period.
  int? maximumDeliveryPeriod;

  /// Gets or sets a value indicating whether [show cost code].
  bool? showCostCode;

  /// Gets or sets a value indicating whether [show po number].
  bool? showPoNumber;

  /// Gets or sets a value indicating whether [show pay pal].
  bool? showPayPal;

  /// Gets or sets a value indicating whether [show credit card].
  bool? showCreditCard;

  /// Gets or sets a value indicating whether [show tax and shipping].
  bool? showTaxAndShipping;

  /// Gets or sets a value indicating whether [show line notes].
  bool? showLineNotes;

  /// Gets or sets a value indicating whether [show subscription in footer].
  bool? showNewsletterSignup;

  /// Gets or sets a value indicating whether [requires po number].
  bool? requiresPoNumber;

  /// Gets or sets a value indicating how long to display the add to cart confirmation popup.
  int? addToCartPopupTimeout;

  bool? enableRequestPickUpDate;

  bool? enableSavedCreditCards;

  bool? bypassCvvForSavedCards;

  CartSettings({
    this.canRequestDeliveryDate,
    this.canRequisition,
    this.canEditCostCode,
    this.maximumDeliveryPeriod,
    this.showCostCode,
    this.showPoNumber,
    this.showPayPal,
    this.showCreditCard,
    this.showTaxAndShipping,
    this.showLineNotes,
    this.showNewsletterSignup,
    this.requiresPoNumber,
    this.addToCartPopupTimeout,
    this.enableRequestPickUpDate,
    this.enableSavedCreditCards,
    this.bypassCvvForSavedCards,
  });

  factory CartSettings.fromJson(Map<String, dynamic> json) =>
      _$CartSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$CartSettingsToJson(this);
}

@JsonSerializable()
class ProductSettings extends BaseModel {
  /// Gets or sets a value indicating whether products with no inventory can be ordered.
  @Deprecated('Use AllowBackOrderForDelivery instead.')
  bool? allowBackOrder = true;

  bool? allowBackOrderForDelivery;

  bool? allowBackOrderForPickup;

  /// Gets or sets a value indicating whether product inventory status is shown.
  bool? showInventoryAvailability = true;

  /// Gets or sets a value indicating whether the add to cart confirmation dialog is shown.
  bool? showAddToCartConfirmationDialog = true;

  /// Gets or sets a value indicating whether product comparison functionality is enabled.
  bool? enableProductComparisons = true;

  /// Gets or sets a value indicating whether alternate units of measure are displayed on the website.
  bool? alternateUnitsOfMeasure = false;

  /// Gets or sets the third party review provider key.
  String? thirdPartyReviews = 'None';

  /// Gets or sets the default type of the view on the product list page.
  String? defaultViewType = 'List';

  /// Gets or sets a value indicating whether pricing for discounted products will include the amount saved in the selected currency.
  bool? showSavingsAmount = true;

  /// Gets or sets a value indicating whether pricing for discounted products will include the percentage off the base price.
  bool? showSavingsPercent = true;

  /// Gets or sets a value indicating whether pricing is obtained realtime from an external source.
  bool? realTimePricing = false;

  /// Gets or sets a value indicating whether inventory is obtained realtime from an external source.
  bool? realTimeInventory = false;

  /// Gets or sets a value indicating whether inventory is obtained realtime from an external source with pricing.
  bool? inventoryIncludedWithPricing = false;

  /// Gets or sets a value indicating what guests will be able to access before being prompted to sign in.
  String? storefrontAccess = StorefrontAccessConstants.noSignInRequired;

  bool? canShowPriceFilters;

  bool? canSeeProducts;

  bool? canSeePrices = true;

  bool? canAddToCart;

  String? pricingService;

  bool? displayAttributesintabs;

  String? attributesTabSortOrder;

  bool? displayDocumentsintabs;

  String? documentsTabSortOrder;

  /// Gets or sets a value indicating whether guests can see Inventory on a by warehouse basis. Defaults to false.
  bool? displayInventoryPerWarehouse = false;

  /// Gets or sets a value indicating whether Inventory by Warehouse only displays on the Product Detail page. Defaults to false
  bool? displayInventoryPerWarehouseOnlyOnProductDetail = false;

  bool? displayFacetsForStockedItems;

  String? imageProvider;

  String? catalogUrlPath;

  bool? enableVat;

  String? vatPriceDisplay;

  ProductSettings({
    this.allowBackOrder,
    this.allowBackOrderForDelivery,
    this.allowBackOrderForPickup,
    this.showInventoryAvailability,
    this.showAddToCartConfirmationDialog,
    this.enableProductComparisons,
    this.alternateUnitsOfMeasure,
    this.thirdPartyReviews,
    this.defaultViewType,
    this.showSavingsAmount,
    this.showSavingsPercent,
    this.realTimePricing,
    this.realTimeInventory,
    this.inventoryIncludedWithPricing,
    this.storefrontAccess,
    this.canShowPriceFilters,
    this.canSeeProducts,
    this.canSeePrices,
    this.canAddToCart,
    this.pricingService,
    this.displayAttributesintabs,
    this.attributesTabSortOrder,
    this.displayDocumentsintabs,
    this.documentsTabSortOrder,
    this.displayInventoryPerWarehouse,
    this.displayInventoryPerWarehouseOnlyOnProductDetail,
    this.displayFacetsForStockedItems,
    this.imageProvider,
    this.catalogUrlPath,
    this.enableVat,
    this.vatPriceDisplay,
  });

  factory ProductSettings.fromJson(Map<String, dynamic> json) =>
      _$ProductSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSettingsToJson(this);
}

class StorefrontAccessConstants {
  StorefrontAccessConstants._();
  static String? noSignInRequired = 'NoSignInRequired';

  static String? signInRequiredToBrowse = 'SignInRequiredToBrowse';

  static String? signInRequiredToAddToCart = 'SignInRequiredToAddToCart';

  static String? signInRequiredToAddToCartOrSeePrices =
      'SignInRequiredToAddToCartOrSeePrices';
}

@JsonSerializable()
class SearchSettings extends BaseModel {
  /// Gets or sets a value indicating whether autocomplete enabled.
  bool? autocompleteEnabled;

  /// Gets or sets a value indicating whether search history enabled.
  bool? searchHistoryEnabled;

  /// Gets or sets the search history limit.
  int? searchHistoryLimit;

  bool? enableBoostingByPurchaseHistory;

  bool? allowFilteringForPreviouslyPurchasedProducts;

  String? searchPath;

  SearchSettings({
    this.autocompleteEnabled,
    this.searchHistoryEnabled,
    this.searchHistoryLimit,
    this.enableBoostingByPurchaseHistory,
    this.allowFilteringForPreviouslyPurchasedProducts,
    this.searchPath,
  });

  factory SearchSettings.fromJson(Map<String, dynamic> json) =>
      _$SearchSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSettingsToJson(this);
}

@JsonSerializable()
class CustomerSettings extends BaseModel {
  /// Gets or sets a value indicating whether allow bill to address edit.
  bool? allowBillToAddressEdit;

  /// Gets or sets a value indicating whether allow ship to address edit.
  bool? allowShipToAddressEdit;

  /// Gets or sets a value indicating whether allow create new ship to address.
  bool? allowCreateNewShipToAddress;

  /// Gets or sets a value indicating whether bill to company required.
  bool? billToCompanyRequired;

  /// Gets or sets a value indicating whether bill to first name required.
  bool? billToFirstNameRequired;

  /// Gets or sets a value indicating whether bill to last name required.
  bool? billToLastNameRequired;

  /// Gets or sets a value indicating whether ship to company required.
  bool? shipToCompanyRequired;

  /// Gets or sets a value indicating whether ship to first name required.
  bool? shipToFirstNameRequired;

  /// Gets or sets a value indicating whether ship to last name required.
  bool? shipToLastNameRequired;

  /// Gets or sets a value indicating whether budgets from online only.
  bool? budgetsFromOnlineOnly;

  /// Gets or sets a value indicating whether bill to state required.
  bool? billToStateRequired;

  /// Gets or sets a value indicating whether ship to state required.
  bool? shipToStateRequired;

  bool? displayAccountsReceivableBalances;

  /// If Yes, an address may be entered on the address page that is only used for the current order. Default value: No.
  bool? allowOneTimeAddresses;

  CustomerSettings({
    this.allowBillToAddressEdit,
    this.allowShipToAddressEdit,
    this.allowCreateNewShipToAddress,
    this.billToCompanyRequired,
    this.billToFirstNameRequired,
    this.billToLastNameRequired,
    this.shipToCompanyRequired,
    this.shipToFirstNameRequired,
    this.shipToLastNameRequired,
    this.budgetsFromOnlineOnly,
    this.billToStateRequired,
    this.shipToStateRequired,
    this.displayAccountsReceivableBalances,
    this.allowOneTimeAddresses,
  });

  factory CustomerSettings.fromJson(Map<String, dynamic> json) =>
      _$CustomerSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerSettingsToJson(this);
}

@JsonSerializable()
class InvoiceSettings {
  /// Gets or sets the look back days.
  int? lookBackDays;

  /// Gets or sets a value indicating whether show invoices.
  bool? showInvoices;

  InvoiceSettings({
    this.lookBackDays,
    this.showInvoices,
  });

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) =>
      _$InvoiceSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceSettingsToJson(this);
}

@JsonSerializable()
class OrderSettings extends BaseModel {
  /// Gets or sets a value indicating whether allow cancellation request.
  @Deprecated('Use order status mapping')
  bool? allowCancellationRequest;

  /// Gets or sets a value indicating whether quick order is allowed.
  bool? allowQuickOrder;

  /// Gets or sets a value indicating whether items can be reordered
  bool? canReorderItems;

  /// Gets or sets a value indicating whether can order upload.
  bool? canOrderUpload;

  /// Gets or sets a value indicating whether RMAs are allowed.
  @Deprecated('Use order status mapping')
  bool? allowRma;

  /// Gets or sets a value indicating whether show cost code.
  bool? showCostCode;

  /// Gets or sets a value indicating whether show the PO number.
  bool? showPoNumber;

  /// Gets or sets a value indicating whether show the terms code.
  bool? showTermsCode;

  /// Gets or sets a value indicating whether show the ERP order number.
  @Deprecated('Use ShowWebOrderNumber instead.')
  bool? showErpOrderNumber;

  /// Gets or sets a value indicating whether show the web order number.
  bool? showWebOrderNumber;

  bool? showOrderStatus;

  /// Gets or sets a value indicating whether show orders.
  bool? showOrders;

  /// Gets or sets the look back days.
  int? lookBackDays;

  bool? vmiEnabled;

  OrderSettings({
    this.allowCancellationRequest,
    this.allowQuickOrder,
    this.canReorderItems,
    this.canOrderUpload,
    this.allowRma,
    this.showCostCode,
    this.showPoNumber,
    this.showTermsCode,
    this.showErpOrderNumber,
    this.showWebOrderNumber,
    this.showOrderStatus,
    this.showOrders,
    this.lookBackDays,
    this.vmiEnabled,
  });

  factory OrderSettings.fromJson(Map<String, dynamic> json) =>
      _$OrderSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSettingsToJson(this);
}

@JsonSerializable()
class QuoteSettings extends BaseModel {
  /// Gets or sets a value indicating whether job quote enabled.
  bool? jobQuoteEnabled;

  /// Gets or sets the quote expire days.
  int? quoteExpireDays;

  QuoteSettings({
    this.jobQuoteEnabled,
    this.quoteExpireDays,
  });

  factory QuoteSettings.fromJson(Map<String, dynamic> json) =>
      _$QuoteSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteSettingsToJson(this);
}

@JsonSerializable()
class WishListSettings extends BaseModel {
  /// Gets or sets a value indicating whether allow multiple wish lists.
  bool? allowMultipleWishLists;

  /// Gets or sets a value indicating whether allow editing of wish lists.
  bool? allowEditingOfWishLists;

  /// Gets or sets a value indicating whether allow wish lists by customer.
  bool? allowWishListsByCustomer;

  bool? allowListSharing;

  int? productsPerPage;

  bool? enableWishListReminders;

  WishListSettings({
    this.allowMultipleWishLists,
    this.allowEditingOfWishLists,
    this.allowWishListsByCustomer,
    this.allowListSharing,
    this.productsPerPage,
    this.enableWishListReminders,
  }) {
    allowMultipleWishLists ??= true;
    allowEditingOfWishLists ??= true;
    allowWishListsByCustomer ??= false;
    allowListSharing ??= true;
  }

  factory WishListSettings.fromJson(Map<String, dynamic> json) =>
      _$WishListSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$WishListSettingsToJson(this);
}

@JsonSerializable()
class WebsiteSettings extends BaseModel {
  /// Gets or sets a value indicating whether the mobile app is enabled for this website.
  bool? mobileAppEnabled;

  bool? useTokenExGateway;

  bool? useECheckTokenExGateway;

  bool? tokenExTestMode;

  bool? usePaymetricGateway;

  bool? useAdyenDropIn;

  bool? useSpreedlyDropIn;

  bool? paymentGatewayRequiresAuthentication;

  int? defaultPageSize;

  bool? enableCookiePrivacyPolicyPopup;

  bool? enableDynamicRecommendations;

  String? googleMapsApiKey;

  String? googleTrackingTypeComputed;

  String? googleTrackingAccountId;

  CmsType? cmsType;

  bool? includeSiteNameInPageTitle;

  String? pageTitleDelimiter;

  bool? siteNameAfterTitle;

  String? reCaptchaSiteKey;

  bool? reCaptchaEnabledForContactUs;

  bool? reCaptchaEnabledForCreateAccount;

  bool? reCaptchaEnabledForForgotPassword;

  bool? reCaptchaEnabledForShareProduct;

  bool? advancedSpireCmsFeatures;

  bool? previewLoginEnabled;

  bool? maintenanceModeEnabled;

  bool? useSquareGateway;

  String? squareApplicationId;

  String? squareLocationId;

  bool? squareLive;

  WebsiteSettings({
    this.mobileAppEnabled,
    this.useTokenExGateway,
    this.useECheckTokenExGateway,
    this.tokenExTestMode,
    this.usePaymetricGateway,
    this.useAdyenDropIn,
    this.useSpreedlyDropIn,
    this.paymentGatewayRequiresAuthentication,
    this.defaultPageSize,
    this.enableCookiePrivacyPolicyPopup,
    this.enableDynamicRecommendations,
    this.googleMapsApiKey,
    this.googleTrackingTypeComputed,
    this.googleTrackingAccountId,
    this.cmsType,
    this.includeSiteNameInPageTitle,
    this.pageTitleDelimiter,
    this.siteNameAfterTitle,
    this.reCaptchaSiteKey,
    this.reCaptchaEnabledForContactUs,
    this.reCaptchaEnabledForCreateAccount,
    this.reCaptchaEnabledForForgotPassword,
    this.reCaptchaEnabledForShareProduct,
    this.advancedSpireCmsFeatures,
    this.previewLoginEnabled,
    this.maintenanceModeEnabled,
    this.useSquareGateway,
    this.squareApplicationId,
    this.squareLocationId,
    this.squareLive,
  });

  factory WebsiteSettings.fromJson(Map<String, dynamic> json) =>
      _$WebsiteSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$WebsiteSettingsToJson(this);
}

@JsonSerializable()
class SpreedlyDto {
  String? environmentKey;

  SpreedlyDto({
    this.environmentKey,
  });

  factory SpreedlyDto.fromJson(Map<String, dynamic> json) =>
      _$SpreedlyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SpreedlyDtoToJson(this);
}

@JsonSerializable()
class TokenExDto {
  String? tokenExId;

  String? origin;

  String? timestamp;

  String? tokenScheme;

  String? authenticationKey;

  String? token;

  TokenExDto({
    this.tokenExId,
    this.origin,
    this.timestamp,
    this.tokenScheme,
    this.authenticationKey,
    this.token,
  });

  factory TokenExDto.fromJson(Map<String, dynamic> json) =>
      _$TokenExDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenExDtoToJson(this);
}

@JsonSerializable()
class TokenExStyleDto {
  String? baseColor;

  String? focusColor;

  String? errorColor;

  String? textColor;

  String? borderWidth;

  TokenExStyleDto({
    this.baseColor,
    this.focusColor,
    this.errorColor,
    this.textColor,
    this.borderWidth,
  });

  factory TokenExStyleDto.fromJson(Map<String, dynamic> json) =>
      _$TokenExStyleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenExStyleDtoToJson(this);
}

@JsonSerializable()
class PickUpSettings extends BaseModel {
  /// Gets or sets the number of warehouses shown per page
  int? warehousesPageSize;

  /// Gets or sets the search radius for pick up .
  int? searchRadius;

  PickUpSettings({
    this.warehousesPageSize,
    this.searchRadius,
  });

  factory PickUpSettings.fromJson(Map<String, dynamic> json) =>
      _$PickUpSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PickUpSettingsToJson(this);
}

@JsonSerializable()
class MobileAppSettings extends BaseModel {
  String? startingCategoryForBrowsing;

  bool? hasCheckout;

  bool? overrideCheckoutNavigation;

  String? checkoutUrl;

  bool? addToCartInProductList;

  MobileAppSettings({
    this.startingCategoryForBrowsing,
    this.hasCheckout,
    this.overrideCheckoutNavigation,
    this.checkoutUrl,
    this.addToCartInProductList,
  });

  factory MobileAppSettings.fromJson(Map<String, dynamic> json) =>
      _$MobileAppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$MobileAppSettingsToJson(this);
}
