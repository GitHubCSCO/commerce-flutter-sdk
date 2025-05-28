import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('CommerceAPIConstants', () {
    test('Instance should be created', () {
      expect(CommerceAPIConstants.instance, isNotNull);
      expect(CommerceAPIConstants.instance.runtimeType, CommerceAPIConstants);
    });
    test('Constants should have correct values', () {
      expect(CommerceAPIConstants.addingToCartMillisecondsDelay, 5000);
      expect(CommerceAPIConstants.ordersUrl, "/api/v1/orders");
      expect(CommerceAPIConstants.orderApprovalsUrl, "/api/v1/orderapprovals");
      expect(CommerceAPIConstants.ordersShareUrl, "/api/v1/orders/shareorder");
      expect(CommerceAPIConstants.orderStatusMappingsUrl,
          "/api/v1/orderstatusmappings");
      expect(CommerceAPIConstants.accountUrl, "/api/v1/accounts");
      expect(CommerceAPIConstants.currentPaymentProfiles,
          "/current/paymentprofiles");
      expect(CommerceAPIConstants.paymentProfileUrl,
          "/api/v1/accounts/current/paymentprofiles");
      expect(CommerceAPIConstants.resetPasswordUrl,
          "/admin/account/ForgotPassword");
      expect(CommerceAPIConstants.adminUserProfileUrl,
          "/api/v1/admin/AdminUserProfiles/Default.Default()");
      expect(CommerceAPIConstants.autocompleteUrl, "/api/v1/autocomplete");
      expect(CommerceAPIConstants.billTosUrl, "/api/v1/billtos");
      expect(CommerceAPIConstants.billToCurrentUrl, "/api/v1/billtos/current");
      expect(CommerceAPIConstants.billToCurrentShipTosUrl,
          "/api/v1/billtos/current/shiptos");
      expect(CommerceAPIConstants.billToCurrentShipToCurrentUrl,
          "/api/v1/billtos/current/shiptos/current");
      expect(CommerceAPIConstants.brandAlphabetUrl, "/api/v1/brandalphabet");
      expect(CommerceAPIConstants.brandUrl, "/api/v1/brands");
      expect(CommerceAPIConstants.brandCategoriesUrlFormat,
          "/api/v1/brands/{0}/categories");
      expect(CommerceAPIConstants.brandSubCategoriesUrlFormat,
          "/api/v1/brands/{0}/categories/{1}");
      expect(CommerceAPIConstants.brandProductLinesUrlFormat,
          "/api/v1/brands/{0}/productlines");
      expect(CommerceAPIConstants.cartsUrl, "/api/v1/carts");
      expect(CommerceAPIConstants.cartCurrentUrl, "/api/v1/carts/current");
      expect(CommerceAPIConstants.cartCurrentCartLinesUrl,
          "/api/v1/carts/current/cartlines");
      expect(CommerceAPIConstants.cartCurrentCartLineUrl,
          "/api/v1/carts/current/cartlines");
      expect(CommerceAPIConstants.cartCurrentPromotionsUrl,
          "/api/v1/carts/current/promotions");
      expect(CommerceAPIConstants.cartPromotionsUrl,
          "/api/v1/carts/{0}/promotions");
      expect(CommerceAPIConstants.catalogPageUrl, "/api/v1/catalogpages?path=");
      expect(CommerceAPIConstants.categoryUrl, "/api/v1/categories");
      expect(CommerceAPIConstants.mobileImageProperty, "mobileImage");
      expect(
          CommerceAPIConstants.mobilePrimaryTextProperty, "mobilePrimaryText");
      expect(CommerceAPIConstants.mobileSecondaryTextProperty,
          "mobileSecondaryText");
      expect(CommerceAPIConstants.dashboardPanelUrl, "/api/v1/dashboardpanels");
      expect(CommerceAPIConstants.dealersUrl, "/api/v1/dealers");
      expect(CommerceAPIConstants.invoicesUrl, "/api/v1/invoices");
      expect(CommerceAPIConstants.jobQuoteUrl, "/api/v1/jobquotes");
      expect(CommerceAPIConstants.messageUrl, "/api/v1/messages");
      expect(CommerceAPIConstants.mobileContentUrlFormat,
          "/api/v1/mobilecontent/{0}");
      expect(CommerceAPIConstants.contentUrl,
          "/api/v2/content/pageByType?type=Mobile/");
      expect(CommerceAPIConstants.productsUrl, "/api/v1/products");
      expect(CommerceAPIConstants.productsV2Url, "/api/v2/products");
      expect(
          CommerceAPIConstants.realTimePricingUrl, "/api/v1/realtimepricing");
      expect(CommerceAPIConstants.realTimeInventoryUrl,
          "/api/v1/realtimeinventory");
      expect(CommerceAPIConstants.quoteLineUrl,
          "/api/v1/quotes/{0}/quotelines/{1}");
      expect(CommerceAPIConstants.quoteUrl, "/api/v1/quotes");
      expect(CommerceAPIConstants.postSessionUrl, "/api/v1/sessions");
      expect(
          CommerceAPIConstants.currentSessionUrl, "/api/v1/sessions/current");
      expect(CommerceAPIConstants.settingsUrl, "/api/v1/settings");
      expect(
          CommerceAPIConstants.productSettingsUrl, "/api/v1/settings/products");
      expect(
          CommerceAPIConstants.accountSettingsUrl, "/api/v1/settings/account");
      expect(
          CommerceAPIConstants.websiteSettingsUrl, "/api/v1/settings/website");
      expect(CommerceAPIConstants.wishListSettingsUrl,
          "/api/v1/settings/wishlist");
      expect(CommerceAPIConstants.cartSettingsUrl, "/api/v1/settings/cart");
      expect(CommerceAPIConstants.mobileAppSettingsUrl,
          "/api/v1/settings/mobileapp");
      expect(CommerceAPIConstants.quoteSettingsUrl, "/api/v1/settings/quote");
      expect(CommerceAPIConstants.tokenExConfigUrl, "/api/v1/tokenexconfig");
      expect(CommerceAPIConstants.translationUrl,
          "/api/v1/translationdictionaries");
      expect(CommerceAPIConstants.vmiLocationsUrl, "/api/v1/vmilocations");
      expect(CommerceAPIConstants.warehousesUrl, "/api/v1/warehouses");
      expect(CommerceAPIConstants.websitesUrl, "/api/v1/websites/current");
      expect(CommerceAPIConstants.websitesAddressFieldsUrl,
          "/api/v1/websites/current/addressfields");
      expect(CommerceAPIConstants.websitesCountriesUrl,
          "/api/v1/websites/current/countries");
      expect(CommerceAPIConstants.websitesCrossSellsUrl,
          "/api/v1/websites/current/crosssells");
      expect(CommerceAPIConstants.websitesCurrenciesUrl,
          "/api/v1/websites/current/currencies");
      expect(CommerceAPIConstants.websitesLanguagesUrl,
          "/api/v1/websites/current/languages");
      expect(CommerceAPIConstants.websitesSiteMessagesUrl,
          "/api/v1/websites/current/sitemessages");
      expect(CommerceAPIConstants.websitesStatesUrl,
          "/api/v1/websites/current/states");
      expect(
          CommerceAPIConstants.tokenLogoutUrl, "identity/connect/endsession");
      expect(CommerceAPIConstants.tokenValidationUrl,
          "identity/connect/accesstokenvalidation?token=");
      expect(CommerceAPIConstants.tokenUrl, "identity/connect/token");
      expect(CommerceAPIConstants.wishListUrl, "/api/v1/wishlists");
    });
  });
}
