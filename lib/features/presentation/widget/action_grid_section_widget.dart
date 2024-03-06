import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/action_link/action_link_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_grid_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionGridSectionWidget extends StatelessWidget {
  final ActionsWidgetEntity actionsWidgetEntity;

  const ActionGridSectionWidget({super.key, required this.actionsWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionLinkCubit, ActionLinkState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case ActionLinkInitialState:
          case ActionLinkLoadingState:
            return const Center(child: CircularProgressIndicator());
          case ActionLinkLoadedState:
            final actions = (state as ActionLinkLoadedState).actions;
            return Container(
              padding: const EdgeInsets.only(top: 8, bottom: 0, left: 12, right: 12),
              decoration: const BoxDecoration(color: Colors.white),
              child: GridView.builder(
                  itemCount: actions.length,
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final action = actions[index];
                    return ActionGridItemWidget(action: action);
                  }),
            );
          default:
            return const Center(child: Text('Failed Loading Actions'));
        }
      },
    );
  }
}
