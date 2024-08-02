import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_grid_item_widget.dart';
import 'package:flutter/material.dart';

class ActionGridSectionWidget extends StatelessWidget {
  final ActionsWidgetEntity actionsWidgetEntity;

  const ActionGridSectionWidget({super.key, required this.actionsWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 12, right: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: GridView.builder(
          itemCount: actionsWidgetEntity.actions?.length ?? 0,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final action = actionsWidgetEntity.actions![index];
            return ActionGridItemWidget(action: action);
          }),
    );
  }
}
