import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/show_hide/inventory/show_hide_inventory_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/show_hide/pricing/show_hide_pricing_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/action_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionListSectionWidget extends StatelessWidget {
  final ActionsWidgetEntity actionsWidgetEntity;

  const ActionListSectionWidget({super.key, required this.actionsWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowHidePricingBloc>(
          create: (context) => sl<ShowHidePricingBloc>(),
        ),
        BlocProvider<ShowHideInventoryBloc>(
          create: (context) => sl<ShowHideInventoryBloc>(),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.separated(
          itemCount: actionsWidgetEntity.actions?.length ?? 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            thickness: 0.3,
          ),
          itemBuilder: (context, index) {
            final action = actionsWidgetEntity.actions![index];
            return ActionListItemWidget(action: action);
          },
        ),
      ),
    );
  }
}
