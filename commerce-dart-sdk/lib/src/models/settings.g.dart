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

Map<String, dynamic> _$SettingsToJson(Settings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('settingsCollection', instance.settingsCollection?.toJson());
  return val;
}

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

Map<String, dynamic> _$SettingsCollectionToJson(SettingsCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('accountSettings', instance.accountSettings?.toJson());
  writeNotNull('cartSettings', instance.cartSettings?.toJson());
  writeNotNull('productSettings', instance.productSettings?.toJson());
  writeNotNull('searchSettings', instance.searchSettings?.toJson());
  writeNotNull('customerSettings', instance.customerSettings?.toJson());
  writeNotNull('invoiceSettings', instance.invoiceSettings?.toJson());
  writeNotNull('orderSettings', instance.orderSettings?.toJson());
  writeNotNull('quoteSettings', instance.quoteSettings?.toJson());
  writeNotNull('wishListSettings', instance.wishListSettings?.toJson());
  writeNotNull('websiteSettings', instance.websiteSettings?.toJson());
  writeNotNull('pickUpSettings', instance.pickUpSettings?.toJson());
  return val;
}

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

Map<String, dynamic> _$AccountSettingsToJson(AccountSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('allowCreateAccount', instance.allowCreateAccount);
  writeNotNull('allowGuestCheckout', instance.allowGuestCheckout);
  writeNotNull(
      'allowSubscribeToNewsLetter', instance.allowSubscribeToNewsLetter);
  writeNotNull(
      'requireSelectCustomerOnSignIn', instance.requireSelectCustomerOnSignIn);
  writeNotNull('passwordMinimumLength', instance.passwordMinimumLength);
  writeNotNull(
      'passwordMinimumRequiredLength', instance.passwordMinimumRequiredLength);
  writeNotNull('passwordRequiresSpecialCharacter',
      instance.passwordRequiresSpecialCharacter);
  writeNotNull('passwordRequiresUppercase', instance.passwordRequiresUppercase);
  writeNotNull('passwordRequiresLowercase', instance.passwordRequiresLowercase);
  writeNotNull('rememberMe', instance.rememberMe);
  writeNotNull('passwordRequiresDigit', instance.passwordRequiresDigit);
  writeNotNull('daysToRetainUser', instance.daysToRetainUser);
  writeNotNull('useEmailAsUserName', instance.useEmailAsUserName);
  writeNotNull('enableWarehousePickup', instance.enableWarehousePickup);
  writeNotNull(
      'logOutUserAfterPasswordChange', instance.logOutUserAfterPasswordChange);
  return val;
}

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

Map<String, dynamic> _$CartSettingsToJson(CartSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('canRequestDeliveryDate', instance.canRequestDeliveryDate);
  writeNotNull('canRequisition', instance.canRequisition);
  writeNotNull('canEditCostCode', instance.canEditCostCode);
  writeNotNull('maximumDeliveryPeriod', instance.maximumDeliveryPeriod);
  writeNotNull('showCostCode', instance.showCostCode);
  writeNotNull('showPoNumber', instance.showPoNumber);
  writeNotNull('showPayPal', instance.showPayPal);
  writeNotNull('showCreditCard', instance.showCreditCard);
  writeNotNull('showTaxAndShipping', instance.showTaxAndShipping);
  writeNotNull('showLineNotes', instance.showLineNotes);
  writeNotNull('showNewsletterSignup', instance.showNewsletterSignup);
  writeNotNull('requiresPoNumber', instance.requiresPoNumber);
  writeNotNull('addToCartPopupTimeout', instance.addToCartPopupTimeout);
  writeNotNull('enableRequestPickUpDate', instance.enableRequestPickUpDate);
  writeNotNull('enableSavedCreditCards', instance.enableSavedCreditCards);
  writeNotNull('bypassCvvForSavedCards', instance.bypassCvvForSavedCards);
  return val;
}

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

