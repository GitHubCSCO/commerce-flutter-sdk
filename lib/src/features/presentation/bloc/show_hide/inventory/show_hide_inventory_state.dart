part of 'show_hide_inventory_bloc.dart';

abstract class ShowHideInventoryState extends Equatable {
  const ShowHideInventoryState();
}

class ShowHideInventoryInitial extends ShowHideInventoryState {
  final bool value;

  const ShowHideInventoryInitial(this.value);

  @override
  List<Object> get props => [value];
}

class ShowHideInventoryChanged extends ShowHideInventoryState {
  final bool value;

  const ShowHideInventoryChanged(this.value);

  @override
  List<Object> get props => [value];
}
