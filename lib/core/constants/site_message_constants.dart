class SiteMessageConstants {
  // request names
  static String get nameAddToCartSuccess => "Cart_ProductAddedToCart";
  static String get nameAddToCartFail => "Cart_ProductCantBeAddedToCart";
  static String get nameAddToCartAllProductsSuccess =>
      "Cart_AllProductsAddedToCart";
  static String get nameAddToCartQuantityAdjusted => "Cart_QuantityAdjusted";
  static String get nameCartProductCannotBePurchased =>
      "Cart_ProductsCannotBePurchased";
  static String get nameCartNoPriceAvailableAtCheckout =>
      "Cart_NoPriceAvailableAtCheckout";
  static String get nameCartProductPromotionItem => "Cart_PromotionalItem";
  static String get nameNoOrderLines => "Cart_NoOrderLines";
  static String get nameTooManyQtyRequested => "Cart_ToManyQtyRequested";
  static String get namePCIRequestError => "CreditCardInfo_GatewayDown";
  static String get nameWishListNoProducts => "Lists_NoItemsInList";
  static String get nameWishListInviteIsNotAvailable =>
      "Lists_InviteIsNotAvailable";
  static String get nameWishListItemsDiscontinuedAndRemoved =>
      "Lists_Items_Discontinued_And_Removed";
  static String get nameWishListItemsNotDisplayedDueRestrictions =>
      "Lists_Items_Not_Displayed_Due_Restrictions";
  static String get nameWishListNoListsFound => "Lists_NoListsFound";
  static String get nameWishListNameRequired => "Lists_List_Name_Required";
  static String get nameWishListProductAdded => "Lists_ProductAdded";
  static String get nameRealTimePricingLoadFail =>
      "RealTimePricing_PriceLoadFailed";
  static String get nameRealTimeInventoryLoadFail =>
      "RealTimeInventory_InventoryLoadFailed";
  static String get namePricingZeroPriceMessage => "Pricing_ZeroPriceMessage";
  static String get namePricingSignInForPrice => "Pricing_SignInForPrice";
  static String get nameQuickOrderInstructions => "QuickOrder_Instructions";
  static String get nameProductNotFound => "Product_NotFound";

  static String get nameQuickOrderCannotOrderConfigurable =>
      "QuickOrder_CannotOrderConfigurable";
  static String get nameQuickOrderCannotOrderStyled =>
      "QuickOrder_CannotOrderStyled";
  static String get nameQuickOrderCannotOrderUnavailable =>
      "QuickOrder_ProductIsUnavailable";
  static String get nameBrandLoadFail => "Brand_LoadFailure";

  static String get nameCreditCardInfoCardNumberInvalid =>
      "CreditCardInfo_CardNumber_Invalid";
  static String get nameCreditCardInfoCardNumberRequired =>
      "CreditCardInfo_CardNumber_Required";
  static String get nameCreditCardInfoCardHolderNameRequired =>
      "CreditCardInfo_CardHolderName_Required";
  static String get nameCreditCardInfoSecurityCodeInvalid =>
      "CreditCardInfo_SecurityCode_Invalid";
  static String get nameCreditCardInfoSecurityCodeRequired =>
      "CreditCardInfo_SecurityCode_Required";

  static String get nameAddressEmailInvalid =>
      "AddressInfo_EmailAddress_Validation";

  static String get nameDefaultCustomerSetFail =>
      "DefaultCustomer_SetDefaultErrorMessage";
  static String get nameDefaultCustomMessageInChekoutOrderReview =>
      "Chekout_CustomReviewOrderMessage";
  static String get nameCartLineBackfillMessage => "GTS_InventoryAvailability";

  static String get nameCheckoutRequestedDeliveryDateMessage =>
      "Checkout_RequestedDeliveryDateInformation";
  static String get nameCheckoutRequestedPickUpDateMessage =>
      "Checkout_RequestedPickupDateInformation";
  static String get nameCheckoutPaymentProfileExpiredMessage =>
      "Checkout_PaymentProfileExpired";

  static String get nameMobileAppAccountUnauthenticatedDescription =>
      "MobileApp_Account_Unauthenticated_Description";
  static String get nameMobileAppOrderConfirmationSuccessMessage =>
      "MobileApp_OrderConfirmation_Success_Message";
  static String get nameMobileAppSearchNoResults =>
      "MobileApp_Search_No_Results";
  static String get nameMobileAppSelectDomainDescription =>
      "MobileApp_SelectDomain_Description";
  static String get nameCartInsufficientInventoryAtCheckout =>
      "Cart_InsufficientInventoryAtCheckout";
  static String get nameCartInsufficientPickupInventory =>
      "Cart_InsufficientPickupInventory";
  static String get nameMobileAppSignInAgreement =>
      "MobileApp_SignIn_Agreement";

  static String get nameMobileAppAlertNoInternet =>
      "MobileApp_Alert_NoInternet";
  static String get nameMobileAppAlertNoInternetDescription =>
      "MobileApp_Alert_NoInternet_Description";
  static String get nameMobileAppAlertCameraAcessDenied =>
      "MobileApp_Alert_CameraAcess_Denied";
  static String get nameMobileAppAlertCommunicationError =>
      "MobileApp_Alert_Communication_Error";

  static String get nameMobileAppNoWarehousesError =>
      "MobileApp_Availability_No_Warehouses";

  static String get nameMobileAppAdminLoginAdvertisingTitle =>
      "MobileApp_Admin_Login_Advertising_Title";
  static String get nameMobileAppAdminLoginAdvertisingDescription =>
      "MobileApp_Admin_Login_Advertising_Description";

  static String get nameMobileAppAdminLoginDescription =>
      "MobileApp_Admin_Login_Description";
  static String get nameDeleteCart => "Cart_DeleteCart";

  static String get nameDealerLocatorLocationSearchLabel =>
      "DealerLocator_LocationSearchLabel";
  static String get nameDealerLocatorNoResultsMessage =>
      "DealerLocator_NoResultsMessage";
  static String get nameInvoiceNoResultsMessage =>
      "InvoiceHistory_NoInvoiceHistoryMessage";
  static String get nameSavedPaymentsNoResultsMessage =>
      "SavedPayments_NoSavedPaymentsMessage";

  static String get nameOrderApprovalBadRequest => "OrderApproval_BadRequest";

  static String get jobQuoteNotFoundMessage => "Rfq_NoJobsMessage";
  static String get quoteNotFoundMessage => "Rfq_NoQuotesMessage";
  static String get jobNameRequiredMessage => "Rfq_Job_Name_required";
  static String get orderApprovalRequiresQuoteMessage =>
      "OrderApproval_RequiresQuoteMessage";
  static String get emptyQuoteMessage => "Rfq_EmptyQuoteMessage";
  static String get nameQuoteLineNotFound => "Rfq_QuoteLine_NotFound";
  static String get nameQuoteMessageNotFound => "Rfq_NoQuotesMessage";
  static String get nameDeleteQuoteConfirmation =>
      "Rfq_DeleteQuoteConfirmation";
  static String get nameRfqNoExpirationDate => "Rfq_NoExpirationDate";
  static String get nameRfqPastExpirationDate => "Rfq_PastExpirationDate";
  static String get nameRfqUserIsRequired => "Rfq_UserIsRequired";

  static String get nameAddressInfoNameRequired => "AddressInfo_Name_Required";
  static String get nameAddressInfoEmailAddressRequired =>
      "AddressInfo_EmailAddress_Required ";
  static String get nameAddressInfoAddressOneRequired =>
      "AddressInfo_AddressOne_Required";
  static String get nameAddressInfoCountryRequired =>
      "AddressInfo_Country_Required ";
  static String get nameAddressInfoCityRequired => "AddressInfo_City_Required ";
  static String get nameAddressInfoStateRequired =>
      "AddressInfo_State_Required";
  static String get nameAddressInfoZipRequired => "AddressInfo_Zip_Required";
  static String get nameRfqQuoteOrderHeader => "Rfq_QuoteOrderHeader";
  static String get nameRequisitionConfirmationSuccessMessage =>
      "Requisition_Submitted";
  static String get nameReviewAndPayNotEnoughInventoryInLocalWarehouse =>
      "ReviewAndPay_NotEnoughInventoryInLocalWarehouse";

  static String get vMINotFoundMessage => "nameVMINotFoundMessage";

  // defaul values
  static String get defaultValueAddToCartSuccess => "Product Added to Cart";
  static String get defaultValueAddToCartFail => "Error Adding to Cart";
  static String get defaultValueAddToCartAllProductsSuccess =>
      "Item(s) added to cart";
  static String get defaultValueAddToCartAllProductsFromList =>
      "The requested products have been added to your cart.";
  static String get defaultValueAddToCartQuantityAdjusted =>
      "The quantity added to the cart was changed due to rounding or minimum quantity rules.";
  static String get defaultValueCartProductCannotBePurchased =>
      "Due to business rules some of the products in your cart cannot be purchased. Please contact support for more information or remove the products to proceed.";
  static String get defaultValueCartPromotionItem =>
      "This is a promotional item";
  static String get defaultValueCartNoPriceAvailableAtCheckout =>
      "Pricing not currently available - please save the order and try again later.";
  static String get defaultValueNoOrderLines =>
      "There are no items in your cart.";
  static String get defaultValueTooManyQtyRequested =>
      "{0:0} of {1:0} requested items are in stock.";
  static String get defaultValuePCIRequestErrorDefault =>
      "We are unable to process cards at this time. Please try again in a few minutes.";
  static String get defaultValueWishListNoProducts =>
      "Start adding items to your list.";
  static String get defaultValueWishListInviteIsNotAvailable =>
      "This list is no longer available. Please contact the list owner.";
  static String get defaultValueWishListItemsDiscontinuedAndRemoved =>
      "item(s) have been discontinued and removed from the list.";
  static String get defaultValueWishListItemsNotDisplayedDueRestrictions =>
      "item(s) could not be displayed due to product restrictions.";
  static String get defaultValueWishListNoListsFound =>
      "You do not have any lists.";
  static String get defaultValueWishListNameRequired => "List Name is required";
  static String get defaultValueWishListProductAdded =>
      "Product successfully added to your list.";
  static String get defaultValueRealTimePricingLoadFail =>
      "Price Not Available";
  static String get defaultValueRealTimeInventoryLoadFail =>
      "Inventory Not Available";
  static String get defaultValuePricingZeroPriceMessage => "Call For Pricing";
  static String get defaultValuePricingSignInForPrice => "";
  static String get defaultValueQuickOrderInstructions =>
      "To add an item to your quick order form, search by keyword or item # then click on the item.";
  static String get defaultValueProductNotFound => "Products not found";
  static String get defaultValueProductOutOfStock =>
      "There are product(s) out of stock";
  static String get defaultValueProductDiscontinued =>
      "There are {0} item(s) on this list have been discontinued. Would you like to remove the items from the list?";

  static String get defaultValueBrandLoadFail => "Brand Not Available";

  static String get defaultValueCreditCardInfoCardNumberInvalid =>
      "Credit card number is invalid.";
  static String get defaultValueCreditCardInfoCardNumberRequired =>
      "Credit card number is required.";
  static String get defaultValueCreditCardInfoCardHolderNameRequired =>
      "Cardholder name is required.";
  static String get defaultValueCreditCardInfoSecurityCodeInvalid =>
      "Security code is invalid.";
  static String get defaultValueCreditCardInfoSecurityCodeRequired =>
      "Security code is required.";
  static String get defaultValueCreditCardInfoExpirationDateInvalid =>
      "Expiration date is invalid.";
  static String get defaultValueCreditCardInfoExpirationDateRequired =>
      "Expiration date is required.";
  static String get defaultValueCreditCardInfoExpirationMonthRequired =>
      "Expiration month is required.";
  static String get defaultValueCreditCardInfoExpirationYearRequired =>
      "Expiration year is required.";

  static String get defaultValueAddressNameRequired => "Name is required.";
  static String get defaultValueAddressRequired => "Address is required.";
  static String get defaultValueAddressAddressOneRequired =>
      "Address One is required.";
  static String get defaultValueAddressCountryRequired =>
      "Country is required.";
  static String get defaultValueAddressCityRequired => "City is required.";
  static String get defaultValueAddressStateRequired => "State is required.";
  static String get defaultValueAddressZipRequired => "Zip is required.";
  static String get defaultValueAddressEmailRequired =>
      "Email Address is required.";
  static String get defaultValueAddressEmailInvalid =>
      "Email Address is invalid.";

  static String get defaultValueDefaultCustomerSetFail =>
      "Failed setting default customer.";

  static String? get defaultCartLineBackfillMessage => null;
  static String get defaultValueQuickOrderCannotOrderConfigurable =>
      "Cannot quick order configurable products.";
  static String get defaultValueQuickOrderCannotOrderStyled =>
      "Product requires styling.";
  static String get defaultValueQuickOrderCannotOrderUnavailable =>
      "Product is unavailable.";

  static String get defaultValueCheckoutRequestedDeliveryDateMessage =>
      "This date is only a request and may not be fulfilled.";
  static String get defaultValueCheckoutRequestedPickUpDateMessage =>
      "Please be aware that this date is a request and cannot be guaranteed.";
  static String get defaultValueCheckoutPaymentProfileExpiredMessage =>
      "Card expired. Update information or choose a different card.";

  static String get defalutMobileAppAccountUnauthenticatedDescription =>
      "To view previous orders, lists, and other features, please sign in to your account.";
  static String get defaultMobileAppOrderConfirmationSuccessMessage =>
      "Your order has been placed. Thank you.";
  static String get defaultMobileAppSearchNoResults =>
      "Your search returned no results.";
  static String get defaultMobileAppLaunchAppDescription =>
      "This app enables Optimizely customers to easily access their B2B Commerce application.\n\nIf you’re new to Optimizely and would like access to the mobile app version of your storefront, visit our website.\n\nSign in below if you are an existing customer.";
  static String get defaultMobileAppSelectDomainDescription =>
      "Enter Store URL";
  static String get defaultCartInsufficientInventoryAtCheckout =>
      "Some of the item quantities in your cart are low in stock. Please adjust quantities before proceeding to checkout.";
  static String get defaultCartInsufficientPickupInventory =>
      "Please review the items not available for pick up.";
  static String get defaultMobileAppSignInAgreement =>
      "By logging in, you agree to the {0} and {1}";

  static String get defaultMobileAppAlertNoInternet => "No Internet Connection";
  static String get defaultMobileAppAlertNoInternetDescription =>
      "Please connect to a wifi network or a mobile data connection to continue.";
  static String get defaultMobileAppAlertCameraAcessDenied =>
      "Access to camera has been denied. Please go to settings to enable access.";
  static String get defaultMobileAppAlertCommunicationError =>
      "There was an error communicating with the server.";

  static String get defaultMobileAppNoWarehousesError =>
      "No warehouses available.";

  static String get defaultMobileAppAdminLoginAdvertisingTitle =>
      "Welcome to your test enviroment";
  static String get defaultMobileAppAdminLoginAdvertisingDescription =>
      "Looks like you're testing out your new mobile app!\n\nUse this app to preview how your storefront will behave inside a dedicated mobile app.\n\nAlso, admins can preview their live changes made in the CMS by enabling CMS preview mode.";

  static String get defaultMobileAppAdminLoginDescription =>
      "Use your commerce admin login here to preview changes made in their mobile CMS.";
  static String get defaultValueDeleteCartFail => "Failed to delete Cart";

  static String get defaultDealerLocatorLocationSearchLabel =>
      "Zip/Postal Code or City, State/Province or Country:";
  static String get defaultDealerLocatorNoResultsMessage =>
      "No results found, please search again.";
  static String get defaultSavedPaymentNoResultsMessage =>
      "There are no saved payments.";
  static String get defaultInvoiceNoResultsMessage => "There are no invoice.";
  static String get emailFromRequired => "Email From is required.";
  static String get emailToRequired => "Email To is required.";

  static String get defaultNoQuotesFoundMessage => "No quotes found";
  static String get defaultNoJobQuotesFoundMessage => "No jobs found";
  static String get defaultJobNameRequiredMessage =>
      "Job Name is required to create a Quote.";
  static String get defaultOrderApprovalRequiresQuoteMessage =>
      "Items in your cart require quotes and cannot be submitted for approval. Quoted items will stay in your cart until your order approval has been submitted.";
  static String get defaultValueQuoteLineNotFound =>
      "The quote line requested cannot be found.";
  static String get defaultMobileAppEmptyQuoteMessage =>
      "There are currently no items in your quote.";
  static String get defaultValueQuoteMessageNotFound =>
      "The quote message cannot be found.";
  static String get defaultDeleteQuoteConfirmation =>
      "Are you sure you want to delete this quote?";
  static String get defaultValueRfqNoExpirationDate =>
      "Please enter an expiration date.";
  static String get defaultValueRfqPastExpirationDate =>
      "Expiration date is in the past, are you sure you want to submit the quote?";
  static String get defaultValueRfqUserIsRequired =>
      "User is required to create a Quote.";
  static String get defaultValueRfqQuoteOrderHeader =>
      "This quote will replace any item quotes you may have already priced.";
  static String get defaultRequisitionConfirmationSuccessMessage =>
      "Your requisition has been submitted for approval";
  static String get defaultReviewAndPayNotEnoughInventoryInLocalWarehouse =>
      "Your order contains one or more items on backorder. For the delivery of back-ordered items, please allow 3 to 5 business days. Your branch representative will contact you when back ordered items are ready.";

  static String get defaultNoVMIFoundMessage => "No VMI found";
  static String get defaultVaLueOrderApprovalBadRequest =>
      "There was a problem finding this order approval.";
  static String get defaultVaLueOrderApprovalOrderPlaced =>
      "Your order has been submitted for approval.\nThank you.";

  static String get defaultAllProductCountExceed => 
      "Products cannot be reordered, counts meet or exceed their max quantities.";
  static String get defaultSomeProductCountExceed => 
      "Some products not been added to checkout as they exceed max qty count.";

  // values
  static String valueRealTimePricingLoadFail =
      defaultValueRealTimePricingLoadFail;
  static String valueRealTimeInventoryLoadFail =
      defaultValueRealTimeInventoryLoadFail;
  static String valuePricingZeroPriceMessage =
      defaultValuePricingZeroPriceMessage;
  static String valuePricingSignInForPrice = defaultValuePricingSignInForPrice;

  static void resetSiteMessageValues() {
    valueRealTimePricingLoadFail = defaultValueRealTimePricingLoadFail;
    valueRealTimeInventoryLoadFail = defaultValueRealTimeInventoryLoadFail;
    valuePricingZeroPriceMessage = defaultValuePricingZeroPriceMessage;
    valuePricingSignInForPrice = defaultValuePricingSignInForPrice;
  }
}
