part of 'show_hide_inventory_bloc.dart';

abstract class ShowHideInventoryEvent extends Equatable {
  const ShowHideInventoryEvent();
}

class ShowHideInventoryToggled extends ShowHideInventoryEvent {
  final bool value;

  const ShowHideInventoryToggled(this.value);

  @override
  List<Object> get props => [value];
}
