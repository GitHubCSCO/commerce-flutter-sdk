import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/features/domain/entity/biometric_info_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_app/features/domain/enums/scanning_mode.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/credit_card_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/shipping_address_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_note_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/wish_list_callback_helpers.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/navigation_node.dart';
import 'package:commerce_flutter_app/features/presentation/helper/routing/route_generator.dart';
import 'package:commerce_flutter_app/features/presentation/saved_order_details/saved_order_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/account/account_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/biometric/biometric_login_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/sub_category_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/checkout_success_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/vmi_checkout/vmi_checkout_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/location_seach/location_serach_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/login/forgot_password_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quick_order/count_inventory/count_input_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/order_details/order_details_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/saved_order/saved_order_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/saved_payments/saved_payments_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/search/barcode_search_screen.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');

GoRouter getRouter() {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: AppRoute.root.fullPath,
    debugLogDiagnostics: true,
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
        product: state.extra as ProductEntity),
    parent: shop,
  );

  final topLevelProductDetails = createNode(
    name: AppRoute.topLevelProductDetails.name,
    path: AppRoute.topLevelProductDetails.fullPath,
    builder: (context, state) => ProductDetailsScreen(
        productId: state.pathParameters['productId'] ?? '',
        product: state.extra as ProductEntity),
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
    builder: (context, state) => const OrderHistoryScreen(),
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

      return LocationSearchScreen(
        onVMILocationUpdated: onVMILocationUpdated,
        locationSearchType: callbackHelper.locationSearchType,
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
      final callbackHelper = state.extra as WishListScreenCallbackHelper;

      return WishListDetailsScreen(
        wishListId: wishListId,
        onWishListUpdated: callbackHelper.onWishListUpdated,
        onWishListDeleted: callbackHelper.onWishListDeleted,
      );
    },
    parent: wishlists,
  );

  final wishListInfo = createNode(
    name: AppRoute.wishListInfo.name,
    path: AppRoute.wishListInfo.suffix,
    builder: (context, state) {
      final callbackHelper = state.extra as WishListInfoScreenCallbackHelper;

      final wishList = callbackHelper.wishList;
      final onWishListUpdated = callbackHelper.onWishListUpdated;

      return WishListInformationScreen(
        wishList: wishList,
        onWishListUpdated: onWishListUpdated,
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
        onWishListCreated: callbackHelper.onWishListCreated,
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
        onWishListUpdated: callbackHelper.onWishListUpdated,
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
      return OrderDetailsScreen(orderNumber: orderNumber);
    },
    parent: orderHistory,
  );

  // path: /shopCategory
  final shopCategory = createNode(
    name: AppRoute.shopCategory.name,
    path: AppRoute.shopCategory.suffix,
    builder: (context, state) => const CategoryScreen(),
    parent: null,
  );

  final shopSubCatagory = createNode(
    name: AppRoute.shopSubCategory.name,
    path: AppRoute.shopSubCategory.fullPath,
    builder: (context, state) {
      final categoryId = state.pathParameters['categoryId'];
      final categoryTitle = state.pathParameters['categoryTitle'] ?? '';
      return SubCategoryScreen(categoryId: categoryId, categoryTitle: categoryTitle);
    },
    parent: null,
  );

  // path: /product
  final product = createNode(
    name: AppRoute.product.name,
    path: AppRoute.product.suffix,
    builder: (context, state) {
      final entity = state.extra as ProductPageEntity;
      return ProductScreen(pageEntity: entity);
    },
    parent: null
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
      final refreshSavedOrders = state.extra as void Function();
      return SavedOrderDetailsScreen(
          cartId: cartId, refreshSavedOrders: refreshSavedOrders);
    },
    parent: savedOrders,
  );

  return [
    root,
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
    shopCategory,
    shopSubCatagory,
    product,
    topLevelProductDetails,
    addCreditCard,
    addShippingAddress
  ];
}
