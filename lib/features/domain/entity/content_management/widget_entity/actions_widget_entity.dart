import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:equatable/equatable.dart';

enum ActionType {
  unknown,
  custom,
  categories,
  brands,
  search,
  quickOrder,
  orderHistory,
  lists,
  savedOrders,
  changeCustomer,
  viewAccountOnWebsite,
  settings,
  signOut,
  locationFinder,
  orderApproval,
  showHidePricing,
  showHideInventory,
  forceCrash,
  toggleLogging,
  invoices,
  savedPayments,
  quotes,
  vmi,
  countInventory,
  createOrder,
  changeLocation,
}

enum ActionsLayout { list, grid }

class Action extends Equatable {
  final ActionType type;
  final String icon;
  final String text;
  final String url;
  final bool? requiresAuth;

  const Action({
    required this.type,
    required this.icon,
    required this.text,
    required this.url,
    this.requiresAuth,
  });

  @override
  List<Object?> get props => [type, icon, text, url, requiresAuth];
}

class ActionsWidgetEntity extends WidgetEntity {
  final ActionsLayout layout;
  final List<Action> actions;
  final List<Action> childWidgets;

  const ActionsWidgetEntity({
    required this.layout,
    required this.actions,
    required this.childWidgets,
  });

  @override
  List<Object?> get props => [layout, actions, childWidgets];
}
