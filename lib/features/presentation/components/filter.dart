import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_history/order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFilterModalSheet(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (innerContext) {
      return BlocProvider.value(
        value: context.read<OrderHistoryCubit>(),
        child: Container(
          color: OptiAppColors.backgroundWhite,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                    SingleChildScrollView(
                      child: Text(
                        context
                            .read<OrderHistoryCubit>()
                            .state
                            .orderSortOrder
                            .title,
                        style: OptiTextStyles.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: OptiAppColors.backgroundWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 5,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 13.5,
                  horizontal: 31.5,
                ),
                child: PrimaryButton(
                  text: LocalizationConstants.apply,
                  onPressed: () {
                    Navigator.pop(innerContext);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
