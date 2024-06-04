import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:flutter/material.dart';

class BillToShipToChangeScreen extends StatelessWidget {
  const BillToShipToChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(LocalizationConstants.changeCustomer),
    );
  }

}