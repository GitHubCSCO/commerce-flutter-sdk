import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_action_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionListItemWidget extends BaseActionItemWidget {
  final ActionLinkEntity action;

  const ActionListItemWidget({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onActionNavigationCommand(context, action),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                getActionIconPath(action),
                semanticsLabel: 'Action item icon',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              getActionTitle(action),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: OptiTextStyles.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Container(
                    alignment: Alignment.center,
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(7),
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
