part of 'shop_page_bloc.dart';

abstract class ShopPageEvent {
  const ShopPageEvent();
}

class ShopPageLoadEvent extends ShopPageEvent {
  const ShopPageLoadEvent();
}
