import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:flutter/material.dart';

mixin ListGridViewMenuMixIn<T extends StatefulWidget> on State<T> {

  bool isGridView = true;

  List<ToolMenu> getToolMenu(BuildContext context) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(
        title: !isGridView
            ? '${LocalizationConstants.listView.localized()} \u2713'
            : LocalizationConstants.listView.localized(),
        action: () {
          setState(() {
            isGridView = false;
          });
        }));
    list.add(ToolMenu(
        title: isGridView
            ? '${LocalizationConstants.gridView.localized()} \u2713'
            : LocalizationConstants.gridView.localized(),
        action: () {
          setState(() {
            isGridView = true;
          });
        }));
    return list;
  }

}