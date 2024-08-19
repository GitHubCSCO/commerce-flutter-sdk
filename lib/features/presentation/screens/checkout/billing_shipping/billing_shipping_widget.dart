import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/billing_shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_app/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/checkout/review_order/review_order_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/shipping_address_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/date_picker_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillingShippingWidget extends StatelessWidget {
  final BillingShippingEntity billingShippingEntity;
  final bool? isVmiCheckout;
  final void Function(BuildContext, Object)? onCallBack;

  const BillingShippingWidget({
    super.key,
    required this.billingShippingEntity,
    this.onCallBack,
    this.isVmiCheckout,
  });

  @override
  Widget build(BuildContext context) {
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
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> list = [];

    list.add(_buildBillingAddress());

    if (billingShippingEntity.shippingMethod == ShippingOption.ship) {
      list.add(_buildShippingAddress(
          context,
          billingShippingEntity.allowCreateNewShipToAddress != false &&
              isVmiCheckout != true));

      if (billingShippingEntity.carriers != null &&
          billingShippingEntity.carriers!.isNotEmpty) {
        int selectedCarrierIndex = 0;
        int selectedServiceIndex = 0;

        for (int i = 0;
            i < (billingShippingEntity.carriers?.length ?? 0);
            i++) {
          if (billingShippingEntity.selectedCarrier != null &&
              billingShippingEntity.selectedCarrier!.id ==
                  billingShippingEntity.carriers![i].id) {
            selectedCarrierIndex = i;
          }
        }

        for (int i = 0;
            i <
                (billingShippingEntity
                        .carriers?[selectedCarrierIndex].shipVias?.length ??
                    0);
            i++) {
          if (billingShippingEntity.selectedService != null &&
              billingShippingEntity.selectedService!.id ==
                  billingShippingEntity
                      .carriers?[selectedCarrierIndex].shipVias?[i].id) {
            selectedServiceIndex = i;
          }
        }

        if (billingShippingEntity.allowCreateNewShipToAddress != false &&
            isVmiCheckout != true) {
          list.add(_buildAddShippingAddressButton(context));
        }
        list.add(_buildShippingMethod(
            billingShippingEntity.carriers,
            billingShippingEntity.carriers?[selectedCarrierIndex].shipVias,
            selectedCarrierIndex,
            selectedServiceIndex));
      }

      if (billingShippingEntity.cartSettings != null &&
          billingShippingEntity.cartSettings!.canRequestDeliveryDate!) {
        DateTime? maximumDate;

        if (billingShippingEntity.cartSettings!.maximumDeliveryPeriod! > 0) {
          final duration = Duration(
              days: billingShippingEntity.cartSettings!.maximumDeliveryPeriod!);
          maximumDate = DateTime.now().add(duration);
        }
        list.add(_buildRequestDeliveryDate(
            maximumDate,
            billingShippingEntity.requestDeliveryDate,
            billingShippingEntity.shippingMethod,
            billingShippingEntity.requestDateWarningMessage));
      }
    } else {
      list.add(_buildPickUpAddress());
      list.add(_buildRequestDeliveryDate(
          null,
          billingShippingEntity.requestDeliveryDate,
          billingShippingEntity.shippingMethod,
          billingShippingEntity.requestDateWarningMessage));
    }

    return list;
  }

  Widget _buildAddShippingAddressButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        AppRoute.addShippingAddress.navigateBackStack(context, extra:
            ShippingAddressAddCallbackHelper(onShippingAddressAdded: (shiptTo) {
          context.read<CheckoutBloc>().add(AddShiptoAddressEvent(shiptTo));
        }));
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white, // Button color
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        textStyle: OptiTextStyles.linkMedium,
      ),
      child: Text(
        LocalizationConstants.newAddress.localized(),
      ),
    );
  }

  Widget _buildBillingAddress() {
    return BillingAddressWidget(
      companyName: billingShippingEntity.billTo?.companyName,
      fullAddress: billingShippingEntity.billTo?.fullAddress,
      countryName: billingShippingEntity.billTo?.country?.name,
      email: billingShippingEntity.billTo?.email,
      phone: billingShippingEntity.billTo?.phone,
      buildSeperator: true,
    );
  }

  Widget _buildShippingAddress(BuildContext context, bool canChangeAddress) {
    return InkWell(
      onTap: canChangeAddress
          ? () async {
              final selectionEntity = BillToShipToAddressSelectionEntity(
                  selectedBillTo: billingShippingEntity.billTo,
                  selectedShipTo: billingShippingEntity.shipTo,
                  addressType: AddressType.shipTo);
              final result = await context.pushNamed(
                AppRoute.billToShipToSelection.name,
                extra: selectionEntity,
              );
              if (result is ShipTo) {
                onCallBack?.call(context, result);
              }
            }
          : null,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ShippingAddressWidget(
                  visible: billingShippingEntity.shippingMethod ==
                      ShippingOption.ship,
                  companyName: billingShippingEntity.shipTo?.companyName,
                  fullAddress: billingShippingEntity.shipTo?.fullAddress,
                  countryName: billingShippingEntity.shipTo?.country?.name,
                ),
              ),
              Visibility(
                visible: canChangeAddress,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          _buildSeparator(),
          const SizedBox(height: 12),
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
          PickupLocationWidget(
            description: billingShippingEntity.warehouse?.description,
            address: billingShippingEntity.warehouse?.wareHouseAddress(),
            city: billingShippingEntity.warehouse?.wareHouseCity(),
            phone: billingShippingEntity.warehouse?.phone,
            buildSeperator: true,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingMethod(
      List<CarrierDto>? carriers,
      List<ShipViaDto>? services,
      int selectedCarrierIndex,
      int selectedServiceIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: ListPickerWidget(
                          items: carriers ?? [],
                          selectedIndex: selectedCarrierIndex,
                          callback: _onCarrierSelect)),
                ],
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
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: ListPickerWidget(
                          items: services ?? [],
                          selectedIndex: selectedServiceIndex,
                          callback: _onServiceSelect)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRequestDeliveryDate(DateTime? maxDate, DateTime? selectedDate,
      ShippingOption? shippingOption, String? requestDateWarningMessage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          (shippingOption == ShippingOption.ship)
              ? LocalizationConstants.requestPickUpDateOptional.localized()
              : LocalizationConstants.requestDeliveryDateOptional.localized(),
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
                LocalizationConstants.date.localized(),
                textAlign: TextAlign.start,
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: DatePickerWidget(
                          maxDate: maxDate,
                          selectedDateTime: selectedDate,
                          callback: _onSelectDate)),
                ],
              ),
            ),
          ],
        ),
        Text(
          requestDateWarningMessage ?? '',
          textAlign: TextAlign.center,
          style: OptiTextStyles.bodySmall,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _onCarrierSelect(BuildContext context, Object item) {
    context.read<CheckoutBloc>().add(SelectCarrierEvent(item as CarrierDto));
    context.read<ReviewOrderCubit>().onOrderConfigChange();
  }

  void _onServiceSelect(BuildContext context, Object item) {
    context.read<CheckoutBloc>().add(SelectServiceEvent(item as ShipViaDto));
    context.read<ReviewOrderCubit>().onOrderConfigChange();
  }

  void _onSelectDate(BuildContext context, DateTime dateTime) {
    context.read<CheckoutBloc>().add(RequestDeliveryDateEvent(dateTime));
    context.read<ReviewOrderCubit>().onOrderConfigChange();
  }
}