Map<String, dynamic> _$ProductSettingsToJson(ProductSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('allowBackOrder', instance.allowBackOrder);
  writeNotNull('allowBackOrderForDelivery', instance.allowBackOrderForDelivery);
  writeNotNull('allowBackOrderForPickup', instance.allowBackOrderForPickup);
  writeNotNull('showInventoryAvailability', instance.showInventoryAvailability);
  writeNotNull('showAddToCartConfirmationDialog',
      instance.showAddToCartConfirmationDialog);
  writeNotNull('enableProductComparisons', instance.enableProductComparisons);
  writeNotNull('alternateUnitsOfMeasure', instance.alternateUnitsOfMeasure);
  writeNotNull('thirdPartyReviews', instance.thirdPartyReviews);
  writeNotNull('defaultViewType', instance.defaultViewType);
  writeNotNull('showSavingsAmount', instance.showSavingsAmount);
  writeNotNull('showSavingsPercent', instance.showSavingsPercent);
  writeNotNull('realTimePricing', instance.realTimePricing);
  writeNotNull('realTimeInventory', instance.realTimeInventory);
  writeNotNull(
      'inventoryIncludedWithPricing', instance.inventoryIncludedWithPricing);
  writeNotNull('storefrontAccess', instance.storefrontAccess);
  writeNotNull('canShowPriceFilters', instance.canShowPriceFilters);
  writeNotNull('canSeeProducts', instance.canSeeProducts);
  writeNotNull('canSeePrices', instance.canSeePrices);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('pricingService', instance.pricingService);
  writeNotNull('displayAttributesintabs', instance.displayAttributesintabs);
  writeNotNull('attributesTabSortOrder', instance.attributesTabSortOrder);
  writeNotNull('displayDocumentsintabs', instance.displayDocumentsintabs);
  writeNotNull('documentsTabSortOrder', instance.documentsTabSortOrder);
  writeNotNull(
      'displayInventoryPerWarehouse', instance.displayInventoryPerWarehouse);
  writeNotNull('displayInventoryPerWarehouseOnlyOnProductDetail',
      instance.displayInventoryPerWarehouseOnlyOnProductDetail);
  writeNotNull(
      'displayFacetsForStockedItems', instance.displayFacetsForStockedItems);
  writeNotNull('imageProvider', instance.imageProvider);
  writeNotNull('catalogUrlPath', instance.catalogUrlPath);
  writeNotNull('enableVat', instance.enableVat);
  writeNotNull('vatPriceDisplay', instance.vatPriceDisplay);
  return val;
}

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

Map<String, dynamic> _$SearchSettingsToJson(SearchSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('autocompleteEnabled', instance.autocompleteEnabled);
  writeNotNull('searchHistoryEnabled', instance.searchHistoryEnabled);
  writeNotNull('searchHistoryLimit', instance.searchHistoryLimit);
  writeNotNull('enableBoostingByPurchaseHistory',
      instance.enableBoostingByPurchaseHistory);
  writeNotNull('allowFilteringForPreviouslyPurchasedProducts',
      instance.allowFilteringForPreviouslyPurchasedProducts);
  writeNotNull('searchPath', instance.searchPath);
  return val;
}

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

Map<String, dynamic> _$CustomerSettingsToJson(CustomerSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('allowBillToAddressEdit', instance.allowBillToAddressEdit);
  writeNotNull('allowShipToAddressEdit', instance.allowShipToAddressEdit);
  writeNotNull(
      'allowCreateNewShipToAddress', instance.allowCreateNewShipToAddress);
  writeNotNull('billToCompanyRequired', instance.billToCompanyRequired);
  writeNotNull('billToFirstNameRequired', instance.billToFirstNameRequired);
  writeNotNull('billToLastNameRequired', instance.billToLastNameRequired);
  writeNotNull('shipToCompanyRequired', instance.shipToCompanyRequired);
  writeNotNull('shipToFirstNameRequired', instance.shipToFirstNameRequired);
  writeNotNull('shipToLastNameRequired', instance.shipToLastNameRequired);
  writeNotNull('budgetsFromOnlineOnly', instance.budgetsFromOnlineOnly);
  writeNotNull('billToStateRequired', instance.billToStateRequired);
  writeNotNull('shipToStateRequired', instance.shipToStateRequired);
  writeNotNull('displayAccountsReceivableBalances',
      instance.displayAccountsReceivableBalances);
  writeNotNull('allowOneTimeAddresses', instance.allowOneTimeAddresses);
  return val;
}

