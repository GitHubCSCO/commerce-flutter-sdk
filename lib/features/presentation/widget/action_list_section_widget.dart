import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_item_widget.dart';
import 'package:flutter/material.dart';

class ActionListSectionWidget extends StatelessWidget {
  final ActionsWidgetEntity actionsWidgetEntity;

  const ActionListSectionWidget({super.key, required this.actionsWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        itemCount: actionsWidgetEntity.actions?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final action = actionsWidgetEntity.actions![index];
          return ActionListItemWidget(action: action);
        },
      ),
    );
  }
}
