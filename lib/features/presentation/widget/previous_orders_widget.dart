import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/previous_orders_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/previous_orders_cubit/previous_order_state.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/previous_orders_cubit/previous_orders_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_history_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PreviousOrdersWidget extends StatelessWidget {
  final PreviousOrdersWidgetEntity previousOrdersWidgetEntity;

  const PreviousOrdersWidget({key, required this.previousOrdersWidgetEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousOrdersCubit, PreviousOrdersState>(
        builder: (context, state) {
      if (state is PreviousOrdersInitialState) {
        return Container();
      } else if (state is PreviousOrdersLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PreviousOrdersLoadedState) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text(
                  previousOrdersWidgetEntity.title ?? "",
                  style: OptiTextStyles.titleSmall,
                ),
              ),
              Visibility(
                visible: state.previousOrdersDataEntity.orders.isEmpty,
                child: Center(
                  child: Text(
                    LocalizationConstants.previousOrdersNotFound.localized(),
                    style: OptiTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: state.previousOrdersDataEntity.orders.length * 80,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.previousOrdersDataEntity.orders.length,
                  itemBuilder: (context, index) {
                    return OrderHistoryListItem(
                      orderEntity: state.previousOrdersDataEntity.orders[index],
                      onTap: () {
                        var orderEntity =
                            state.previousOrdersDataEntity.orders[index];
                        AppRoute.vmiOrderDetails.navigateBackStack(
                          context,
                          extra: true,
                          pathParameters: {
                            'orderNumber':
                                (orderEntity.webOrderNumber.isNullOrEmpty)
                                    ? (orderEntity.erpOrderNumber ?? '')
                                    : orderEntity.webOrderNumber!,
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      thickness: 1,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TertiaryButton(
                    borderColor: OptiAppColors.grayBackgroundColor,
                    backgroundColor: OptiAppColors.grayBackgroundColor,
                    child: Text(
                      LocalizationConstants.viewAllOrders.localized(),
                    ),
                    onPressed: () {
                      AppRoute.vmiOrderHistory.navigateBackStack(context);
                    }),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
