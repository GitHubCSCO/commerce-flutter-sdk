import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class CurrencyItem extends StatelessWidget {
  final Currency currency;
  final bool isSelected;
  final void Function(BuildContext, Currency)? onCallBack;

  const CurrencyItem(
      {super.key,
      required this.isSelected,
      required this.currency,
      this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCallBack?.call(context, currency);
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        currency.description ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: context.text.body.copyWith(
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2),
            Visibility(
              visible: isSelected,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                child: const Icon(
                  Icons.radio_button_checked,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
