import 'dart:convert';

import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/models/screen_parameters.dart';
import 'package:commerce_flutter_app/features/domain/entity/biometric_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/credit_card_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/shipping_address_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_note_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/navigation_node.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/route_generator.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_category_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_product_lines_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/invoice_history/invoice_detail_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/invoice_history/invoice_email_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/invoice_history/invoice_history_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/landing/landing_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/language/language_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_approval/order_approval_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/job_quote_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_all_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_communication_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_confirmation_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_line_notes_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_pricing_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/request_quote_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/saved_order/saved_order_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_change_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/biometric/biometric_login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/sub_category_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/vmi_checkout/vmi_checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/location_seach/location_serach_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/forgot_password_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_approval/order_approval_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/count_inventory/count_input_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_details/order_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/saved_order/saved_order_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/saved_payments/saved_payments_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/barcode_search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/selection/sales_rep_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/selection/user_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_location_note.dart';
import 'package:commerce_flutter_app/features/presentation/screens/vmi/vmi_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/add_to_wish_list_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_create_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/nav_bar/nav_bar_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_history/order_history_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product_details/product_details.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/quick_order_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/root/root_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/search_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/settings/settings_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/shop/shop_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/domain_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_details/wish_list_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_shipping_address_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/selection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

GoRouter getRouter({required OptiLoggerService loggerService}) {
  return GoRouter(
    extraCodec: const RoutingCodec(),
    navigatorKey: _rootNavigator,
    initialLocation: AppRoute.root.fullPath,
    debugLogDiagnostics: loggerService.isDebugLogEnabled,
    routes: _getNavigationRoot().map((e) => generateRoutes(e)).toList(),
  );
}