Widget _buildSeparator() {
  return const Divider(
    thickness: 1,
    color: Colors.grey,
  );
}

class ShippingAddressWidget extends StatelessWidget {
  final bool visible;
  final bool buildSeperator;
  final String? title;
  final String? companyName;
  final String? fullAddress;
  final String? countryName;

  const ShippingAddressWidget({
    super.key,
    this.visible = true,
    this.buildSeperator = false,
    this.title,
    this.companyName,
    this.fullAddress,
    this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title != null
                ? title!
                : LocalizationConstants.shippingAddress.localized(),
            textAlign: TextAlign.start,
            style: OptiTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
          if (companyName.isNullOrEmpty &&
              fullAddress.isNullOrEmpty &&
              countryName.isNullOrEmpty)
            Text(
              LocalizationConstants.selectShippingAddress.localized(),
              textAlign: TextAlign.start,
              style: OptiTextStyles.bodyFade,
            ),
          if (!companyName.isNullOrEmpty)
            Text(
              companyName ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
          if (!fullAddress.isNullOrEmpty)
            Text(
              fullAddress ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
          if (!countryName.isNullOrEmpty)
            Text(
              countryName ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
          if (buildSeperator) ...[
            const SizedBox(height: 12),
            _buildSeparator(),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class BillingAddressWidget extends StatelessWidget {
  final String? companyName;
  final String? fullAddress;
  final String? countryName;
  final String? email;
  final String? phone;
  final bool buildSeperator;

  const BillingAddressWidget({
    super.key,
    this.companyName,
    this.fullAddress,
    this.countryName,
    this.email,
    this.phone,
    this.buildSeperator = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.billingAddress.localized(),
          textAlign: TextAlign.start,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        if (!companyName.isNullOrEmpty)
          Text(
            companyName ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (!fullAddress.isNullOrEmpty)
          Text(
            fullAddress ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (!countryName.isNullOrEmpty)
          Text(
            countryName ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (!email.isNullOrEmpty || !phone.isNullOrEmpty) ...[
          const SizedBox(height: 16),
          if (!email.isNullOrEmpty)
            Text(
              email ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
          if (!phone.isNullOrEmpty)
            Text(
              phone ?? '',
              textAlign: TextAlign.start,
              style: OptiTextStyles.body,
            ),
        ],
        if (buildSeperator) ...[
          const SizedBox(height: 12),
          _buildSeparator(),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class PickupLocationWidget extends StatelessWidget {
  final bool buildSeperator;
  final String? description;
  final String? address;
  final String? city;
  final String? phone;
  const PickupLocationWidget({
    super.key,
    this.buildSeperator = false,
    this.description,
    this.address,
    this.city,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.pickUpLocation.localized(),
          textAlign: TextAlign.start,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        if (description.isNullOrEmpty &&
            address.isNullOrEmpty &&
            city.isNullOrEmpty &&
            phone.isNullOrEmpty)
          Text(
            LocalizationConstants.selectPickUpLocation.localized(),
            textAlign: TextAlign.start,
            style: OptiTextStyles.bodyFade,
          ),
        if (!description.isNullOrEmpty)
          Text(
            description ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.subtitle,
          ),
        if (!address.isNullOrEmpty)
          Text(
            address ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (!city.isNullOrEmpty)
          Text(
            city ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (!phone.isNullOrEmpty)
          Text(
            phone ?? '',
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        if (buildSeperator) ...[
          const SizedBox(height: 12),
          _buildSeparator(),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
