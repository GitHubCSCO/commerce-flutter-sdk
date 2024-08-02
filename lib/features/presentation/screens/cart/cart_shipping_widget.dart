import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/location_search_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/vmi_location_select_callback_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ShippingOption { ship, pickUp }

class CartShippingWidget extends StatelessWidget with MapDirection {
  final ShippingEntity shippingEntity;
  final void Function(BuildContext, WarehouseEntity)? onCallBack;

  const CartShippingWidget(
      {super.key, required this.shippingEntity, this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            LocalizationConstants.shipping.localized(),
            style: OptiTextStyles.titleLarge,
          ),
        ),
        BlocConsumer<CartShippingSelectionBloc, CartShippingSelectionState>(
          listener: (context, state) {
            if (state is CartShippingSelectionChangeState) {
              context.read<CartPageBloc>().add(CartPageLoadEvent());
            }
          },
          builder: (context, state) {
            ShippingOption? shippingOption;
            if (state is CartShippingDefaultState) {
              shippingOption = state.selectedOption;
            } else if (state is CartShippingSelectionChangeState) {
              shippingOption = state.selectedOption;
            } else {
              shippingOption = null;
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RadioListTile<ShippingOption>(
                          title: Text(LocalizationConstants.ship.localized()),
                          value: ShippingOption.ship,
                          groupValue: shippingOption,
                          onChanged: (value) {
                            context
                                .read<CartShippingSelectionBloc>()
                                .add(CartShippingOptionChangeEvent(value!));
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<ShippingOption>(
                          title: Text(LocalizationConstants.pickUp.localized()),
                          value: ShippingOption.pickUp,
                          groupValue: shippingOption,
                          onChanged: (value) {
                            context
                                .read<CartShippingSelectionBloc>()
                                .add(CartShippingOptionChangeEvent(value!));
                          },
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: shippingOption == ShippingOption.pickUp,
                    child: InkWell(
                      onTap: () {
                        AppRoute.locationSearch.navigateBackStack(context,
                            extra: VMILocationSelectCallbackHelper(
                                onSelectVMILocation: (location) {},
                                onWarehouseLocationSelected: (wareHouse) {
                                  onCallBack?.call(context, wareHouse);
                                },
                                locationSearchType:
                                    LocationSearchType.pickUpLocation));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
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
                                Text(
                                  LocalizationConstants.pickUpLocation
                                      .localized(),
                                  textAlign: TextAlign.center,
                                  style: OptiTextStyles.subtitle,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  shippingEntity.warehouse?.description ?? '',
                                  textAlign: TextAlign.center,
                                  style: OptiTextStyles.subtitle,
                                ),
                                Text(
                                  _wareHouseAddress(),
                                  textAlign: TextAlign.center,
                                  style: OptiTextStyles.body,
                                ),
                                Text(
                                  _wareHouseCity(),
                                  textAlign: TextAlign.center,
                                  style: OptiTextStyles.body,
                                ),
                                Text(
                                  shippingEntity.warehouse?.phone ?? '',
                                  textAlign: TextAlign.center,
                                  style: OptiTextStyles.body,
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: shippingOption == ShippingOption.pickUp,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 24, left: 24, right: 24),
                      child: Row(
                        children: [
                          InkWell(
                            child: Text(
                              LocalizationConstants.hours.localized(),
                              textAlign: TextAlign.center,
                              style: OptiTextStyles.link,
                            ),
                            onTap: () {
                              _onHoursClick(context);
                            },
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            child: Text(
                              LocalizationConstants.directions.localized(),
                              textAlign: TextAlign.center,
                              style: OptiTextStyles.link,
                            ),
                            onTap: () {
                              _onDirectionsClick();
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }

  String _wareHouseAddress() {
    String address = shippingEntity.warehouse!.address2 == null ||
            shippingEntity.warehouse!.address2!.isEmpty
        ? shippingEntity.warehouse!.address1!
        : '${shippingEntity.warehouse!.address1}, ${shippingEntity.warehouse!.address2}';
    return address;
  }

  String _wareHouseCity() {
    String city =
        '${shippingEntity.warehouse!.city}, ${shippingEntity.warehouse!.state} ${shippingEntity.warehouse!.postalCode}';
    return city;
  }

  void _onHoursClick(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: LocalizationConstants.hours.localized(),
        message: shippingEntity.warehouse!.hours,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(LocalizationConstants.oK.localized()),
          ),
        ]);
  }

  Future<void> _onDirectionsClick() async {
    num latitude = shippingEntity.warehouse?.latitude ?? 0;
    num longitude = shippingEntity.warehouse?.longitude ?? 0;

    double latitudeDouble = latitude.toDouble();
    double longitudeDouble = longitude.toDouble();

    await launchMap(latitudeDouble, longitudeDouble);
  }
}