List<NavigationNode> _getNavigationRoot() {
  // path: /
  final root = createNode(
    path: AppRoute.root.fullPath,
    name: AppRoute.root.name,
    builder: (context, state) => const RootScreen(),
  );

  // path: /landing
  final landing = createNode(
    name: AppRoute.landing.name,
    path: AppRoute.landing.suffix,
    builder: (context, state) {
      final domainChangePossible = state.extra as bool?;
      return LandingScreen(domainChangePossible: domainChangePossible == true);
    },
    parent: null,
  );

  // path: /welcome
  final welcome = createNode(
    name: AppRoute.welcome.name,
    path: AppRoute.welcome.suffix,
    builder: (context, state) => const WelcomeScreen(),
  );

  // path: /domainSelection
  final domainSelection = createNode(
    name: AppRoute.domainSelection.name,
    path: AppRoute.domainSelection.suffix,
    builder: (context, state) => const DomainScreen(),
  );

  // path: /login
  final login = createSeparateRoute(
    name: AppRoute.login.name,
    path: AppRoute.login.suffix,
    builder: (context, state) => const LoginScreen(),
    navigatorKey: _rootNavigator,
    parent: null,
  );

  final navbarRoot = createNavbarRoot(
    statefulShellBuilder: (context, state, navigationShell) => NavBarScreen(
      navigationShell: navigationShell,
    ),
    parent: null,
  );

  // path: /shop
  final shop = createNode(
    name: AppRoute.shop.name,
    path: AppRoute.shop.suffix,
    builder: (context, state) => const ShopScreen(),
    parent: navbarRoot,
  );

  // path: /search
  final search = createNode(
    name: AppRoute.search.name,
    path: AppRoute.search.suffix,
    builder: (context, state) => const SearchScreen(),
    parent: navbarRoot,
  );

  // path: /account
  final account = createNode(
    name: AppRoute.account.name,
    path: AppRoute.account.suffix,
    builder: (context, state) => const AccountScreen(),
    parent: navbarRoot,
  );

  // path: /cart
  final cart = createNode(
    name: AppRoute.cart.name,
    path: AppRoute.cart.suffix,
    builder: (context, state) => const CartScreen(),
    parent: navbarRoot,
  );

  // path: /checkout
  final checkout = createNode(
    name: AppRoute.checkout.name,
    path: AppRoute.checkout.suffix,
    builder: (context, state) {
      final cart = state.extra as Cart;
      return CheckoutScreen(cart: cart);
    },
    parent: null,
  );

  // path: /vmiCheckout
  final vmiCheckout = createNode(
    name: AppRoute.vmiCheckout.name,
    path: AppRoute.vmiCheckout.suffix,
    builder: (context, state) {
      final vmiCheckoutEntity = state.extra as VmiCheckoutEntity;
      return VmiCheckoutScreen(vmiCheckoutEntity: vmiCheckoutEntity);
    },
    parent: null,
  );

  // path: /addCreditCard
  final addCreditCard = createNode(
    name: AppRoute.addCreditCard.name,
    path: AppRoute.addCreditCard.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as CreditCardAddCallbackHelper;

      final onCreaditCardAdded = callbackHelper.onAddedCeditCard;
      final addCreditCardEntity = callbackHelper.addCreditCardEntity;
      final onCreditCardDeleted = callbackHelper.onDeletedCreditCard;

      return AddCreditCardScreen(
        onCreditCardAdded: onCreaditCardAdded,
        addCreditCardEntity: addCreditCardEntity,
        onCreditCardDeleted: onCreditCardDeleted,
      );
    },
    parent: null,
  );

  // path: /addShippingAddress
  final addShippingAddress = createNode(
    name: AppRoute.addShippingAddress.name,
    path: AppRoute.addShippingAddress.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as ShippingAddressAddCallbackHelper;

      final onShippingAddressAdded = callbackHelper.onShippingAddressAdded;

      return AddShippingAddressScreen(
          onShippingAddressAdded: onShippingAddressAdded);
    },
    parent: null,
  );

  // path: /savedPayments
  final savedPayments = createNode(
    name: AppRoute.savedPayments.name,
    path: AppRoute.savedPayments.suffix,
    builder: (context, state) {
      return SavedPaymentsScreen();
    },
    parent: account,
  );

  // path: /checkoutSuccess
  final checkoutSuccess = createNode(
    name: AppRoute.checkoutSuccess.name,
    path: AppRoute.checkoutSuccess.suffix,
    builder: (_, state) {
      final checkoutSuccessEntity = state.extra as CheckoutSuccessEntity;
      return CheckoutSuccessScreen(
          checkoutSuccessEntity: checkoutSuccessEntity);
    },
    parent: null,
  );

  // path: /product details
  final productDetails = createNode(
    name: AppRoute.productDetails.name,
    path: AppRoute.productDetails.suffix,
    builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters['productId'] ?? '',
        product: state.extra as ProductEntity?),
    parent: shop,
  );

  final topLevelProductDetails = createNode(
    name: AppRoute.topLevelProductDetails.name,
    path: AppRoute.topLevelProductDetails.fullPath,
    builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters['productId'] ?? '',
        product: state.extra as ProductEntity?),
    parent: null,
  );

  // path: /account/settings
  final settings = createNode(
    name: AppRoute.settings.name,
    path: AppRoute.settings.suffix,
    builder: (context, state) => const SettingsScreen(),
    parent: account,
  );

  // path: /biometric
  final biometricLogin = createNode(
    name: AppRoute.biometricLogin.name,
    path: AppRoute.biometricLogin.suffix,
    builder: (context, state) {
      final biometricInfo = state.extra as BiometricInfoEntity;
      return BiometricLoginScreen(
        biometricOption: biometricInfo.biometricOption,
        password: biometricInfo.password,
      );
    },
    parent: null,
  );

  // path: /account/orderHistory
  final orderHistory = createNode(
    name: AppRoute.orderHistory.name,
    path: AppRoute.orderHistory.suffix,
    builder: (context, state) => OrderHistoryScreen(),
    parent: account,
  );

  // path: /quickOrder
  final quickOrder = createNode(
    name: AppRoute.quickOrder.name,
    path: AppRoute.quickOrder.suffix,
    builder: (context, state) =>
        const QuickOrderScreen(scanningMode: ScanningMode.quick),
    parent: null,
  );

  // path: /createOrder
  final createOrder = createNode(
    name: AppRoute.createOrder.name,
    path: AppRoute.createOrder.suffix,
    builder: (context, state) =>
        const QuickOrderScreen(scanningMode: ScanningMode.create),
    parent: null,
  );

  // path: /countOrder
  final countOrder = createNode(
    name: AppRoute.countOrder.name,
    path: AppRoute.countOrder.suffix,
    builder: (context, state) =>
        const QuickOrderScreen(scanningMode: ScanningMode.count),
    parent: null,
  );

  // path: /countInventory
  final countInventory = createNode(
    name: AppRoute.countInventory.name,
    path: AppRoute.countInventory.suffix,
    builder: (context, state) {
      final countInventoryEntity = state.extra as CountInventoryEntity;
      return CountInventoryScreen(countInventoryEntity: countInventoryEntity);
    },
    parent: null,
  );

  // path: /account/vmi
  final vmi = createNode(
    name: AppRoute.vmi.name,
    path: AppRoute.vmi.suffix,
    builder: (context, state) => const VMIScreen(),
    parent: account,
  );

  // path: /account/vmi/vmiOrderHistory
  final vmiOrderHistory = createNode(
    name: AppRoute.vmiOrderHistory.name,
    path: AppRoute.vmiOrderHistory.suffix,
    builder: (context, state) => OrderHistoryScreen(isFromVMI: true),
    parent: vmi,
  );

  // path: /login
  final vmiLocationNote = createSeparateRoute(
    name: AppRoute.vmilocaitonote.name,
    path: AppRoute.vmilocaitonote.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as VMILocationNoteCallbackHelper;

      final onVMILocationNoteUpdated = callbackHelper.onUpdateVMILocationNote;

      return VmiLocationNoteScreen(
        onVMILocationNoteUpdated: onVMILocationNoteUpdated,
      );
    },
    navigatorKey: _rootNavigator,
    parent: null,
  );

  // path: /barcodeSearch
  final barcodeSearch = createNode(
    name: AppRoute.barcodeSearch.name,
    path: AppRoute.barcodeSearch.suffix,
    builder: (context, state) => const BarcodeSearchScreen(),
    parent: null,
  );

  // path: /account/wishlist
  final wishlists = createNode(
    name: AppRoute.wishlist.name,
    path: AppRoute.wishlist.suffix,
    builder: (context, state) => const WishListsScreen(),
    parent: account,
  );

  // path: /locationsearch
  final locationSearch = createNode(
    name: AppRoute.locationSearch.name,
    path: AppRoute.locationSearch.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as VMILocationSelectCallbackHelper;

      final onVMILocationUpdated = callbackHelper.onSelectVMILocation;
      final onWarehouseLocationSelected =
          callbackHelper.onWarehouseLocationSelected;
      final WarehouseEntity? selectedPickupWarehouse =
          callbackHelper.selectedPickupWarehouse;

      return LocationSearchScreen(
        onVMILocationUpdated: onVMILocationUpdated,
        locationSearchType: callbackHelper.locationSearchType,
        onWarehouseLocationSelected: onWarehouseLocationSelected,
        selectedPickupWarehouse: selectedPickupWarehouse,
      );
    },
    parent: null,
  );
  // path: /account/wishlist/:id
  final wishlistsDetails = createNode(
    name: AppRoute.wishlistsDetails.name,
    path: AppRoute.wishlistsDetails.suffix,
    builder: (context, state) {
      final wishListId = state.pathParameters['id'] ?? '';

      return WishListDetailsScreen(
        wishListId: wishListId,
      );
    },
    parent: wishlists,
  );

  final wishListInfo = createNode(
    name: AppRoute.wishListInfo.name,
    path: AppRoute.wishListInfo.suffix,
    builder: (context, state) {
      final wishList = state.extra as WishListEntity?;

      return WishListInformationScreen(
        wishList: wishList!,
      );
    },
    parent: null,
  );

  final wishListCreate = createNode(
    name: AppRoute.wishListCreate.name,
    path: AppRoute.wishListCreate.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as WishListCreateScreenCallbackHelper;

      return WishListCreateScreen(
        addToCartCollection: callbackHelper.addToCartCollection,
      );
    },
    parent: null,
  );

  final addToWishList = createNode(
    name: AppRoute.addToWishList.name,
    path: AppRoute.addToWishList.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as WishListAddToListCallbackHelper;

      return AddToWishListScreen(
        addToCartCollection: callbackHelper.addToCartCollection,
      );
    },
    parent: null,
  );

  final forgotPassword = createNode(
    name: AppRoute.forgotPassword.name,
    path: AppRoute.forgotPassword.suffix,
    builder: (context, state) {
      final accountType = state.extra as AccountType;
      return ForgotPasswordScreen(accountType: accountType);
    },
    parent: null,
  );

  // path: /account/orderHistory/:orderNumber
  final orderDetails = createNode(
    name: AppRoute.orderDetails.name,
    path: AppRoute.orderDetails.suffix,
    builder: (context, state) {
      final orderNumber = state.pathParameters['orderNumber'] ?? '';
      final isFromVMI = state.extra as bool?;
      return OrderDetailsScreen(orderNumber: orderNumber, isFromVMI: isFromVMI);
    },
    parent: orderHistory,
  );

  // path: /account/orderHistory/:orderNumber
  final vmiOrderDetails = createNode(
    name: AppRoute.vmiOrderDetails.name,
    path: AppRoute.vmiOrderDetails.suffix,
    builder: (context, state) {
      final orderNumber = state.pathParameters['orderNumber'] ?? '';
      final isFromVMI = state.extra as bool?;
      return OrderDetailsScreen(orderNumber: orderNumber, isFromVMI: isFromVMI);
    },
    parent: vmi,
  );

  // path: /billToShipToChange
  final billToShipToChange = createNode(
    name: AppRoute.billToShipToChange.name,
    path: AppRoute.billToShipToChange.suffix,
    builder: (context, state) => const BillToShipToChangeScreen(),
    parent: null,
  );

  // path: /billToShipToSelection
  final billToShipToSelection = createNode(
    name: AppRoute.billToShipToSelection.name,
    path: AppRoute.billToShipToSelection.suffix,
    builder: (context, state) {
      final entity = state.extra as BillToShipToAddressSelectionEntity;
      return BillToShipToAddressSelectionScreen(
          billToShipToAddressSelectionEntity: entity);
    },
  );

  // path: /shopCategory
  final shopCategory = createNode(
    name: AppRoute.shopCategory.name,
    path: AppRoute.shopCategory.suffix,
    builder: (context, state) => const CategoryScreen(),
    parent: account,
  );

  final shopSubCatagory = createNode(
    name: AppRoute.shopSubCategory.name,
    path: AppRoute.shopSubCategory.fullPath,
    builder: (context, state) {
      final category = state.extra as Category;
      return SubCategoryScreen(
        category: category,
      );
    },
    parent: shopCategory,
  );

  // path: /shopBrand
  final shopBrand = createNode(
    name: AppRoute.shopBrand.name,
    path: AppRoute.shopBrand.suffix,
    builder: (context, state) => const BrandScreen(),
    parent: account,
  );

  // path: /shopBrandDetails
  final shopBrandDetails = createNode(
    name: AppRoute.shopBrandDetails.name,
    path: AppRoute.shopBrandDetails.suffix,
    builder: (context, state) {
      final brand = state.extra as Brand;
      return BrandDetailsScreen(brand: brand);
    },
    parent: shopBrand,
  );

  // path: /brandCategory
  final brandCategory = createNode(
    name: AppRoute.brandCategory.name,
    path: AppRoute.brandCategory.suffix,
    builder: (context, state) {
      final brandCategory = state.extra as BrandCategoryScreenParameters;
      return BrandCategoryScreen(
          brand: brandCategory.brand,
          brandCategory: brandCategory.brandCategory,
          brandSubCategories: brandCategory.brandSubCategoriesResult);
    },
    parent: shopBrandDetails,
  );

  // path: /brandProductLines
  final brandProductLines = createNode(
    name: AppRoute.brandProductLines.name,
    path: AppRoute.brandProductLines.suffix,
    builder: (context, state) {
      //! TODO caution
      final brand = state.extra as Brand;
      return BrandProductLinesScreen(brand: brand);
    },
    parent: shopBrandDetails,
  );

  // path: /product
  final product = createNode(
    name: AppRoute.product.name,
    path: AppRoute.product.fullPath,
    builder: (_, state) {
      final entity = state.extra as ProductPageEntity;
      return ProductScreen(pageEntity: entity);
    },
    parent: brandCategory,
  );

  // path: /account/savedOrders
  final savedOrders = createNode(
    name: AppRoute.savedOrders.name,
    path: AppRoute.savedOrders.suffix,
    builder: (context, state) => const SavedOrderScreen(),
    parent: account,
  );

  // path: /account/savedOrders/:cartId
  final savedOrderDetails = createNode(
    name: AppRoute.savedOrderDetails.name,
    path: AppRoute.savedOrderDetails.suffix,
    builder: (context, state) {
      final cartId = state.pathParameters['cartId'] ?? '';
      return SavedOrderDetailsScreen(cartId: cartId);
    },
    parent: savedOrders,
  );

  // path: /account/myQuote
  final myQuote = createNode(
    name: AppRoute.myQuote.name,
    path: AppRoute.myQuote.suffix,
    builder: (context, state) => const QuoteScreen(),
    parent: account,
  );

  // path: /requestQuote
  final requestQuote = createNode(
    name: AppRoute.requestQuote.name,
    path: AppRoute.requestQuote.suffix,
    builder: (context, state) =>
        RequestQuoteWidgetScreen(cart: state.extra as Cart),
    parent: null,
  );

  // path: /quote Confirmation
  final quoteConfirmation = createNode(
    name: AppRoute.quoteConfirmation.name,
    path: AppRoute.quoteConfirmation.suffix,
    builder: (context, state) =>
        QuoteConfirmationScreen(quote: state.extra as QuoteDto),
    parent: null,
  );

  // path: /quote Details
  final quoteDetails = createNode(
    name: AppRoute.quoteDetails.name,
    path: AppRoute.quoteDetails.suffix,
    builder: (context, state) =>
        QuoteDetailsScreen(quoteDto: state.extra as QuoteDto),
    parent: null,
  );

  // path: /quote quoteCommunication
  final quoteCommunication = createNode(
    name: AppRoute.quoteCommunication.name,
    path: AppRoute.quoteCommunication.suffix,
    builder: (context, state) =>
        QuoteCommunicationScreen(quoteDto: state.extra as QuoteDto),
    parent: null,
  );

  // path: Quote All
  final quoteAll = createNode(
    name: AppRoute.quoteAll.name,
    path: AppRoute.quoteAll.suffix,
    builder: (context, state) =>
        QuoteAllScreen(quoteDto: state.extra as QuoteDto),
    parent: null,
  );

  // path: Quote Pricing
  final quotePricing = createNode(
    name: AppRoute.quotePricing.name,
    path: AppRoute.quotePricing.suffix,
    builder: (context, state) =>
        QuotePricingScreen(quoteLineEntity: state.extra as QuoteLineEntity),
    parent: null,
  );

  // path: /account/invoiceHistory
  final invoiceHistory = createNode(
    name: AppRoute.invoiceHistory.name,
    path: AppRoute.invoiceHistory.suffix,
    builder: (context, state) => const InvoiceHistoryScreen(),
    parent: account,
  );

  // path: /account/invoiceHistory/:invoiceNumber
  final invoiceDetail = createNode(
    name: AppRoute.invoiceDetail.name,
    path: AppRoute.invoiceDetail.suffix,
    builder: (context, state) {
      final invoiceNumber = state.pathParameters['invoiceNumber'] ?? '';
      return InvoiceDetailScreen(invoiceNumber: invoiceNumber);
    },
    parent: invoiceHistory,
  );

  final invoiceEmail = createNode(
    name: AppRoute.invoiceEmail.name,
    path: AppRoute.invoiceEmail.suffix,
    builder: (context, state) {
      final invoiceNumber = state.pathParameters['invoiceNumber'] ?? '';
      return InvoiceEmailScreen(invoiceNumber: invoiceNumber);
    },
    parent: invoiceDetail,
  );

  // path: /account/orderApproval
  final orderApproval = createNode(
    name: AppRoute.orderApproval.name,
    path: AppRoute.orderApproval.suffix,
    builder: (context, state) => const OrderApprovalScreen(),
    parent: account,
  );

  // path: /account/orderApproval/:cartId
  final orderApprovalDetails = createNode(
    name: AppRoute.orderApprovalDetails.name,
    path: AppRoute.orderApprovalDetails.suffix,
    builder: (context, state) {
      final cartId = state.pathParameters['cartId'] ?? '';
      return OrderApprovalDetailsScreen(cartId: cartId);
    },
    parent: orderApproval,
  );

  final userSelection = createNode(
    name: AppRoute.userSelection.name,
    path: AppRoute.userSelection.suffix,
    builder: (context, state) {
      final parameter = state.extra as CatalogTypeSelectingParameter;
      return UserSelectionScreen(parameter: parameter);
    },
    parent: null,
  );

  final salesRepSelection = createNode(
    name: AppRoute.salesRepSelection.name,
    path: AppRoute.salesRepSelection.suffix,
    builder: (context, state) {
      final parameter = state.extra as CatalogTypeSelectingParameter;
      return SalesRepSelectionScreen(parameter: parameter);
    },
    parent: null,
  );

  final jobQuoteDetails = createNode(
    name: AppRoute.jobQuoteDetails.name,
    path: AppRoute.jobQuoteDetails.suffix,
    builder: (context, state) {
      final jobQuoteId = state.pathParameters['jobQuoteId'] ?? '';
      return JobQuoteDetailsScreen(jobQuoteId: jobQuoteId);
    },
    parent: myQuote,
  );

  final quoteLineNotes = createNode(
    name: AppRoute.quoteLineNotes.name,
    path: AppRoute.quoteLineNotes.suffix,
    builder: (context, state) {
      final initialText = state.extra as String?;
      return QuoteLineNotesScreen(initialText: initialText);
    },
  );

  // path: /account/settings/language
  final language = createNode(
    name: AppRoute.language.name,
    path: AppRoute.language.suffix,
    builder: (context, state) => LanguageScreen(),
    parent: settings,
  );

  return [
    root,
    landing,
    navbarRoot,
    welcome,
    domainSelection,
    login,
    biometricLogin,
    checkout,
    vmiCheckout,
    checkoutSuccess,
    quickOrder,
    createOrder,
    countOrder,
    countInventory,
    barcodeSearch,
    wishListInfo,
    wishListCreate,
    addToWishList,
    forgotPassword,
    vmiLocationNote,
    locationSearch,
    billToShipToChange,
    billToShipToSelection,
    topLevelProductDetails,
    addCreditCard,
    addShippingAddress,
    requestQuote,
    quoteConfirmation,
    quoteDetails,
    quoteCommunication,
    quoteAll,
    quotePricing,
    userSelection,
    salesRepSelection,
    quoteLineNotes,
  ];
}

class RoutingCodec extends Codec<Object?, Object?> {
  const RoutingCodec();

  @override
  Converter<Object?, Object?> get decoder => const _RoutingDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _RoutingEncoder();
}

class _RoutingDecoder extends Converter<Object?, Object?> {
  const _RoutingDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }

    final inputAsList = input as List<Object?>;
    return inputAsList[1];
  }
}

class _RoutingEncoder extends Converter<Object?, Object?> {
  const _RoutingEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }

    return [input.runtimeType.toString(), input];
  }
}
