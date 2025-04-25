import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:flutter/material.dart';

void viewQuoteLineBreakPricingWidget(
    BuildContext context, List<QuoteLinePricingEntity> breakPriceList) {
  var cellHeight = breakPriceList.length > 1 ? 40 : 20;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(LocalizationConstants.quotedPricing.localized(),
            style: OptiTextStyles.titleLarge),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: breakPriceList.length * cellHeight +
                100.0, // adjust the value as needed
            width: 300.0,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: breakPriceList.length,
                    itemBuilder: (context, index) {
                      final breakPrice = breakPriceList[index];
                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(breakPrice.qty.toString())),
                                Expanded(
                                    child: Text(breakPrice.price.toString())),
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
