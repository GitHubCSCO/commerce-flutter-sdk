import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';

class PageTypeConverter {
  static PageType convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "mobile/account":
      case "mobileaccount":
        return PageType.mobileAccount;
      case "mobile/shop":
      case "mobileshop":
        return PageType.mobileShop;
      case "mobile/search":
      case "mobilesearch":
        return PageType.mobileSearch;
      case "mobile/mobilecart":
      case "mobilecart":
        return PageType.mobileCart;
      default:
        return PageType.unknown;
    }
  }
}
