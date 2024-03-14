import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart/shipping_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_shipping/cart_shipping_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';

enum ShippingOption { ship, pickUp }

class CartShippingWidget extends StatelessWidget {
  final ShippingEntity shippingEntity;

  const CartShippingWidget({super.key, required this.shippingEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            LocalizationConstants.shipping,
            style: OptiTextStyles.titleLarge,
          ),
        ),
        BlocBuilder<CartShippingSelectionBloc, CartShippingSelectionState>(
          builder: (context, state) {
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
                          title: const Text(LocalizationConstants.ship),
                          value: ShippingOption.ship,
                          groupValue: state.selectedOption,
                          onChanged: (value) {
                            context.read<CartShippingSelectionBloc>().add(CartShippingOptionEvent(value!));
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<ShippingOption>(
                          title: const Text(LocalizationConstants.pickUp),
                          value: ShippingOption.pickUp,
                          groupValue: state.selectedOption,
                          onChanged: (value) {
                            context.read<CartShippingSelectionBloc>().add(CartShippingOptionEvent(value!));
                          },
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: state.selectedOption == ShippingOption.pickUp,
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
                                LocalizationConstants.pickUpLocation,
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
                  Visibility(
                    visible: state.selectedOption == ShippingOption.pickUp,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 24, left: 24, right: 24),
                      child: Row(
                        children: [
                          InkWell(
                            child: Text(
                              LocalizationConstants.hours,
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
                              LocalizationConstants.directions,
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
    String address = shippingEntity.warehouse!.address2 == null || shippingEntity.warehouse!.address2!.isEmpty
        ? shippingEntity.warehouse!.address1!
        : '${shippingEntity.warehouse!.address1}, ${shippingEntity.warehouse!.address2}';
    return address;
  }

  String _wareHouseCity() {
    String city = '${shippingEntity.warehouse!.city}, ${shippingEntity.warehouse!.state} ${shippingEntity.warehouse!.postalCode}';
    return city;
  }

  void _onHoursClick(BuildContext context) {
    displayDialogWidget(
        context: context,
        title: LocalizationConstants.hours,
        message: shippingEntity.warehouse!.hours,
        actions: [
          DialogPlainButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(LocalizationConstants.oK),
          ),
        ]);
  }

  Future<void> _onDirectionsClick() async {
    num latitude = shippingEntity.warehouse?.latitude ?? 0;
    num longitude = shippingEntity.warehouse?.longitude ?? 0;

    double latitudeDouble = latitude.toDouble();
    double longitudeDouble = longitude.toDouble();

    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showDirections(destination: Coords(latitudeDouble, longitudeDouble));
  }
}