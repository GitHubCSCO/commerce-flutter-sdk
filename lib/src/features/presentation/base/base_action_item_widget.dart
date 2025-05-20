import 'package:commerce_flutter_sdk/src/core/config/log_config.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/website_paths.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/location_search_type.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseActionItemWidget {
  String getActionIconPath(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return AssetConstants.categoriesIcon;
      case ActionType.brands:
        return AssetConstants.brandsIcon;
      case ActionType.quickOrder:
        return AssetConstants.quickOrderIcon;
      case ActionType.orderHistory:
        return AssetConstants.orderHistoryIcon;
      case ActionType.lists:
        return AssetConstants.listsIcon;
      case ActionType.locationFinder:
        return AssetConstants.locationFinderIcon;
      case ActionType.settings:
        return AssetConstants.settingsIcon;
      case ActionType.changeCustomer:
        return AssetConstants.changeCustomerIcon;
      case ActionType.signOut:
        return AssetConstants.signOutIcon;
      case ActionType.viewAccountOnWebsite:
        return AssetConstants.viewAccountIcon;
      case ActionType.search:
        return AssetConstants.actionSearchIcon;
      case ActionType.savedOrders:
        return AssetConstants.savedOrdersIcon;
      case ActionType.orderApproval:
        return AssetConstants.orderApprovalIcon;
      case ActionType.invoices:
        return AssetConstants.invoicesIcon;
      case ActionType.savedPayments:
        return AssetConstants.savedPaymentsIcon;
      case ActionType.vmi:
        return AssetConstants.vmiIcon;
      case ActionType.quotes:
        return AssetConstants.quotesIcon;
      case ActionType.showHidePricing:
        return AssetConstants.showHidePricingIcon;
      case ActionType.showHideInventory:
        return AssetConstants.showHideInventoryIcon;
      default:
        return AssetConstants.viewAccountIcon;
    }
  }

  String getActionTitle(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return LocalizationConstants.shopCategories.localized();
      case ActionType.brands:
        return LocalizationConstants.shopBrands.localized();
      case ActionType.quickOrder:
        return LocalizationConstants.quickOrder.localized();
      case ActionType.orderHistory:
        return LocalizationConstants.orders.localized();
      case ActionType.showHidePricing:
        return LocalizationConstants.showHidePricing.localized();
      case ActionType.showHideInventory:
        return LocalizationConstants.showHideInventory.localized();
      case ActionType.orderApproval:
        return LocalizationConstants.orderApproval.localized();
      case ActionType.lists:
        return LocalizationConstants.lists.localized();
      case ActionType.savedOrders:
        return LocalizationConstants.savedOrders.localized();
      case ActionType.locationFinder:
        return LocalizationConstants.locationFinder.localized();
      case ActionType.settings:
        return LocalizationConstants.settings.localized();
      case ActionType.changeCustomer:
        // return this.hasWillCall ? LocalizationConstants.ChangeCustomerWillCall.localized() : LocalizationConstants.ChangeCustomer.localized();
        return LocalizationConstants.changeCustomerWillCall.localized();
      case ActionType.signOut:
        return LocalizationConstants.signOut.localized();
      case ActionType.viewAccountOnWebsite:
        return LocalizationConstants.viewAccountOnWebsite.localized();
      case ActionType.search:
        return LocalizationConstants.search.localized();
      case ActionType.forceCrash:
        return "Force Crash";
      case ActionType.toggleLogging:
        return LogConfig.isAllLogsEnabled
            ? "Disable logging"
            : "Enable logging";
      case ActionType.invoices:
        return LocalizationConstants.invoiceHistory.localized();
      case ActionType.savedPayments:
        return LocalizationConstants.mySavedPayments.localized();
      case ActionType.quotes:
        return LocalizationConstants.myQuotes.localized();
      case ActionType.vmi:
        return LocalizationConstants.vendorManagedInventory.localized();
      case ActionType.countInventory:
        return LocalizationConstants.countInventory.localized();
      case ActionType.createOrder:
        return LocalizationConstants.createOrder.localized();
      case ActionType.custom:
        return actionLink.text!;
      case ActionType.unknown:
      default:
        return actionLink.text ?? "";
    }
  }

  Function() onActionNavigationCommand(
      BuildContext context, ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.signOut:
        return () {
          signOut(context);
        };
      case ActionType.settings:
        return () {
          AppRoute.settings.navigateBackStack(context);
        };
      case ActionType.orderHistory:
        return () {
          AppRoute.orderHistory.navigateBackStack(context);
        };
      case ActionType.quickOrder:
        return () {
          AppRoute.quickOrder.navigateBackStack(context);
        };
      case ActionType.createOrder:
        return () {
          AppRoute.createOrder.navigateBackStack(context);
        };
      case ActionType.countInventory:
        return () {
          AppRoute.countOrder.navigateBackStack(context);
        };
      case ActionType.lists:
        return () {
          AppRoute.wishlist.navigateBackStack(context);
        };
      case ActionType.vmi:
        return () {
          AppRoute.vmi.navigateBackStack(context);
        };
      case ActionType.categories:
        return () {
          AppRoute.shopCategory.navigateBackStack(context);
        };
      case ActionType.brands:
        return () {
          AppRoute.shopBrand.navigateBackStack(context);
        };
      case ActionType.locationFinder:
        return () {
          AppRoute.locationSearch.navigateBackStack(context,
              extra: const VMILocationSelectCallbackHelper(
                  locationSearchType: LocationSearchType.locationFinder));
        };
      case ActionType.changeCustomer:
        return () {
          AppRoute.billToShipToChange.navigateBackStack(context);
        };
      case ActionType.savedOrders:
        return () {
          AppRoute.savedOrders.navigateBackStack(context);
        };
      case ActionType.savedPayments:
        return () {
          AppRoute.savedPayments.navigateBackStack(context);
        };
      case ActionType.orderApproval:
        return () {
          AppRoute.orderApproval.navigateBackStack(context);
        };
      case ActionType.custom:
        return () {
          context
              .read<LoadWebsiteUrlBloc>()
              .add(LoadCustomUrlLoadEvent(customUrl: actionLink.url));
        };
      case ActionType.invoices:
        return () {
          AppRoute.invoiceHistory.navigateBackStack(context);
        };
      case ActionType.viewAccountOnWebsite:
        return () {
          context.read<LoadWebsiteUrlBloc>().add(LoadWebsiteUrlLoadEvent(
              redirectUrl: WebsitePaths.accountWebsitePath,
              isloadInAppBrowser: true));
        };
      case ActionType.quotes:
        return () {
          AppRoute.myQuote.navigateBackStack(context);
        };
      case ActionType.search:
        return () {
          AppRoute.search.navigate(context);
        };
      default:
        return () {
          CustomSnackBar.showComingSoonSnackBar(context);
        };
    }
  }

  void signOut(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: LocalizationConstants.signOut.localized(),
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(LocalizationConstants.cancel.localized()),
          ),
          DialogPlainButton(
            onPressed: () {
              context.read<LogoutCubit>().logout().catchError((e) {
                FlutterError.reportError(e);
              });
              Navigator.of(context).pop();
            },
            child: Text(LocalizationConstants.oK.localized()),
          ),
        ]);
  }
}
