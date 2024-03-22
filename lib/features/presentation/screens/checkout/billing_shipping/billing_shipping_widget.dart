import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/date_selection/date_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillingShippingWidget extends StatelessWidget {
  final BillingShippingEntity billingShippingEntity;

  const BillingShippingWidget({super.key, required this.billingShippingEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> list = [];

    list.add(_buildBillingAddress());

    if (billingShippingEntity.shippingMethod == ShippingOption.ship) {
      list.add(_buildShippingAddress());

      if (billingShippingEntity.carriers != null &&
          billingShippingEntity.carriers!.isNotEmpty) {
        list.add(_buildShippingMethod());
      }

      if (billingShippingEntity.cartSettings != null &&
          billingShippingEntity.cartSettings!.canRequestDeliveryDate!) {
        DateTime? maximumDate;

        if (billingShippingEntity.cartSettings!.maximumDeliveryPeriod! > 0) {
          final duration = Duration(days: billingShippingEntity.cartSettings!.maximumDeliveryPeriod!);
          maximumDate = DateTime.now().add(duration);
        }
        list.add(_buildRequestDeliveryDate(maximumDate));
      }
    } else {
      list.add(_buildPickUpAddress());
      list.add(_buildRequestDeliveryDate(null));
    }

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
          billingShippingEntity.billTo?.companyName ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          billingShippingEntity.billTo?.fullAddress ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          billingShippingEntity.billTo?.country?.name ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 16),
        Text(
          billingShippingEntity.billTo?.email ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        Text(
          billingShippingEntity.billTo?.phone ?? '',
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
      visible: billingShippingEntity.shippingMethod == ShippingOption.ship,
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
            billingShippingEntity.shipTo?.companyName ?? '',
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          Text(
            billingShippingEntity.shipTo?.fullAddress ?? '',
            textAlign: TextAlign.center,
            style: OptiTextStyles.body,
          ),
          Text(
            billingShippingEntity.shipTo?.country?.name ?? '',
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
      visible: billingShippingEntity.shippingMethod == ShippingOption.pickUp,
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
                billingShippingEntity.warehouse?.description ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.subtitle,
              ),
              Text(
                billingShippingEntity.warehouse?.wareHouseAddress() ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
              Text(
                billingShippingEntity.warehouse?.wareHouseCity() ?? '',
                textAlign: TextAlign.center,
                style: OptiTextStyles.body,
              ),
              Text(
                billingShippingEntity.warehouse?.phone ?? '',
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

  Widget _buildShippingMethod() {
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
        const SizedBox(height: 20),
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
              'Flat Carrier',
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 24),
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
              'Flat \$10',
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRequestDeliveryDate(DateTime? maxDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.requestDeliveryDateOptional,
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocalizationConstants.date,
              textAlign: TextAlign.center,
              style: OptiTextStyles.body,
            ),
            BlocBuilder<DateSelectionCubit, DateSelectionState>(
              builder: (context, state) {
                return InkWell(
                  child: Text(
                    state.dateString,
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  ),
                  onTap: () {
                    final firstDate = DateTime.now();
                    final lastDate = maxDate ?? DateTime(2100);
                    _selectRequestDeliveryDate(context, firstDate, lastDate);
                  },
                );
              },
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'This date is only a request and may not be fulfilled',
          textAlign: TextAlign.center,
          style: OptiTextStyles.bodySmall,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _selectRequestDeliveryDate(BuildContext context, DateTime firstDate,
      DateTime lastDate) async {
    final initialDate = context.read<DateSelectionCubit>().date ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      Future.delayed(const Duration(seconds: 0), () {
        context.read<DateSelectionCubit>().onDateSelect(pickedDate);
      });
    }
  }

}