import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/utils/platform_utils.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/bottom_menu_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/menu/tool_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BottomMenuWidget extends StatelessWidget {
  final List<ToolMenu> toolMenuList;
  final String websitePath;
  final String? screenName;
  final bool isViewOnWebsiteEnable;

  BottomMenuWidget({
    super.key,
    List<ToolMenu>? toolMenuList,
    String? websitePath,
    String? screenName,
    bool? isViewOnWebsiteEnable,
  })  : toolMenuList = toolMenuList ?? [],
        websitePath = websitePath ?? '',
        screenName = screenName ?? '',
        isViewOnWebsiteEnable = isViewOnWebsiteEnable ?? true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BottomMenuCubit>(),
      child: BottomMenu(
        toolMenuList: toolMenuList,
        websitePath: websitePath,
        isViewOnWebsiteEnable: isViewOnWebsiteEnable,
        screenName: screenName,
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  final List<ToolMenu> toolMenuList;
  final String websitePath;
  final String screenName;
  final bool isViewOnWebsiteEnable;

  BottomMenu({
    super.key,
    List<ToolMenu>? toolMenuList,
    String? websitePath,
    String? screenName,
    bool? isViewOnWebsiteEnable,
  })  : toolMenuList = toolMenuList ?? [],
        websitePath = websitePath ?? '',
        screenName = screenName ?? '',
        isViewOnWebsiteEnable = isViewOnWebsiteEnable ?? true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomMenuCubit, BottomMenuState>(
      listener: (context, state) async {
        switch (state) {
          case BottomMenuWebsiteUrlLoaded():
            final isWebViewEnabled =
                await PlatformUtils.isSystemWebViewEnabled(state.url);
            if (isWebViewEnabled) {
              await context.pushNamed(
                AppRoute.inAppBrowser.name,
                extra: state.url,
              );
            } else {
              // Show prompt to the user
              displayDialogWidget(
                context: context,
                title: LocalizationConstants.externalBrowserOpenWarningTitle
                    .localized(),
                message: LocalizationConstants.externalBrowserOpenWarningMsg
                    .localized(),
                actions: [
                  DialogPlainButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      launchUrlString(state.url);
                    },
                    child: Text(LocalizationConstants.oK.localized()),
                  ),
                ],
              );
            }

            break;
          case BottomMenuWebsiteUrlFailed():
            displayDialogWidget(
              context: context,
              title: LocalizationConstants.error.localized(),
              message: state.message,
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

    if (isViewOnWebsiteEnable &&
        context.read<BottomMenuCubit>().isViewOnWebsiteEnabled()) {
      widgets.add(CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(mContext);
          if (websitePath.isNotEmpty) {
            context
                .read<BottomMenuCubit>()
                .loadWebsiteUrl(websitePath, screenName: screenName);
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
          if (value.isUrl == true && value.url != null) {
            context.read<BottomMenuCubit>().loadWebsiteUrl(value.url!);
          } else {
            value.action();
          }
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
