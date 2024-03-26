import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ReviewOrderWidget extends StatelessWidget {

  final ReviewOrderEntity reviewOrderEntity;

  const ReviewOrderWidget({super.key, required this.reviewOrderEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewOrderCubit, ReviewOrderState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildItems(context),
          ),
        );
      },
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> list = [];

    list.add(_buildBillingAddress());

    if (reviewOrderEntity.shippingMethod == ShippingOption.ship) {
      final carrier = context.read<CheckoutBloc>().selectedCarrier;
      final service = context.read<CheckoutBloc>().selectedService;

      list.add(_buildShippingAddress());
      list.add(_buildShippingMethod(context, carrier, service));
    } else {
      list.add(_buildPickUpAddress());
      list.add(_buildRequestDeliveryDate(context));
    }

    list.add(_buildPaymentMethod());

    return list;
  }

  Widget _buildSeparator() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget _buildBillingAddress() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.billingAddress,
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Text(
          reviewOrderEntity.billTo?.companyName ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          reviewOrderEntity.billTo?.fullAddress ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          reviewOrderEntity.billTo?.country?.name ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 16),
        Text(
          reviewOrderEntity.billTo?.email ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          reviewOrderEntity.billTo?.phone ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 12),
        _buildSeparator()
      ],
    );
  }

  Widget _buildShippingAddress() {
    return Visibility(
      visible: reviewOrderEntity.shippingMethod == ShippingOption.ship,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            LocalizationConstants.shippingAddress,
            textAlign: TextAlign.center,
            style: OptiTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
          Text(
            reviewOrderEntity.shipTo?.companyName ?? '',
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          Text(
            reviewOrderEntity.shipTo?.fullAddress ?? '',
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          Text(
            reviewOrderEntity.shipTo?.country?.name ?? '',
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          const SizedBox(height: 12),
          _buildSeparator()
        ],
      ),
    );
  }

  Widget _buildPickUpAddress() {
    return Visibility(
      visible: reviewOrderEntity.shippingMethod == ShippingOption.pickUp,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                LocalizationConstants.pickUpLocation,
                textAlign: TextAlign.center,
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 8),
              Text(
                reviewOrderEntity.warehouse?.description ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.subtitle,
              ),
              Text(
                reviewOrderEntity.warehouse?.wareHouseAddress() ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
              Text(
                reviewOrderEntity.warehouse?.wareHouseCity() ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
              Text(
                reviewOrderEntity.warehouse?.phone ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
              const SizedBox(height: 12),
              _buildSeparator()
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _buildShippingMethod(BuildContext context, CarrierDto? selectedCarrier, ShipViaDto? selectedService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.shippingMethod,
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizationConstants.carrier,
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
            Text(
              selectedCarrier?.description ?? '',
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizationConstants.service,
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
            Text(
              selectedService?.description ?? '',
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
          ],
        ),
        Visibility(
          visible: _isRequestDateAvailable(context),
          child: Text(
            _getRequestDateTime(context),
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
        ),
      ],
    );
  }

  Widget _buildRequestDeliveryDate(BuildContext context) {
    return Visibility(
      visible: _isRequestDateAvailable(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            LocalizationConstants.requestDeliveryDate,
            textAlign: TextAlign.center,
            style: OptiTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
          Text(
            _getRequestDateTime(context),
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          const SizedBox(height: 12),
          _buildSeparator()
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.paymentMethod,
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Text(
          'Mastercard ***4004',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 12),
        _buildSeparator()
      ],
    );
  }

  String _getRequestDateTime(BuildContext context) {
    if (_isRequestDateAvailable(context)) {
      final dateTime = context.read<CheckoutBloc>().requestDeliveryDate;
      return 'Arrives between ${DateFormat('E, MM/dd').format(dateTime!)}';
    }
    return '';
  }

  bool _isRequestDateAvailable(BuildContext context) {
    final dateTime = context.read<CheckoutBloc>().requestDeliveryDate;
    if (dateTime != null && dateTime != DateTime(0)) {
      return true;
    } else {
      return false;
    }
  }

}