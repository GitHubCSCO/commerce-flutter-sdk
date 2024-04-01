import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_action_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionGridItemWidget extends BaseActionItemWidget {
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
              child: SvgPicture.asset(
                getActionIconPath(action),
                semanticsLabel: 'Action item icon',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.only(left: 4, right: 4),
              alignment: Alignment.center,
              child: Text(
                getActionTitle(action),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
