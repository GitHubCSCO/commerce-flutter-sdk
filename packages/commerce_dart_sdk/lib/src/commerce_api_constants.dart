class CommerceAPIConstants {
  CommerceAPIConstants._();
  static final instance = CommerceAPIConstants._();

  // static const String ShortDescriptionUnique = nameof(ShortDescriptionUnique);

  // static const String ManufacturerItemUnique = nameof(ManufacturerItemUnique);

  // static const String ManufacturerItem = nameof(ManufacturerItem);

  // static const String CustomerNameUnique = nameof(CustomerNameUnique);

  static const int addingToCartMillisecondsDelay = 5000;

  // static const String CustomerName = nameof(CustomerName);

  // static const String KeyWord = nameof(KeyWord);

  // static const String ErpNumber = nameof(ErpNumber);

  static const String ordersUrl = "/api/v1/orders";

  static const String orderApprovalsUrl = "/api/v1/orderapprovals";

  static const String ordersShareUrl = "/api/v1/orders/shareorder";

  static const String orderStatusMappingsUrl = "/api/v1/orderstatusmappings";

  static const String accountUrl = "/api/v1/accounts";

  static const String currentPaymentProfiles = "/current/paymentprofiles";

  static const String paymentProfileUrl =
      "/api/v1/accounts/current/paymentprofiles";

  static const String resetPasswordUrl = "/admin/account/ForgotPassword";

  static const String adminUserProfileUrl =
      "/api/v1/admin/AdminUserProfiles/Default.Default()";

  static const String autocompleteUrl = "/api/v1/autocomplete";

  static const String billTosUrl = "/api/v1/billtos";

  static const String billToCurrentUrl = "/api/v1/billtos/current";

  static const String billToCurrentShipTosUrl =
      "/api/v1/billtos/current/shiptos";

  static const String billToCurrentShipToCurrentUrl =
      "/api/v1/billtos/current/shiptos/current";

  static const String brandAlphabetUrl = "/api/v1/brandalphabet";

  static const String brandUrl = "/api/v1/brands";

  static const String brandCategoriesUrlFormat =
      "/api/v1/brands/{0}/categories";

  static const String brandSubCategoriesUrlFormat =
      "/api/v1/brands/{0}/categories/{1}";

  static const String brandProductLinesUrlFormat =
      "/api/v1/brands/{0}/productlines";

  static const String cartsUrl = "/api/v1/carts";

  static const String cartCurrentUrl = "/api/v1/carts/current";

  static const String cartCurrentCartLinesUrl =
      "/api/v1/carts/current/cartlines";

  static const String cartCurrentCartLineUrl = "api/v1/carts/current/cartlines";

  static const String cartCurrentPromotionsUrl =
      "/api/v1/carts/current/promotions";

  static const String cartPromotionsUrl = "/api/v1/carts/{0}/promotions";

  static const String catalogPageUrl = "/api/v1/catalogpages?path=";

  static const String categoryUrl = "/api/v1/categories";

  static const String mobileImageProperty = "mobileImage";

  static const String mobilePrimaryTextProperty = "mobilePrimaryText";

  static const String mobileSecondaryTextProperty = "mobileSecondaryText";

  static const String dashboardPanelUrl = "/api/v1/dashboardpanels";

  static const String dealersUrl = "/api/v1/dealers";

  static const String invoicesUrl = "/api/v1/invoices";

  static const String jobQuoteUrl = "/api/v1/jobquotes";

  static const String messageUrl = "/api/v1/messages";

  static const String mobileContentUrlFormat = "/api/v1/mobilecontent/{0}";

  static const String contentUrl = "/api/v2/content/pageByType?type=Mobile/";

  static const String productsUrl = "/api/v1/products";

  static const String productsV2Url = "/api/v2/products";

  static const String realTimePricingUrl = "/api/v1/realtimepricing";

  static const String realTimeInventoryUrl = "/api/v1/realtimeinventory";

  static const String quoteLineUrl = "/api/v1/quotes/{0}/quotelines/{1}";

  static const String quoteUrl = "/api/v1/quotes";

  static const String postSessionUrl = "/api/v1/sessions";

  static const String currentSessionUrl = "/api/v1/sessions/current";

  static const String settingsUrl = "/api/v1/settings";

  static const String productSettingsUrl = "/api/v1/settings/products";

  static const String accountSettingsUrl = "/api/v1/settings/account";

  static const String websiteSettingsUrl = "/api/v1/settings/website";

  static const String wishListSettingsUrl = "/api/v1/settings/wishlist";

  static const String cartSettingsUrl = "/api/v1/settings/cart";

  static const String mobileAppSettingsUrl = "/api/v1/settings/mobileapp";

  static const String quoteSettingsUrl = "/api/v1/settings/quote";

  static const String tokenExConfigUrl = "/api/v1/tokenexconfig";

  static const String translationUrl = "/api/v1/translationdictionaries";

  static const String vmiLocationsUrl = "/api/v1/vmilocations";

  static const String warehousesUrl = "/api/v1/warehouses";

  static const String websitesUrl = "/api/v1/websites/current";

  static const String websitesAddressFieldsUrl =
      "/api/v1/websites/current/addressfields";

  static const String websitesCountriesUrl =
      "/api/v1/websites/current/countries";

  static const String websitesCrossSellsUrl =
      "/api/v1/websites/current/crosssells";

  static const String websitesCurrenciesUrl =
      "/api/v1/websites/current/currencies";

  static const String websitesLanguagesUrl =
      "/api/v1/websites/current/languages";

  static const String websitesSiteMessagesUrl =
      "/api/v1/websites/current/sitemessages";

  static const String websitesStatesUrl = "/api/v1/websites/current/states";

  static const String tokenLogoutUrl = "identity/connect/endsession";

  static const String tokenValidationUrl =
      "identity/connect/accesstokenvalidation?token=";

  static const String tokenUrl = "identity/connect/token";

  static const String wishListUrl = "/api/v1/wishlists";
}
