import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AutoCompleteWidget extends StatelessWidget {
  final AutocompleteResult autocompleteResult;

  const AutoCompleteWidget({super.key, required this.autocompleteResult});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Color(0xFFF5F5F5),
      ),
      itemCount: autocompleteResult.products!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final autoCompleteProduct = autocompleteResult.products![index];
        return AutoCompleteProductWidget(
            autocompleteProduct: autoCompleteProduct);
      },
    );
  }
}

class AutoCompleteProductWidget extends StatelessWidget {
  final AutocompleteProduct autocompleteProduct;

  const AutoCompleteProductWidget(
      {super.key, required this.autocompleteProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              ),
              child: Image.network(
                autocompleteProduct.image ?? "",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  autocompleteProduct.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: OptiTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationConstants.itemNumber
                      .format([autocompleteProduct.erpNumber ?? '']),
                  style: OptiTextStyles.bodySmall.copyWith(
                    color: AppColors.textDisabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
