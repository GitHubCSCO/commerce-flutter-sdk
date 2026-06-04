import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class LineItemTitleWidget extends StatelessWidget {
  final String? shortDescription;
  final String? productNumber;
  final String? manufacturerItem;

  const LineItemTitleWidget({
    super.key,
    this.shortDescription,
    this.productNumber,
    this.manufacturerItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    shortDescription ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.body,
                    textAlign: TextAlign.left,
                  ),
                ),
                if (!productNumber.isNullOrEmpty)
                  Text(
                    productNumber!,
                    style: context.text.bodySmall,
                    textAlign: TextAlign.left,
                  ),
                if (!manufacturerItem.isNullOrEmpty)
                  Row(
                    children: [
                      Text(
                        '${LocalizationConstants.mFGNumberSign.localized()} ',
                        style: context.text.subtitle.copyWith(fontSize: 12),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        manufacturerItem ?? '',
                        style: context.text.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
