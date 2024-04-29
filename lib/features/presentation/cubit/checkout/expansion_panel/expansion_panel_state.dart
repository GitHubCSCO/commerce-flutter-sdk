part of 'expansion_panel_cubit.dart';

abstract class ExpansionPanelState {}

class ExpansionPanelInitialState extends ExpansionPanelState {}

class ExpansionPanelChangeState extends ExpansionPanelState {

  List<Item> list;

  ExpansionPanelChangeState({required this.list});

}
