import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';

class AddCreditCardScreen extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildItems(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.addCreditCard),
        centerTitle: false,
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> list = [];
    list.add(_buildShippingMethod(
        expirationMonths: ["asdasdsada", "asdasd"],
        expirationYears: ["aasdasdsa", "asdsa"],
        selecctedMonthIndex: 0,
        selecctedYearIndex: 0));

    list.add(const SizedBox(height: 20));
    list.add(_buildBillingAddressWidget(
        countries: ["asdasdsada", "asdasd"],
        states: ["asdasdsada", "asdasd"],
        selectedCountryIndex: 0,
        selectedStateIndex: 0));
    return list;
  }

  Widget _createInputField(
      String label, hintText, TextEditingController controller) {
    return Input(
      label: label,
      hintText: hintText,
      controller: controller,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onEditingComplete: () {
        FocusManager.instance.primaryFocus?.nextFocus();
      },
    );
  }

  Widget _buildBillingAddressWidget(
      {required List<String> countries,
      required List<String> states,
      required int selectedCountryIndex,
      required int selectedStateIndex}) {
    void _onCountrySelect(BuildContext context, Object item) {}

    void _onStateSelect(BuildContext context, Object item) {}

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.billingAddress,
          textAlign: TextAlign.center,
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        _createInputField(LocalizationConstants.address,
            LocalizationConstants.address, addressController),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.selectCountry,
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
                          items: states,
                          selectedIndex: selectedCountryIndex,
                          callback: _onCountrySelect)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'City',
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocalizationConstants.selectState,
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
                          items: states,
                          selectedIndex: selectedStateIndex,
                          callback: _onStateSelect)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Postal Code',
          ),
        ),
      ],
    );
  }

  Widget _buildShippingMethod(
      {required List<String> expirationMonths,
      required List<String> expirationYears,
      required int selecctedMonthIndex,
      required int selecctedYearIndex}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.cardExpirationDate,
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
                LocalizationConstants.month,
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
                          items: expirationMonths,
                          selectedIndex: selecctedMonthIndex,
                          callback: _onMonthSelect)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
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
                LocalizationConstants.year,
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
                          items: expirationYears,
                          selectedIndex: selecctedYearIndex,
                          callback: _onYearSelect)),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onYearSelect(BuildContext context, Object item) {}

  void _onMonthSelect(BuildContext context, Object item) {}
}
