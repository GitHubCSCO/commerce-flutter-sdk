import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';

void viewPricingQuantityWidget(
    BuildContext context, List<BreakPriceDTOEntity> breakPriceDto) {
  var cellHeight = breakPriceDto.length > 1 ? 40 : 20;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(LocalizationConstants.quantityPricing.localized(),
            style: OptiTextStyles.titleLarge),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: breakPriceDto.length * cellHeight +
                100.0, // adjust the value as needed
            width: 300.0,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("Min. Qty.")),
                    Expanded(child: Text("Price Per.")),
                    Spacer(),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: breakPriceDto.length,
                    itemBuilder: (context, index) {
                      final breakPrice = breakPriceDto[index];
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(breakPrice.breakQty!
                                        .toInt()
                                        .toString())),
                                Expanded(
                                    child: Text(breakPrice.breakPriceDisplay
                                        .toString())),
                                Expanded(
                                    child: Text(
                                        breakPrice.savingsMessage.toString())),
                              ],
                            ),
                          ),
                          const Divider(
                            color: OptiAppColors.border,
                            thickness: 1.0,
                          )
                        ],
                      );
                    },
                  ),
                ),
                PrimaryButton(
                    text: "OK",
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        ),
      );
    },
  );
}
