import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/action_link_usecase/action_link_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'action_link_state.dart';

class ActionLinkCubit extends Cubit<ActionLinkState> {
  final ActionLinkUseCase _actionLinkUseCase;

  ActionLinkCubit({required ActionLinkUseCase actionLinkUseCase})
      : _actionLinkUseCase = actionLinkUseCase,
        super(ActionLinkInitialState());

  Future<void> viewableActions(ActionsWidgetEntity actionsWidgetEntity) async {
    emit(ActionLinkLoadingState());
    final list = await _actionLinkUseCase
        .getViewableActions(actionsWidgetEntity.actions);
    emit(ActionLinkLoadedState(list));
  }
}
