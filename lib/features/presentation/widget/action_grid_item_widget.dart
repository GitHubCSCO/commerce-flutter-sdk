import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/base/base_action_item_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';

class ActionGridItemWidget extends StatelessWidget with BaseActionItemWidget {
  final ActionLinkEntity action;

  const ActionGridItemWidget({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onActionNavigationCommand(context, action),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 32,
              height: 32,
              child: SvgAssetImage(
                assetName: getActionIconPath(action),
                semanticsLabel: 'Action item icon',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              alignment: Alignment.center,
              child: Text(
                getActionTitle(action),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: OptiTextStyles.bodyExtraSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
