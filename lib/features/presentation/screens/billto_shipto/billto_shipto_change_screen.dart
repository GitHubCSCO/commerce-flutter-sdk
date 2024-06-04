import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/screens/checkout/billing_shipping/billing_shipping_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/tab_switch_widget.dart';
import 'package:flutter/material.dart';

class BillToShipToChangeScreen extends StatefulWidget {
  const BillToShipToChangeScreen({super.key});

  @override
  State<BillToShipToChangeScreen> createState() =>
      _BillToShipToChangeScreenState();
}

class _BillToShipToChangeScreenState extends State<BillToShipToChangeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalizationConstants.changeCustomerWillCall),
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
      body: const Column(
        children: [
          BillingAddressWidget(),
          TabSwitchWidget(
            tabTitle0: LocalizationConstants.ship,
            tabTitle1: LocalizationConstants.pickUp,
            tabWidget0: ShippingAddressWidget(),
            tabWidget1: PickupLocationWidget(),
          ),
        ],
      ),
    );
  }

}
