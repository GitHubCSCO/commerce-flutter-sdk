import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_app/features/domain/extensions/warehouse_extension.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/billto_shipto/billto_shipto_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/tab_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToChangeScreen extends StatelessWidget {
  const BillToShipToChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BillToShipToBloc>(
      create: (context) => sl<BillToShipToBloc>()..add(BillToShipToLoadEvent()),
      child: const BillToShipToChangePage(),
    );
  }
}

class BillToShipToChangePage extends StatefulWidget {
  const BillToShipToChangePage({super.key});

  @override
  State<BillToShipToChangePage> createState() => _BillToShipToChangePageState();
}

class _BillToShipToChangePageState extends State<BillToShipToChangePage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationConstants.changeCustomerWillCall,
          style: OptiTextStyles.titleLarge,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                LocalizationConstants.cancel,
                style: OptiTextStyles.subtitleLink,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<BillToShipToBloc, BillToShipToState>(
        builder: (context, state) {
          switch (state) {
            case BillToShipToInitial():
            case BillToShipToLoading():
              return const Center(child: CircularProgressIndicator());
            case BillToShipToLoaded():
              return Container(
                color: OptiAppColors.backgroundWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBillToWidget(state.billToAddress),
                    const SizedBox(height: 20.0),
                    TabSwitchWidget(
                      tabTitle0: LocalizationConstants.ship,
                      tabTitle1: LocalizationConstants.pickUp,
                      tabWidget0: _buildShipToWidget(state.billToAddress, state.shipToAddress),
                      tabWidget1: _buildPickUpWidget(state.billToAddress, state.pickUpWarehouse, state.recipientAddress),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(LocalizationConstants.setAsDefault,
                                style: OptiTextStyles.body),
                          ),
                          Switch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              );
            case BillToShipToFailed():
            default:
              return const CustomScrollView(
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: Center(
                      child: Text(LocalizationConstants.error),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Widget _buildBillToWidget(BillTo? billTo) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          final selectionEntity = BillToShipToAddressSelectionEntity(selectedBillTo: billTo, addressType: AddressType.billTo);
          _handleAddressSelection(selectionEntity);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BillingAddressWidget(
                companyName: billTo?.companyName,
                fullAddress: billTo?.fullAddress,
                countryName: billTo?.country?.name,
                email: billTo?.email,
                phone: billTo?.phone,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShipToWidget(BillTo? billTo, ShipTo? shipTo) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          final selectionEntity = BillToShipToAddressSelectionEntity(selectedBillTo: billTo, selectedShipTo: shipTo, addressType: AddressType.shipTo);
          _handleAddressSelection(selectionEntity);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ShippingAddressWidget(
                companyName: shipTo?.companyName,
                fullAddress: shipTo?.fullAddress,
                countryName: shipTo?.country?.name,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPickUpWidget(BillTo? billTo, Warehouse? wareHouse, ShipTo? recipientAddress) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PickupLocationWidget(
                    description: wareHouse?.description,
                    address: wareHouse.wareHouseAddress(),
                    city: wareHouse.wareHouseCity(),
                    phone: wareHouse?.phone,
                    buildSeperator: true,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              )
            ],
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () {
              final selectionEntity = BillToShipToAddressSelectionEntity(selectedBillTo: billTo, selectedShipTo: recipientAddress, addressType: AddressType.shipTo);
              _handleAddressSelection(selectionEntity);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ShippingAddressWidget(
                    title: LocalizationConstants.recipientAddress,
                    companyName: recipientAddress?.companyName,
                    fullAddress: recipientAddress?.fullAddress,
                    countryName: recipientAddress?.country?.name,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleAddressSelection(BillToShipToAddressSelectionEntity selectionEntity) async {
    final result = await context.pushNamed(
      AppRoute.billToShipToSelection.name,
      extra: selectionEntity,
    );

    if (result is BillTo) {
      context.read<BillToShipToBloc>().add(BillToUpdateEvent(result));
    } else if (result is ShipTo) {
      context.read<BillToShipToBloc>().add(ShipToUpdateEvent(result));
    }
  }

}
