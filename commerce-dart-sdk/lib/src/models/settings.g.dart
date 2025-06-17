// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      settingsCollection: json['settingsCollection'] == null
          ? null
          : SettingsCollection.fromJson(
              json['settingsCollection'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.settingsCollection?.toJson() case final value?)
        'settingsCollection': value,
    };

SettingsCollection _$SettingsCollectionFromJson(Map<String, dynamic> json) =>
    SettingsCollection(
      accountSettings: json['accountSettings'] == null
          ? null
          : AccountSettings.fromJson(
              json['accountSettings'] as Map<String, dynamic>),
      cartSettings: json['cartSettings'] == null
          ? null
          : CartSettings.fromJson(json['cartSettings'] as Map<String, dynamic>),
      productSettings: json['productSettings'] == null
          ? null
          : ProductSettings.fromJson(
              json['productSettings'] as Map<String, dynamic>),
      searchSettings: json['searchSettings'] == null
          ? null
          : SearchSettings.fromJson(
              json['searchSettings'] as Map<String, dynamic>),
      customerSettings: json['customerSettings'] == null
          ? null
          : CustomerSettings.fromJson(
              json['customerSettings'] as Map<String, dynamic>),
      invoiceSettings: json['invoiceSettings'] == null
          ? null
          : InvoiceSettings.fromJson(
              json['invoiceSettings'] as Map<String, dynamic>),
      orderSettings: json['orderSettings'] == null
          ? null
          : OrderSettings.fromJson(
              json['orderSettings'] as Map<String, dynamic>),
      quoteSettings: json['quoteSettings'] == null
          ? null
          : QuoteSettings.fromJson(
              json['quoteSettings'] as Map<String, dynamic>),
      wishListSettings: json['wishListSettings'] == null
          ? null
          : WishListSettings.fromJson(
              json['wishListSettings'] as Map<String, dynamic>),
      websiteSettings: json['websiteSettings'] == null
          ? null
          : WebsiteSettings.fromJson(
              json['websiteSettings'] as Map<String, dynamic>),
      pickUpSettings: json['pickUpSettings'] == null
          ? null
          : PickUpSettings.fromJson(
              json['pickUpSettings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsCollectionToJson(SettingsCollection instance) =>
    <String, dynamic>{
      if (instance.accountSettings?.toJson() case final value?)
        'accountSettings': value,
      if (instance.cartSettings?.toJson() case final value?)
        'cartSettings': value,
      if (instance.productSettings?.toJson() case final value?)
        'productSettings': value,
      if (instance.searchSettings?.toJson() case final value?)
        'searchSettings': value,
      if (instance.customerSettings?.toJson() case final value?)
        'customerSettings': value,
      if (instance.invoiceSettings?.toJson() case final value?)
        'invoiceSettings': value,
      if (instance.orderSettings?.toJson() case final value?)
        'orderSettings': value,
      if (instance.quoteSettings?.toJson() case final value?)
        'quoteSettings': value,
      if (instance.wishListSettings?.toJson() case final value?)
        'wishListSettings': value,
      if (instance.websiteSettings?.toJson() case final value?)
        'websiteSettings': value,
      if (instance.pickUpSettings?.toJson() case final value?)
        'pickUpSettings': value,
    };

AccountSettings _$AccountSettingsFromJson(Map<String, dynamic> json) =>
    AccountSettings(
      allowCreateAccount: json['allowCreateAccount'] as bool?,
      allowGuestCheckout: json['allowGuestCheckout'] as bool?,
      allowSubscribeToNewsLetter: json['allowSubscribeToNewsLetter'] as bool?,
      requireSelectCustomerOnSignIn:
          json['requireSelectCustomerOnSignIn'] as bool?,
      passwordMinimumLength: (json['passwordMinimumLength'] as num?)?.toInt(),
      passwordMinimumRequiredLength:
          (json['passwordMinimumRequiredLength'] as num?)?.toInt(),
      passwordRequiresSpecialCharacter:
          json['passwordRequiresSpecialCharacter'] as bool?,
      passwordRequiresUppercase: json['passwordRequiresUppercase'] as bool?,
      passwordRequiresLowercase: json['passwordRequiresLowercase'] as bool?,
      rememberMe: json['rememberMe'] as bool?,
      passwordRequiresDigit: json['passwordRequiresDigit'] as bool?,
      daysToRetainUser: (json['daysToRetainUser'] as num?)?.toInt(),
      useEmailAsUserName: json['useEmailAsUserName'] as bool?,
      enableWarehousePickup: json['enableWarehousePickup'] as bool?,
      logOutUserAfterPasswordChange:
          json['logOutUserAfterPasswordChange'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AccountSettingsToJson(AccountSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.allowCreateAccount case final value?)
        'allowCreateAccount': value,
      if (instance.allowGuestCheckout case final value?)
        'allowGuestCheckout': value,
      if (instance.allowSubscribeToNewsLetter case final value?)
        'allowSubscribeToNewsLetter': value,
      if (instance.requireSelectCustomerOnSignIn case final value?)
        'requireSelectCustomerOnSignIn': value,
      if (instance.passwordMinimumLength case final value?)
        'passwordMinimumLength': value,
      if (instance.passwordMinimumRequiredLength case final value?)
        'passwordMinimumRequiredLength': value,
      if (instance.passwordRequiresSpecialCharacter case final value?)
        'passwordRequiresSpecialCharacter': value,
      if (instance.passwordRequiresUppercase case final value?)
        'passwordRequiresUppercase': value,
      if (instance.passwordRequiresLowercase case final value?)
        'passwordRequiresLowercase': value,
      if (instance.rememberMe case final value?) 'rememberMe': value,
      if (instance.passwordRequiresDigit case final value?)
        'passwordRequiresDigit': value,
      if (instance.daysToRetainUser case final value?)
        'daysToRetainUser': value,
      if (instance.useEmailAsUserName case final value?)
        'useEmailAsUserName': value,
      if (instance.enableWarehousePickup case final value?)
        'enableWarehousePickup': value,
      if (instance.logOutUserAfterPasswordChange case final value?)
        'logOutUserAfterPasswordChange': value,
    };

CartSettings _$CartSettingsFromJson(Map<String, dynamic> json) => CartSettings(
      canRequestDeliveryDate: json['canRequestDeliveryDate'] as bool?,
      canRequisition: json['canRequisition'] as bool?,
      canEditCostCode: json['canEditCostCode'] as bool?,
      maximumDeliveryPeriod: (json['maximumDeliveryPeriod'] as num?)?.toInt(),
      showCostCode: json['showCostCode'] as bool?,
      showPoNumber: json['showPoNumber'] as bool?,
      showPayPal: json['showPayPal'] as bool?,
      showCreditCard: json['showCreditCard'] as bool?,
      showTaxAndShipping: json['showTaxAndShipping'] as bool?,
      showLineNotes: json['showLineNotes'] as bool?,
      showNewsletterSignup: json['showNewsletterSignup'] as bool?,
      requiresPoNumber: json['requiresPoNumber'] as bool?,
      addToCartPopupTimeout: (json['addToCartPopupTimeout'] as num?)?.toInt(),
      enableRequestPickUpDate: json['enableRequestPickUpDate'] as bool?,
      enableSavedCreditCards: json['enableSavedCreditCards'] as bool?,
      bypassCvvForSavedCards: json['bypassCvvForSavedCards'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CartSettingsToJson(CartSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.canRequestDeliveryDate case final value?)
        'canRequestDeliveryDate': value,
      if (instance.canRequisition case final value?) 'canRequisition': value,
      if (instance.canEditCostCode case final value?) 'canEditCostCode': value,
      if (instance.maximumDeliveryPeriod case final value?)
        'maximumDeliveryPeriod': value,
      if (instance.showCostCode case final value?) 'showCostCode': value,
      if (instance.showPoNumber case final value?) 'showPoNumber': value,
      if (instance.showPayPal case final value?) 'showPayPal': value,
      if (instance.showCreditCard case final value?) 'showCreditCard': value,
      if (instance.showTaxAndShipping case final value?)
        'showTaxAndShipping': value,
      if (instance.showLineNotes case final value?) 'showLineNotes': value,
      if (instance.showNewsletterSignup case final value?)
        'showNewsletterSignup': value,
      if (instance.requiresPoNumber case final value?)
        'requiresPoNumber': value,
      if (instance.addToCartPopupTimeout case final value?)
        'addToCartPopupTimeout': value,
      if (instance.enableRequestPickUpDate case final value?)
        'enableRequestPickUpDate': value,
      if (instance.enableSavedCreditCards case final value?)
        'enableSavedCreditCards': value,
      if (instance.bypassCvvForSavedCards case final value?)
        'bypassCvvForSavedCards': value,
    };

ProductSettings _$ProductSettingsFromJson(Map<String, dynamic> json) =>
    ProductSettings(
      allowBackOrder: json['allowBackOrder'] as bool?,
      allowBackOrderForDelivery: json['allowBackOrderForDelivery'] as bool?,
      allowBackOrderForPickup: json['allowBackOrderForPickup'] as bool?,
      showInventoryAvailability: json['showInventoryAvailability'] as bool?,
      showAddToCartConfirmationDialog:
          json['showAddToCartConfirmationDialog'] as bool?,
      enableProductComparisons: json['enableProductComparisons'] as bool?,
      alternateUnitsOfMeasure: json['alternateUnitsOfMeasure'] as bool?,
      thirdPartyReviews: json['thirdPartyReviews'] as String?,
      defaultViewType: json['defaultViewType'] as String?,
      showSavingsAmount: json['showSavingsAmount'] as bool?,
      showSavingsPercent: json['showSavingsPercent'] as bool?,
      realTimePricing: json['realTimePricing'] as bool?,
      realTimeInventory: json['realTimeInventory'] as bool?,
      inventoryIncludedWithPricing:
          json['inventoryIncludedWithPricing'] as bool?,
      storefrontAccess: json['storefrontAccess'] as String?,
      canShowPriceFilters: json['canShowPriceFilters'] as bool?,
      canSeeProducts: json['canSeeProducts'] as bool?,
      canSeePrices: json['canSeePrices'] as bool?,
      canAddToCart: json['canAddToCart'] as bool?,
      pricingService: json['pricingService'] as String?,
      displayAttributesintabs: json['displayAttributesintabs'] as bool?,
      attributesTabSortOrder: json['attributesTabSortOrder'] as String?,
      displayDocumentsintabs: json['displayDocumentsintabs'] as bool?,
      documentsTabSortOrder: json['documentsTabSortOrder'] as String?,
      displayInventoryPerWarehouse:
          json['displayInventoryPerWarehouse'] as bool?,
      displayInventoryPerWarehouseOnlyOnProductDetail:
          json['displayInventoryPerWarehouseOnlyOnProductDetail'] as bool?,
      displayFacetsForStockedItems:
          json['displayFacetsForStockedItems'] as bool?,
      imageProvider: json['imageProvider'] as String?,
      catalogUrlPath: json['catalogUrlPath'] as String?,
      enableVat: json['enableVat'] as bool?,
      vatPriceDisplay: json['vatPriceDisplay'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductSettingsToJson(ProductSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.allowBackOrder case final value?) 'allowBackOrder': value,
      if (instance.allowBackOrderForDelivery case final value?)
        'allowBackOrderForDelivery': value,
      if (instance.allowBackOrderForPickup case final value?)
        'allowBackOrderForPickup': value,
      if (instance.showInventoryAvailability case final value?)
        'showInventoryAvailability': value,
      if (instance.showAddToCartConfirmationDialog case final value?)
        'showAddToCartConfirmationDialog': value,
      if (instance.enableProductComparisons case final value?)
        'enableProductComparisons': value,
      if (instance.alternateUnitsOfMeasure case final value?)
        'alternateUnitsOfMeasure': value,
      if (instance.thirdPartyReviews case final value?)
        'thirdPartyReviews': value,
      if (instance.defaultViewType case final value?) 'defaultViewType': value,
      if (instance.showSavingsAmount case final value?)
        'showSavingsAmount': value,
      if (instance.showSavingsPercent case final value?)
        'showSavingsPercent': value,
      if (instance.realTimePricing case final value?) 'realTimePricing': value,
      if (instance.realTimeInventory case final value?)
        'realTimeInventory': value,
      if (instance.inventoryIncludedWithPricing case final value?)
        'inventoryIncludedWithPricing': value,
      if (instance.storefrontAccess case final value?)
        'storefrontAccess': value,
      if (instance.canShowPriceFilters case final value?)
        'canShowPriceFilters': value,
      if (instance.canSeeProducts case final value?) 'canSeeProducts': value,
      if (instance.canSeePrices case final value?) 'canSeePrices': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.pricingService case final value?) 'pricingService': value,
      if (instance.displayAttributesintabs case final value?)
        'displayAttributesintabs': value,
      if (instance.attributesTabSortOrder case final value?)
        'attributesTabSortOrder': value,
      if (instance.displayDocumentsintabs case final value?)
        'displayDocumentsintabs': value,
      if (instance.documentsTabSortOrder case final value?)
        'documentsTabSortOrder': value,
      if (instance.displayInventoryPerWarehouse case final value?)
        'displayInventoryPerWarehouse': value,
      if (instance.displayInventoryPerWarehouseOnlyOnProductDetail
          case final value?)
        'displayInventoryPerWarehouseOnlyOnProductDetail': value,
      if (instance.displayFacetsForStockedItems case final value?)
        'displayFacetsForStockedItems': value,
      if (instance.imageProvider case final value?) 'imageProvider': value,
      if (instance.catalogUrlPath case final value?) 'catalogUrlPath': value,
      if (instance.enableVat case final value?) 'enableVat': value,
      if (instance.vatPriceDisplay case final value?) 'vatPriceDisplay': value,
    };

SearchSettings _$SearchSettingsFromJson(Map<String, dynamic> json) =>
    SearchSettings(
      autocompleteEnabled: json['autocompleteEnabled'] as bool?,
      searchHistoryEnabled: json['searchHistoryEnabled'] as bool?,
      searchHistoryLimit: (json['searchHistoryLimit'] as num?)?.toInt(),
      enableBoostingByPurchaseHistory:
          json['enableBoostingByPurchaseHistory'] as bool?,
      allowFilteringForPreviouslyPurchasedProducts:
          json['allowFilteringForPreviouslyPurchasedProducts'] as bool?,
      searchPath: json['searchPath'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$SearchSettingsToJson(SearchSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.autocompleteEnabled case final value?)
        'autocompleteEnabled': value,
      if (instance.searchHistoryEnabled case final value?)
        'searchHistoryEnabled': value,
      if (instance.searchHistoryLimit case final value?)
        'searchHistoryLimit': value,
      if (instance.enableBoostingByPurchaseHistory case final value?)
        'enableBoostingByPurchaseHistory': value,
      if (instance.allowFilteringForPreviouslyPurchasedProducts
          case final value?)
        'allowFilteringForPreviouslyPurchasedProducts': value,
      if (instance.searchPath case final value?) 'searchPath': value,
    };

CustomerSettings _$CustomerSettingsFromJson(Map<String, dynamic> json) =>
    CustomerSettings(
      allowBillToAddressEdit: json['allowBillToAddressEdit'] as bool?,
      allowShipToAddressEdit: json['allowShipToAddressEdit'] as bool?,
      allowCreateNewShipToAddress: json['allowCreateNewShipToAddress'] as bool?,
      billToCompanyRequired: json['billToCompanyRequired'] as bool?,
      billToFirstNameRequired: json['billToFirstNameRequired'] as bool?,
      billToLastNameRequired: json['billToLastNameRequired'] as bool?,
      shipToCompanyRequired: json['shipToCompanyRequired'] as bool?,
      shipToFirstNameRequired: json['shipToFirstNameRequired'] as bool?,
      shipToLastNameRequired: json['shipToLastNameRequired'] as bool?,
      budgetsFromOnlineOnly: json['budgetsFromOnlineOnly'] as bool?,
      billToStateRequired: json['billToStateRequired'] as bool?,
      shipToStateRequired: json['shipToStateRequired'] as bool?,
      displayAccountsReceivableBalances:
          json['displayAccountsReceivableBalances'] as bool?,
      allowOneTimeAddresses: json['allowOneTimeAddresses'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CustomerSettingsToJson(CustomerSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.allowBillToAddressEdit case final value?)
        'allowBillToAddressEdit': value,
      if (instance.allowShipToAddressEdit case final value?)
        'allowShipToAddressEdit': value,
      if (instance.allowCreateNewShipToAddress case final value?)
        'allowCreateNewShipToAddress': value,
      if (instance.billToCompanyRequired case final value?)
        'billToCompanyRequired': value,
      if (instance.billToFirstNameRequired case final value?)
        'billToFirstNameRequired': value,
      if (instance.billToLastNameRequired case final value?)
        'billToLastNameRequired': value,
      if (instance.shipToCompanyRequired case final value?)
        'shipToCompanyRequired': value,
      if (instance.shipToFirstNameRequired case final value?)
        'shipToFirstNameRequired': value,
      if (instance.shipToLastNameRequired case final value?)
        'shipToLastNameRequired': value,
      if (instance.budgetsFromOnlineOnly case final value?)
        'budgetsFromOnlineOnly': value,
      if (instance.billToStateRequired case final value?)
        'billToStateRequired': value,
      if (instance.shipToStateRequired case final value?)
        'shipToStateRequired': value,
      if (instance.displayAccountsReceivableBalances case final value?)
        'displayAccountsReceivableBalances': value,
      if (instance.allowOneTimeAddresses case final value?)
        'allowOneTimeAddresses': value,
    };

InvoiceSettings _$InvoiceSettingsFromJson(Map<String, dynamic> json) =>
    InvoiceSettings(
      lookBackDays: (json['lookBackDays'] as num?)?.toInt(),
      showInvoices: json['showInvoices'] as bool?,
    );

Map<String, dynamic> _$InvoiceSettingsToJson(InvoiceSettings instance) =>
    <String, dynamic>{
      if (instance.lookBackDays case final value?) 'lookBackDays': value,
      if (instance.showInvoices case final value?) 'showInvoices': value,
    };

OrderSettings _$OrderSettingsFromJson(Map<String, dynamic> json) =>
    OrderSettings(
      allowCancellationRequest: json['allowCancellationRequest'] as bool?,
      allowQuickOrder: json['allowQuickOrder'] as bool?,
      canReorderItems: json['canReorderItems'] as bool?,
      canOrderUpload: json['canOrderUpload'] as bool?,
      allowRma: json['allowRma'] as bool?,
      showCostCode: json['showCostCode'] as bool?,
      showPoNumber: json['showPoNumber'] as bool?,
      showTermsCode: json['showTermsCode'] as bool?,
      showErpOrderNumber: json['showErpOrderNumber'] as bool?,
      showWebOrderNumber: json['showWebOrderNumber'] as bool?,
      showOrderStatus: json['showOrderStatus'] as bool?,
      showOrders: json['showOrders'] as bool?,
      lookBackDays: (json['lookBackDays'] as num?)?.toInt(),
      vmiEnabled: json['vmiEnabled'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$OrderSettingsToJson(OrderSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.allowCancellationRequest case final value?)
        'allowCancellationRequest': value,
      if (instance.allowQuickOrder case final value?) 'allowQuickOrder': value,
      if (instance.canReorderItems case final value?) 'canReorderItems': value,
      if (instance.canOrderUpload case final value?) 'canOrderUpload': value,
      if (instance.allowRma case final value?) 'allowRma': value,
      if (instance.showCostCode case final value?) 'showCostCode': value,
      if (instance.showPoNumber case final value?) 'showPoNumber': value,
      if (instance.showTermsCode case final value?) 'showTermsCode': value,
      if (instance.showErpOrderNumber case final value?)
        'showErpOrderNumber': value,
      if (instance.showWebOrderNumber case final value?)
        'showWebOrderNumber': value,
      if (instance.showOrderStatus case final value?) 'showOrderStatus': value,
      if (instance.showOrders case final value?) 'showOrders': value,
      if (instance.lookBackDays case final value?) 'lookBackDays': value,
      if (instance.vmiEnabled case final value?) 'vmiEnabled': value,
    };

QuoteSettings _$QuoteSettingsFromJson(Map<String, dynamic> json) =>
    QuoteSettings(
      jobQuoteEnabled: json['jobQuoteEnabled'] as bool?,
      quoteExpireDays: (json['quoteExpireDays'] as num?)?.toInt(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$QuoteSettingsToJson(QuoteSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.jobQuoteEnabled case final value?) 'jobQuoteEnabled': value,
      if (instance.quoteExpireDays case final value?) 'quoteExpireDays': value,
    };

WishListSettings _$WishListSettingsFromJson(Map<String, dynamic> json) =>
    WishListSettings(
      allowMultipleWishLists: json['allowMultipleWishLists'] as bool?,
      allowEditingOfWishLists: json['allowEditingOfWishLists'] as bool?,
      allowWishListsByCustomer: json['allowWishListsByCustomer'] as bool?,
      allowListSharing: json['allowListSharing'] as bool?,
      productsPerPage: (json['productsPerPage'] as num?)?.toInt(),
      enableWishListReminders: json['enableWishListReminders'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WishListSettingsToJson(WishListSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.allowMultipleWishLists case final value?)
        'allowMultipleWishLists': value,
      if (instance.allowEditingOfWishLists case final value?)
        'allowEditingOfWishLists': value,
      if (instance.allowWishListsByCustomer case final value?)
        'allowWishListsByCustomer': value,
      if (instance.allowListSharing case final value?)
        'allowListSharing': value,
      if (instance.productsPerPage case final value?) 'productsPerPage': value,
      if (instance.enableWishListReminders case final value?)
        'enableWishListReminders': value,
    };

WebsiteSettings _$WebsiteSettingsFromJson(Map<String, dynamic> json) =>
    WebsiteSettings(
      mobileAppEnabled: json['mobileAppEnabled'] as bool?,
      useTokenExGateway: json['useTokenExGateway'] as bool?,
      useECheckTokenExGateway: json['useECheckTokenExGateway'] as bool?,
      tokenExTestMode: json['tokenExTestMode'] as bool?,
      usePaymetricGateway: json['usePaymetricGateway'] as bool?,
      useAdyenDropIn: json['useAdyenDropIn'] as bool?,
      useSpreedlyDropIn: json['useSpreedlyDropIn'] as bool?,
      paymentGatewayRequiresAuthentication:
          json['paymentGatewayRequiresAuthentication'] as bool?,
      defaultPageSize: (json['defaultPageSize'] as num?)?.toInt(),
      enableCookiePrivacyPolicyPopup:
          json['enableCookiePrivacyPolicyPopup'] as bool?,
      enableDynamicRecommendations:
          json['enableDynamicRecommendations'] as bool?,
      googleMapsApiKey: json['googleMapsApiKey'] as String?,
      googleTrackingTypeComputed: json['googleTrackingTypeComputed'] as String?,
      googleTrackingAccountId: json['googleTrackingAccountId'] as String?,
      cmsType: $enumDecodeNullable(_$CmsTypeEnumMap, json['cmsType']),
      includeSiteNameInPageTitle: json['includeSiteNameInPageTitle'] as bool?,
      pageTitleDelimiter: json['pageTitleDelimiter'] as String?,
      siteNameAfterTitle: json['siteNameAfterTitle'] as bool?,
      reCaptchaSiteKey: json['reCaptchaSiteKey'] as String?,
      reCaptchaEnabledForContactUs:
          json['reCaptchaEnabledForContactUs'] as bool?,
      reCaptchaEnabledForCreateAccount:
          json['reCaptchaEnabledForCreateAccount'] as bool?,
      reCaptchaEnabledForForgotPassword:
          json['reCaptchaEnabledForForgotPassword'] as bool?,
      reCaptchaEnabledForShareProduct:
          json['reCaptchaEnabledForShareProduct'] as bool?,
      advancedSpireCmsFeatures: json['advancedSpireCmsFeatures'] as bool?,
      previewLoginEnabled: json['previewLoginEnabled'] as bool?,
      maintenanceModeEnabled: json['maintenanceModeEnabled'] as bool?,
      useSquareGateway: json['useSquareGateway'] as bool?,
      squareApplicationId: json['squareApplicationId'] as String?,
      squareLocationId: json['squareLocationId'] as String?,
      squareLive: json['squareLive'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WebsiteSettingsToJson(WebsiteSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.mobileAppEnabled case final value?)
        'mobileAppEnabled': value,
      if (instance.useTokenExGateway case final value?)
        'useTokenExGateway': value,
      if (instance.useECheckTokenExGateway case final value?)
        'useECheckTokenExGateway': value,
      if (instance.tokenExTestMode case final value?) 'tokenExTestMode': value,
      if (instance.usePaymetricGateway case final value?)
        'usePaymetricGateway': value,
      if (instance.useAdyenDropIn case final value?) 'useAdyenDropIn': value,
      if (instance.useSpreedlyDropIn case final value?)
        'useSpreedlyDropIn': value,
      if (instance.paymentGatewayRequiresAuthentication case final value?)
        'paymentGatewayRequiresAuthentication': value,
      if (instance.defaultPageSize case final value?) 'defaultPageSize': value,
      if (instance.enableCookiePrivacyPolicyPopup case final value?)
        'enableCookiePrivacyPolicyPopup': value,
      if (instance.enableDynamicRecommendations case final value?)
        'enableDynamicRecommendations': value,
      if (instance.googleMapsApiKey case final value?)
        'googleMapsApiKey': value,
      if (instance.googleTrackingTypeComputed case final value?)
        'googleTrackingTypeComputed': value,
      if (instance.googleTrackingAccountId case final value?)
        'googleTrackingAccountId': value,
      if (_$CmsTypeEnumMap[instance.cmsType] case final value?)
        'cmsType': value,
      if (instance.includeSiteNameInPageTitle case final value?)
        'includeSiteNameInPageTitle': value,
      if (instance.pageTitleDelimiter case final value?)
        'pageTitleDelimiter': value,
      if (instance.siteNameAfterTitle case final value?)
        'siteNameAfterTitle': value,
      if (instance.reCaptchaSiteKey case final value?)
        'reCaptchaSiteKey': value,
      if (instance.reCaptchaEnabledForContactUs case final value?)
        'reCaptchaEnabledForContactUs': value,
      if (instance.reCaptchaEnabledForCreateAccount case final value?)
        'reCaptchaEnabledForCreateAccount': value,
      if (instance.reCaptchaEnabledForForgotPassword case final value?)
        'reCaptchaEnabledForForgotPassword': value,
      if (instance.reCaptchaEnabledForShareProduct case final value?)
        'reCaptchaEnabledForShareProduct': value,
      if (instance.advancedSpireCmsFeatures case final value?)
        'advancedSpireCmsFeatures': value,
      if (instance.previewLoginEnabled case final value?)
        'previewLoginEnabled': value,
      if (instance.maintenanceModeEnabled case final value?)
        'maintenanceModeEnabled': value,
      if (instance.useSquareGateway case final value?)
        'useSquareGateway': value,
      if (instance.squareApplicationId case final value?)
        'squareApplicationId': value,
      if (instance.squareLocationId case final value?)
        'squareLocationId': value,
      if (instance.squareLive case final value?) 'squareLive': value,
    };

const _$CmsTypeEnumMap = {
  CmsType.classic: 'Classic',
  CmsType.spire: 'Spire',
  CmsType.headless: 'Headless',
};

SpreedlyDto _$SpreedlyDtoFromJson(Map<String, dynamic> json) => SpreedlyDto(
      environmentKey: json['environmentKey'] as String?,
    );

Map<String, dynamic> _$SpreedlyDtoToJson(SpreedlyDto instance) =>
    <String, dynamic>{
      if (instance.environmentKey case final value?) 'environmentKey': value,
    };

TokenExDto _$TokenExDtoFromJson(Map<String, dynamic> json) => TokenExDto(
      tokenExId: json['tokenExId'] as String?,
      origin: json['origin'] as String?,
      timestamp: json['timestamp'] as String?,
      tokenScheme: json['tokenScheme'] as String?,
      authenticationKey: json['authenticationKey'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TokenExDtoToJson(TokenExDto instance) =>
    <String, dynamic>{
      if (instance.tokenExId case final value?) 'tokenExId': value,
      if (instance.origin case final value?) 'origin': value,
      if (instance.timestamp case final value?) 'timestamp': value,
      if (instance.tokenScheme case final value?) 'tokenScheme': value,
      if (instance.authenticationKey case final value?)
        'authenticationKey': value,
      if (instance.token case final value?) 'token': value,
    };

TokenExStyleDto _$TokenExStyleDtoFromJson(Map<String, dynamic> json) =>
    TokenExStyleDto(
      baseColor: json['baseColor'] as String?,
      focusColor: json['focusColor'] as String?,
      errorColor: json['errorColor'] as String?,
      textColor: json['textColor'] as String?,
      borderWidth: json['borderWidth'] as String?,
    );

Map<String, dynamic> _$TokenExStyleDtoToJson(TokenExStyleDto instance) =>
    <String, dynamic>{
      if (instance.baseColor case final value?) 'baseColor': value,
      if (instance.focusColor case final value?) 'focusColor': value,
      if (instance.errorColor case final value?) 'errorColor': value,
      if (instance.textColor case final value?) 'textColor': value,
      if (instance.borderWidth case final value?) 'borderWidth': value,
    };

PickUpSettings _$PickUpSettingsFromJson(Map<String, dynamic> json) =>
    PickUpSettings(
      warehousesPageSize: (json['warehousesPageSize'] as num?)?.toInt(),
      searchRadius: (json['searchRadius'] as num?)?.toInt(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$PickUpSettingsToJson(PickUpSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.warehousesPageSize case final value?)
        'warehousesPageSize': value,
      if (instance.searchRadius case final value?) 'searchRadius': value,
    };

MobileAppSettings _$MobileAppSettingsFromJson(Map<String, dynamic> json) =>
    MobileAppSettings(
      startingCategoryForBrowsing:
          json['startingCategoryForBrowsing'] as String?,
      hasCheckout: json['hasCheckout'] as bool?,
      overrideCheckoutNavigation: json['overrideCheckoutNavigation'] as bool?,
      checkoutUrl: json['checkoutUrl'] as String?,
      addToCartInProductList: json['addToCartInProductList'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$MobileAppSettingsToJson(MobileAppSettings instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.startingCategoryForBrowsing case final value?)
        'startingCategoryForBrowsing': value,
      if (instance.hasCheckout case final value?) 'hasCheckout': value,
      if (instance.overrideCheckoutNavigation case final value?)
        'overrideCheckoutNavigation': value,
      if (instance.checkoutUrl case final value?) 'checkoutUrl': value,
      if (instance.addToCartInProductList case final value?)
        'addToCartInProductList': value,
    };