InvoiceSettings _$InvoiceSettingsFromJson(Map<String, dynamic> json) =>
    InvoiceSettings(
      lookBackDays: (json['lookBackDays'] as num?)?.toInt(),
      showInvoices: json['showInvoices'] as bool?,
    );

Map<String, dynamic> _$InvoiceSettingsToJson(InvoiceSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lookBackDays', instance.lookBackDays);
  writeNotNull('showInvoices', instance.showInvoices);
  return val;
}

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

Map<String, dynamic> _$OrderSettingsToJson(OrderSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('allowCancellationRequest', instance.allowCancellationRequest);
  writeNotNull('allowQuickOrder', instance.allowQuickOrder);
  writeNotNull('canReorderItems', instance.canReorderItems);
  writeNotNull('canOrderUpload', instance.canOrderUpload);
  writeNotNull('allowRma', instance.allowRma);
  writeNotNull('showCostCode', instance.showCostCode);
  writeNotNull('showPoNumber', instance.showPoNumber);
  writeNotNull('showTermsCode', instance.showTermsCode);
  writeNotNull('showErpOrderNumber', instance.showErpOrderNumber);
  writeNotNull('showWebOrderNumber', instance.showWebOrderNumber);
  writeNotNull('showOrderStatus', instance.showOrderStatus);
  writeNotNull('showOrders', instance.showOrders);
  writeNotNull('lookBackDays', instance.lookBackDays);
  writeNotNull('vmiEnabled', instance.vmiEnabled);
  return val;
}

