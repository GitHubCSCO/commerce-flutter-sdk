import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showOrderHistoryFilter(
  BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (innerContext) {
      return BlocProvider.value(
        value: context.read<OrderHistoryCubit>(),
        child: Container(
          color: OptiAppColors.backgroundWhite,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  LocalizationConstants.filter,
                  style: OptiTextStyles.titleLarge,
                ),
              ),
              Text(
                context.read<OrderHistoryCubit>().state.orderSortOrder.title,
                style: OptiTextStyles.titleSmall,
              ),
            ],
          ),
        ),
      );
    },
  );
}
