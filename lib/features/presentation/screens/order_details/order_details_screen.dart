import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/order_details/order_details_cubit.dart';
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
              ? Text(
                  context
                          .watch<OrderDetailsCubit>()
                          .state
                          .order
                          .orderNumberLabel ??
                      context
                          .watch<OrderDetailsCubit>()
                          .state
                          .order
                          .orderNumber ??
                      '',
                )
              : const Text('Order Details')),
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
            return Center(
              child: Text(
                state.order.orderNumberLabel ?? state.order.orderNumber ?? '',
              ),
            );
          }
        },
      ),
    );
  }
}
