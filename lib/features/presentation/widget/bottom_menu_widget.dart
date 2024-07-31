import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BottomMenuWidget extends StatelessWidget {
  final List<ToolMenu> toolMenuList;
  final String websitePath;
  final bool isViewOnWebsiteEnable;

  BottomMenuWidget({super.key, List<
      ToolMenu>? toolMenuList, String? websitePath, bool? isViewOnWebsiteEnable})
      : toolMenuList = toolMenuList ?? [],
        websitePath = websitePath ?? '',
        isViewOnWebsiteEnable = isViewOnWebsiteEnable ?? true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BottomMenuCubit>(),
      child: BottomMenu(toolMenuList: toolMenuList, websitePath: websitePath, isViewOnWebsiteEnable: isViewOnWebsiteEnable),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final List<ToolMenu> toolMenuList;
  final String websitePath;
  final bool isViewOnWebsiteEnable;

  BottomMenu(
      {super.key, List<ToolMenu>? toolMenuList, String? websitePath, bool? isViewOnWebsiteEnable})
      : toolMenuList = toolMenuList ?? [],
        websitePath = websitePath ?? '',
        isViewOnWebsiteEnable = isViewOnWebsiteEnable ?? true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomMenuCubit, BottomMenuState>(
      listener: (context, state) {
        switch (state) {
          case BottomMenuWebsiteUrlLoaded():
            launchUrlString(state.url);
            break;
          case BottomMenuWebsiteUrlFailed():
            displayDialogWidget(
              context: context,
              title: LocalizationConstants.error.localized(),
              message: SiteMessageConstants.defaultMobileAppAlertCommunicationError,
              actions: [
                DialogPlainButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(LocalizationConstants.oK.localized()),
                ),
              ],
            );
            break;
        }
      },
      child: IconButton(
          onPressed: () {
            _showBottomMenu(context, toolMenuList);
          },
          icon: const Icon(Icons.more_vert)),
    );
  }

  void _showBottomMenu(BuildContext context, List<ToolMenu> toolMenuList) {
    showCupertinoModalPopup(
      context: context,
      builder: (mContext) {
        return CupertinoActionSheet(
          actions: _getToolMenuWidgets(context, mContext, toolMenuList),
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              LocalizationConstants.cancel.localized(),
              style: const TextStyle(color: Colors.blue),
            ),
            onPressed: () => Navigator.pop(mContext),
          ),
        );
      },
    );
  }

  List<Widget> _getToolMenuWidgets(BuildContext context, BuildContext mContext,
      List<ToolMenu> toolMenuList) {
    List<Widget> widgets = [];

    if (isViewOnWebsiteEnable) {
      widgets.add(CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(mContext);
          if (websitePath.isNotEmpty) {
            context.read<BottomMenuCubit>().loadWebsiteUrl(websitePath);
          }
        },
        child: Text(
          LocalizationConstants.viewOnWebsite.localized(),
          style: const TextStyle(color: Colors.blue),
        ),
      ));
    }

    widgets.addAll(toolMenuList.map((value) {
      return CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(mContext);
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