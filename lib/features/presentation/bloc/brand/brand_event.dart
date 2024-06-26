part of 'brand_bloc.dart';

abstract class BrandEvent {}

class BrandSectionLoadEvent extends BrandEvent {}

class BrandAutoCompleteLoadEvent extends BrandEvent {

  final String query;

  BrandAutoCompleteLoadEvent(this.query);

}

class BrandToggleEvent extends BrandEvent {

  final int index;

  BrandToggleEvent(this.index);

}

class BrandLoadEvent extends BrandEvent {

  final String brandId;

  BrandLoadEvent(this.brandId);

}
