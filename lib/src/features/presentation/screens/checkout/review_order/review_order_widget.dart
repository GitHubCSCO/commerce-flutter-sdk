import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/mixins/payment_summary_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart/payment_summary_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ReviewOrderWidget extends StatelessWidget with PaymentSummaryMixin {
  final ReviewOrderEntity reviewOrderEntity;
  final PaymentSummaryEntity? paymentSummaryEntity;
  final bool isOrderApproval;

  const ReviewOrderWidget({
    super.key,
    required this.reviewOrderEntity,
    this.paymentSummaryEntity,
    this.isOrderApproval = false,
  });

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

    if (paymentSummaryEntity != null) {
      list.add(_buildPaymentSummary());
    }
    list.add(_buildBillingAddress());

    if (reviewOrderEntity.shippingMethod == ShippingOption.ship) {
      final carrier = reviewOrderEntity.selectedCarrier;
      final service = reviewOrderEntity.selectedService;

      list.add(_buildShippingAddress());
      list.add(_buildShippingMethod(context, carrier, service));
    } else {
      list.add(_buildPickUpAddress());
      list.add(_buildRequestDeliveryDate(context));
    }

    if (!isOrderApproval) {
      list.add(_buildPaymentMethod());
    }

    if (!reviewOrderEntity.orderNotes.isNullOrEmpty) {
      list.add(_buildOrderNotes());
    }

    return list;
  }

  Widget _buildSeparator() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget _buildPaymentSummary() {
    return Column(
      children: buildSummaryItems(paymentSummaryEntity!),
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
          LocalizationConstants.billingAddress.localized(),
          textAlign: TextAlign.start,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Text(
          reviewOrderEntity.billTo?.companyName ?? '',
          textAlign: TextAlign.start,
          style: OptiTextStyles.body,
        ),
        Text(
          reviewOrderEntity.billTo?.fullAddress ?? '',
          textAlign: TextAlign.start,
          style: OptiTextStyles.body,
        ),
        Text(
          reviewOrderEntity.billTo?.country?.name ?? '',
          textAlign: TextAlign.start,
          style: OptiTextStyles.body,
        ),
        if ((reviewOrderEntity.billTo?.email ?? '').isNotEmpty ||
            (reviewOrderEntity.billTo?.phone ?? '').isNotEmpty) ...[
          const SizedBox(height: 16),
          if ((reviewOrderEntity.billTo?.email ?? '').isNotEmpty)
            Text(
              reviewOrderEntity.billTo?.email ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
          if ((reviewOrderEntity.billTo?.phone ?? '').isNotEmpty)
            Text(
              reviewOrderEntity.billTo?.phone ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
        ],
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
            LocalizationConstants.shippingAddress.localized(),
            textAlign: TextAlign.start,
            style: OptiTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
          Text(
            reviewOrderEntity.shipTo?.companyName ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
          Text(
            reviewOrderEntity.shipTo?.fullAddress ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
          Text(
            reviewOrderEntity.shipTo?.country?.name ?? '',
            textAlign: TextAlign.start,
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
                LocalizationConstants.pickUpLocation.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 8),
              Text(
                reviewOrderEntity.warehouse?.description ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.subtitle,
              ),
              Text(
                reviewOrderEntity.warehouse?.wareHouseAddress() ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
              Text(
                reviewOrderEntity.warehouse?.wareHouseCity() ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
              Text(
                reviewOrderEntity.warehouse?.phone ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
              const SizedBox(height: 12),
              _buildSeparator()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShippingMethod(BuildContext context, CarrierDto? selectedCarrier,
      ShipViaDto? selectedService) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.shippingMethod.localized(),
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.carrier.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                selectedCarrier?.description ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.service.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                selectedService?.description ?? '',
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
          ],
        ),
        Visibility(
          visible: _isRequestDateAvailable(context),
          child: Text(
            _getRequestDateTime(context),
            textAlign: TextAlign.center,
            style: OptiTextStyles.bodySmall,
          ),
        ),
        if (isOrderApproval) const SizedBox(height: 12),
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
            LocalizationConstants.requestDeliveryDate.localized(),
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
          LocalizationConstants.paymentMethod.localized(),
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Text(
          _paymentDescription(reviewOrderEntity.paymentMethod),
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 12),
        _buildSeparator()
      ],
    );
  }

  Widget _buildOrderNotes() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          LocalizationConstants.orderNotes.localized(),
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        Text(
          reviewOrderEntity.orderNotes ?? "",
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ),
        const SizedBox(height: 12),
        _buildSeparator()
      ],
    );
  }

  String _paymentDescription(PaymentMethodDto? paymentMethodDto) {
    if (paymentMethodDto != null) {
      if (paymentMethodDto.description != null &&
          paymentMethodDto.description!.isNotEmpty) {
        return paymentMethodDto.description!;
      } else {
        return paymentMethodDto.name!;
      }
    } else {
      return '';
    }
  }

  String _getRequestDateTime(BuildContext context) {
    if (_isRequestDateAvailable(context)) {
      final dateTime = reviewOrderEntity.requestDeliveryDate;
      return 'Arrives between ${DateFormat('E, MM/dd').format(dateTime!)}';
    }
    return '';
  }

  bool _isRequestDateAvailable(BuildContext context) {
    final dateTime = reviewOrderEntity.requestDeliveryDate;
    if (dateTime != null && dateTime != DateTime(0)) {
      return true;
    } else {
      return false;
    }
  }
}
