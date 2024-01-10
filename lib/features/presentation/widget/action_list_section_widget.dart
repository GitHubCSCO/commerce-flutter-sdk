import 'package:commerce_flutter_app/features/presentation/widget/action_list_item_widget.dart';
import 'package:flutter/material.dart';

class ActionListSectionWidget extends StatelessWidget {
  const ActionListSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return ActionListItemWidget();
        },
      ),
    );
  }
}
