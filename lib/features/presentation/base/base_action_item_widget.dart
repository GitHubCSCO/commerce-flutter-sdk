import 'package:commerce_flutter_app/core/config/log_config.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/load_website_url/load_website_url_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseActionItemWidget {
  String getActionIconPath(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return "assets/images/icon_categories.svg";
      case ActionType.brands:
        return "assets/images/icon_brands.svg";
      case ActionType.quickOrder:
        return "assets/images/icon_quick_orders.svg";
      case ActionType.orderHistory:
        return "assets/images/icon_orders.svg";
      case ActionType.lists:
        return "assets/images/icon_lists.svg";
      case ActionType.locationFinder:
        return "assets/images/icon_store_finder.svg";
      case ActionType.settings:
        return "assets/images/icon_setting.svg";
      case ActionType.changeCustomer:
        return "assets/images/icon_delivery_method.svg";
      case ActionType.signOut:
        return "assets/images/icon_sign_out.svg";
      case ActionType.viewAccountOnWebsite:
        return "assets/images/icon_view_account.svg";
      case ActionType.search:
        return "assets/images/icon_search.svg";
      case ActionType.savedOrders:
        return "assets/images/icon_saved_order.svg";
      case ActionType.orderApproval:
        return "assets/images/icon_order_approval.svg";
      case ActionType.invoices:
        return "assets/images/icon_invoice_history.svg";
      case ActionType.savedPayments:
        return "assets/images/icon_saved_payments.svg";
      case ActionType.vmi:
        return "assets/images/icon_vmi.svg";
      case ActionType.quotes:
        return "assets/images/icon_quotes.svg";
      case ActionType.showHidePricing:
        return "assets/images/icon_hide_pricing.svg";
      case ActionType.showHideInventory:
        return "assets/images/icon_hide_inventory.svg";
      default:
        return "assets/images/icon_view_account.svg";
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
