import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/base/base_action_item_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/inventory/show_hide_inventory_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/show_hide/pricing/show_hide_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionListItemWidget extends StatelessWidget with BaseActionItemWidget {
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
              child: SvgAssetImage(
                assetName: getActionIconPath(action),
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
                  if (action.type == ActionType.showHidePricing)
                    BlocBuilder<ShowHidePricingBloc, ShowHidePricingState>(
                        builder: (context, state) {
                      bool toggle = (state is! ShowHidePricingChanged)
                          ? false
                          : state.value;
                      return Switch(
                        value: toggle,
                        onChanged: (value) {
                          context
                              .read<ShowHidePricingBloc>()
                              .add(ShowHidePricingToggled(value));
                          context
                              .read<RootBloc>()
                              .add(RootHidePricingInventoryEvent());
                        },
                      );
                    })
                  else if (action.type == ActionType.showHideInventory)
                    BlocBuilder<ShowHideInventoryBloc, ShowHideInventoryState>(
                        builder: (context, state) {
                      bool toggle = (state is! ShowHideInventoryChanged)
                          ? false
                          : state.value;
                      return Switch(
                        value: toggle,
                        onChanged: (value) {
                          context
                              .read<ShowHideInventoryBloc>()
                              .add(ShowHideInventoryToggled(value));
                          context
                              .read<RootBloc>()
                              .add(RootHidePricingInventoryEvent());
                        },
                      );
                    })
                  else
                    Container(
                      alignment: Alignment.center,
                      width: 24,
                      height: 24,
                      child: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
