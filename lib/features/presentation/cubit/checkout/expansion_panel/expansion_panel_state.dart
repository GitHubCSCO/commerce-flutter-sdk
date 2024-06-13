part of 'expansion_panel_cubit.dart';

abstract class ExpansionPanelState {}

class ExpansionPanelInitialState extends ExpansionPanelState {}

class ExpansionPanelChangeState extends ExpansionPanelState {

  List<ExpansionPanelItem> list;

  ExpansionPanelChangeState({required this.list});

}
