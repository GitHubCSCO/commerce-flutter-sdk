import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AutoCompleteWidget extends StatelessWidget {
  final Function(BuildContext, AutocompleteProduct) callback;
  final List<AutocompleteProduct>? autoCompleteProductList;
  final bool? isScrollableChild;

  const AutoCompleteWidget({
    super.key,
    required this.callback,
    this.autoCompleteProductList,
    this.isScrollableChild,
  });

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
      itemCount: autoCompleteProductList?.length ?? 0,
      shrinkWrap: true,
      physics: (isScrollableChild == false)
          ? const NeverScrollableScrollPhysics()
          : null,
      itemBuilder: (context, index) {
        final autoCompleteProduct = autoCompleteProductList![index];
        return InkWell(
          onTap: () {
            callback(context, autoCompleteProduct);
          },
          child: AutoCompleteProductWidget(
              autocompleteProduct: autoCompleteProduct),
        );
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  autocompleteProduct.image.makeImageUrl(),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // This function is called when the image fails to load
                    return Container(
                      color: OptiAppColors.backgroundGray, // Placeholder color
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image, // Icon to display
                        color: Colors.grey, // Icon color
                        size: 30, // Icon size
                      ),
                    );
                  },
                ),
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
                      .localized()
                      .format([autocompleteProduct.getProductNumber()]),
                  style: OptiTextStyles.bodySmall.copyWith(
                    color: OptiAppColors.textDisabledColor,
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
