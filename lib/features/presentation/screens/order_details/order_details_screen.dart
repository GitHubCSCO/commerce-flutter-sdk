import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_details/order_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;
  const OrderDetailsScreen({
    super.key,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrderDetailsCubit>()..loadOrderDetails(orderNumber),
      child: const OrderDetailsPage(),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: context.watch<OrderDetailsCubit>().state.orderStatus ==
                  OrderStatus.success
              ? Text(context.watch<OrderDetailsCubit>().orderNumber ?? '')
              : const Text(LocalizationConstants.orderDetails)),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state.orderStatus == OrderStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.orderStatus == OrderStatus.failure) {
            return const Center(
              child: Text('Failed to load order details'),
            );
          } else {
            return SingleChildScrollView(
              child: OrderDetailsBodyWidget(
                orderNumber: context.watch<OrderDetailsCubit>().orderNumber,
                orderDate: context.watch<OrderDetailsCubit>().orderDate,
                poNumber: context.watch<OrderDetailsCubit>().poNumber,
                orderStatus: context.watch<OrderDetailsCubit>().orderStatus,
                shippingMethod:
                    context.watch<OrderDetailsCubit>().shippingMethod,
                terms: context.watch<OrderDetailsCubit>().terms,
                requestedDeliveryDate:
                    context.watch<OrderDetailsCubit>().requestedDeliveryDate,
                requestedDeliveryDateTitle: context
                    .watch<OrderDetailsCubit>()
                    .requestedDeliveryDateTitle,
                webOrderNumber:
                    context.watch<OrderDetailsCubit>().webOrderNumber,
                shippingCompanyName:
                    context.watch<OrderDetailsCubit>().shippingCompanyName,
                shippingFullAddress:
                    context.watch<OrderDetailsCubit>().shippingFullAddress,
                shippingCountryName:
                    context.watch<OrderDetailsCubit>().shippingCountryName,
                isShippingAddressVisible:
                    context.watch<OrderDetailsCubit>().isShippingAddressVisible,
                billingCompanyName:
                    context.watch<OrderDetailsCubit>().billingCompanyName,
                billingFullAddress:
                    context.watch<OrderDetailsCubit>().billingFullAddress,
              ),
            );
          }
        },
      ),
    );
  }
}
