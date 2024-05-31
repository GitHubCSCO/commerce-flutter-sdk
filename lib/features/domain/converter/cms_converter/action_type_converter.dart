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

class ActionTypeConverter {
  static ActionType convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "unknown":
        return ActionType.unknown;
      case "custom":
        return ActionType.custom;
      case "categories":
        return ActionType.categories;
      case "brands":
        return ActionType.brands;
      case "search":
        return ActionType.search;
      case "quickorder":
        return ActionType.quickOrder;
      case "orderhistory":
        return ActionType.orderHistory;
      case "lists":
        return ActionType.lists;
      case "savedorders":
        return ActionType.savedOrders;
      case "changecustomer":
        return ActionType.changeCustomer;
      case "viewaccountonwebsite":
        return ActionType.viewAccountOnWebsite;
      case "settings":
        return ActionType.settings;
      case "signout":
        return ActionType.signOut;
      case "locationfinder":
      case "locations":
        return ActionType.locationFinder;
      case "orderapproval":
        return ActionType.orderApproval;
      case "showhidepricing":
        return ActionType.showHidePricing;
      case "showhideinventory":
        return ActionType.showHideInventory;
      case "forcecrash":
        return ActionType.forceCrash;
      case "togglelogging":
        return ActionType.toggleLogging;
      case "invoices":
        return ActionType.invoices;
      case "savedpayments":
        return ActionType.savedPayments;
      case "quotes":
        return ActionType.quotes;
      case "vendormanagedinventory":
        return ActionType.vmi;
      case "countinventory":
        return ActionType.countInventory;
      case "createorder":
        return ActionType.createOrder;
      case "changelocation":
        return ActionType.changeLocation;
      default:
        return ActionType.unknown;
    }
  }
}
