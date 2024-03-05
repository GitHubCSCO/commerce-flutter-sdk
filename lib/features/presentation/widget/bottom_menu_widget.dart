import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomMenuWidget extends StatelessWidget {
  final List<ToolMenu> toolMenuList;

  BottomMenuWidget({super.key, List<ToolMenu>? toolMenuList})
      : toolMenuList = toolMenuList ?? [];

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _showBottomMenu(context, toolMenuList);
        },
        icon: const Icon(
          Icons.more_vert,
          color: Colors.black,
        )
    );
  }

  void _showBottomMenu(BuildContext context, List<ToolMenu> toolMenuList) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: _getToolMenuWidgets(context, toolMenuList),
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              LocalizationConstants.cancel,
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  List<Widget> _getToolMenuWidgets(BuildContext context, List<ToolMenu> toolMenuList) {
    List<Widget> widgets = [];
    widgets.add(CupertinoActionSheetAction(
      onPressed: () => {},
      child: const Text(
        LocalizationConstants.viewOnWebsite,
        style: TextStyle(color: Colors.blue),
      ),
    ));

    widgets.addAll(toolMenuList.map((value) {
      return CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
          value.action();
        },
        child: Text(
          value.title,
          style: const TextStyle(color: Colors.blue),
        ),
      );
    }));

    return widgets;
  }
}