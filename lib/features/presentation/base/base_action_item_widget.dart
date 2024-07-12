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

class BaseActionItemWidget extends StatelessWidget {
  const BaseActionItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

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
      default:
        return "assets/images/icon_view_account.svg";
    }
  }

  String getActionTitle(ActionLinkEntity actionLink) {
    switch (actionLink.type) {
      case ActionType.categories:
        return LocalizationConstants.shopCategories;
      case ActionType.brands:
        return LocalizationConstants.shopBrands;
      case ActionType.quickOrder:
        return LocalizationConstants.quickOrder;
      case ActionType.orderHistory:
        return LocalizationConstants.orders;
      case ActionType.showHidePricing:
        return LocalizationConstants.showHidePricing;
      case ActionType.showHideInventory:
        return LocalizationConstants.showHideInventory;
      case ActionType.orderApproval:
        return LocalizationConstants.orderApproval;
      case ActionType.lists:
        return LocalizationConstants.lists;
      case ActionType.savedOrders:
        return LocalizationConstants.savedOrders;
      case ActionType.locationFinder:
        return LocalizationConstants.locationFinder;
      case ActionType.settings:
        return LocalizationConstants.settings;
      case ActionType.changeCustomer:
        // return this.hasWillCall ? LocalizationConstants.ChangeCustomerWillCall : LocalizationConstants.ChangeCustomer;
        return LocalizationConstants.changeCustomerWillCall;
      case ActionType.signOut:
        return LocalizationConstants.signOut;
      case ActionType.viewAccountOnWebsite:
        return LocalizationConstants.viewAccountOnWebsite;
      case ActionType.search:
        return LocalizationConstants.search;
      case ActionType.forceCrash:
        return "Force Crash";
      case ActionType.toggleLogging:
      // return Logger.IsAllLogsEnabled ? "Disable logging" : "Enable logging";
      case ActionType.invoices:
        return LocalizationConstants.invoiceHistory;
      case ActionType.savedPayments:
        return LocalizationConstants.mySavedPayments;
      case ActionType.quotes:
        return LocalizationConstants.myQuotes;
      case ActionType.vmi:
        return LocalizationConstants.vendorManagedInventory;
      case ActionType.countInventory:
        return LocalizationConstants.countInventory;
      case ActionType.createOrder:
        return LocalizationConstants.createOrder;
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
              extra: VMILocationSelectCallbackHelper(
                  onSelectVMILocation: (location) {},
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
          context.read<LoadWebsiteUrlBloc>().add(LoadCustomUrlLoadEvent(
            customUrl: actionLink.url
          ));
        };
      case ActionType.invoices:
        return () {
          AppRoute.invoiceHistory.navigateBackStack(context);
        };
      case ActionType.viewAccountOnWebsite:
        return () {
          context.read<LoadWebsiteUrlBloc>().add(LoadWebsiteUrlLoadEvent(
            redirectUrl: WebsitePaths.accountWebsitePath
          ));
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
        title: LocalizationConstants.signOut,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.cancel),
          ),
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<LogoutCubit>().logout();
            },
            child: const Text(LocalizationConstants.oK),
          ),
        ]);
  }
}
