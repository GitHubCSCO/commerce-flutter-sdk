import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/action_grid_item_widget.dart';
import 'package:flutter/widgets.dart';

class UIFactory {
  static Widget Function(BuildContext, ActionLinkEntity) actionGridItemBuilder =
      (ctx, action) => ActionGridItemWidget(action: action);
}