QuoteSettings _$QuoteSettingsFromJson(Map<String, dynamic> json) =>
    QuoteSettings(
      jobQuoteEnabled: json['jobQuoteEnabled'] as bool?,
      quoteExpireDays: (json['quoteExpireDays'] as num?)?.toInt(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$QuoteSettingsToJson(QuoteSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('jobQuoteEnabled', instance.jobQuoteEnabled);
  writeNotNull('quoteExpireDays', instance.quoteExpireDays);
  return val;
}

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

Map<String, dynamic> _$WishListSettingsToJson(WishListSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('allowMultipleWishLists', instance.allowMultipleWishLists);
  writeNotNull('allowEditingOfWishLists', instance.allowEditingOfWishLists);
  writeNotNull('allowWishListsByCustomer', instance.allowWishListsByCustomer);
  writeNotNull('allowListSharing', instance.allowListSharing);
  writeNotNull('productsPerPage', instance.productsPerPage);
  writeNotNull('enableWishListReminders', instance.enableWishListReminders);
  return val;
}

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

Map<String, dynamic> _$WebsiteSettingsToJson(WebsiteSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('mobileAppEnabled', instance.mobileAppEnabled);
  writeNotNull('useTokenExGateway', instance.useTokenExGateway);
  writeNotNull('useECheckTokenExGateway', instance.useECheckTokenExGateway);
  writeNotNull('tokenExTestMode', instance.tokenExTestMode);
  writeNotNull('usePaymetricGateway', instance.usePaymetricGateway);
  writeNotNull('useAdyenDropIn', instance.useAdyenDropIn);
  writeNotNull('useSpreedlyDropIn', instance.useSpreedlyDropIn);
  writeNotNull('paymentGatewayRequiresAuthentication',
      instance.paymentGatewayRequiresAuthentication);
  writeNotNull('defaultPageSize', instance.defaultPageSize);
  writeNotNull('enableCookiePrivacyPolicyPopup',
      instance.enableCookiePrivacyPolicyPopup);
  writeNotNull(
      'enableDynamicRecommendations', instance.enableDynamicRecommendations);
  writeNotNull('googleMapsApiKey', instance.googleMapsApiKey);
  writeNotNull(
      'googleTrackingTypeComputed', instance.googleTrackingTypeComputed);
  writeNotNull('googleTrackingAccountId', instance.googleTrackingAccountId);
  writeNotNull('cmsType', _$CmsTypeEnumMap[instance.cmsType]);
  writeNotNull(
      'includeSiteNameInPageTitle', instance.includeSiteNameInPageTitle);
  writeNotNull('pageTitleDelimiter', instance.pageTitleDelimiter);
  writeNotNull('siteNameAfterTitle', instance.siteNameAfterTitle);
  writeNotNull('reCaptchaSiteKey', instance.reCaptchaSiteKey);
  writeNotNull(
      'reCaptchaEnabledForContactUs', instance.reCaptchaEnabledForContactUs);
  writeNotNull('reCaptchaEnabledForCreateAccount',
      instance.reCaptchaEnabledForCreateAccount);
  writeNotNull('reCaptchaEnabledForForgotPassword',
      instance.reCaptchaEnabledForForgotPassword);
  writeNotNull('reCaptchaEnabledForShareProduct',
      instance.reCaptchaEnabledForShareProduct);
  writeNotNull('advancedSpireCmsFeatures', instance.advancedSpireCmsFeatures);
  writeNotNull('previewLoginEnabled', instance.previewLoginEnabled);
  writeNotNull('maintenanceModeEnabled', instance.maintenanceModeEnabled);
  writeNotNull('useSquareGateway', instance.useSquareGateway);
  writeNotNull('squareApplicationId', instance.squareApplicationId);
  writeNotNull('squareLocationId', instance.squareLocationId);
  writeNotNull('squareLive', instance.squareLive);
  return val;
}

const _$CmsTypeEnumMap = {
  CmsType.classic: 'Classic',
  CmsType.spire: 'Spire',
  CmsType.headless: 'Headless',
};

SpreedlyDto _$SpreedlyDtoFromJson(Map<String, dynamic> json) => SpreedlyDto(
      environmentKey: json['environmentKey'] as String?,
    );

Map<String, dynamic> _$SpreedlyDtoToJson(SpreedlyDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('environmentKey', instance.environmentKey);
  return val;
}

TokenExDto _$TokenExDtoFromJson(Map<String, dynamic> json) => TokenExDto(
      tokenExId: json['tokenExId'] as String?,
      origin: json['origin'] as String?,
      timestamp: json['timestamp'] as String?,
      tokenScheme: json['tokenScheme'] as String?,
      authenticationKey: json['authenticationKey'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$TokenExDtoToJson(TokenExDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tokenExId', instance.tokenExId);
  writeNotNull('origin', instance.origin);
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('tokenScheme', instance.tokenScheme);
  writeNotNull('authenticationKey', instance.authenticationKey);
  writeNotNull('token', instance.token);
  return val;
}

TokenExStyleDto _$TokenExStyleDtoFromJson(Map<String, dynamic> json) =>
    TokenExStyleDto(
      baseColor: json['baseColor'] as String?,
      focusColor: json['focusColor'] as String?,
      errorColor: json['errorColor'] as String?,
      textColor: json['textColor'] as String?,
      borderWidth: json['borderWidth'] as String?,
    );

Map<String, dynamic> _$TokenExStyleDtoToJson(TokenExStyleDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('baseColor', instance.baseColor);
  writeNotNull('focusColor', instance.focusColor);
  writeNotNull('errorColor', instance.errorColor);
  writeNotNull('textColor', instance.textColor);
  writeNotNull('borderWidth', instance.borderWidth);
  return val;
}

PickUpSettings _$PickUpSettingsFromJson(Map<String, dynamic> json) =>
    PickUpSettings(
      warehousesPageSize: (json['warehousesPageSize'] as num?)?.toInt(),
      searchRadius: (json['searchRadius'] as num?)?.toInt(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$PickUpSettingsToJson(PickUpSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('warehousesPageSize', instance.warehousesPageSize);
  writeNotNull('searchRadius', instance.searchRadius);
  return val;
}

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

Map<String, dynamic> _$MobileAppSettingsToJson(MobileAppSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'startingCategoryForBrowsing', instance.startingCategoryForBrowsing);
  writeNotNull('hasCheckout', instance.hasCheckout);
  writeNotNull(
      'overrideCheckoutNavigation', instance.overrideCheckoutNavigation);
  writeNotNull('checkoutUrl', instance.checkoutUrl);
  writeNotNull('addToCartInProductList', instance.addToCartInProductList);
  return val;
}
