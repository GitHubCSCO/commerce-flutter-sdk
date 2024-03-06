import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_action_item_widget.dart';
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
            SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                getActionIconPath(action),
                semanticsLabel: 'Action item icon',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: double.infinity,
              height: 32,
              padding: const EdgeInsets.only(left: 4, right: 4),
              alignment: Alignment.center,
              child: Text(
                getActionTitle(action),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
