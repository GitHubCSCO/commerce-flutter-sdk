import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/action_link/action_link_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionListSectionWidget extends StatelessWidget {
  final ActionsWidgetEntity actionsWidgetEntity;

  const ActionListSectionWidget({super.key, required this.actionsWidgetEntity});

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
            if (actions.isEmpty) {
              return const SizedBox();
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.separated(
                  itemCount: actions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    thickness: 0.3,
                  ),
                  itemBuilder: (context, index) {
                    final action = actions[index];
                    return ActionListItemWidget(action: action);
                  },
                ),
              );
            }
          default:
            return const Center(child: Text('Failed Loading Actions'));
        }
      },
    );
  }
}
