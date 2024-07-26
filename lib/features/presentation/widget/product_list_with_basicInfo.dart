import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/cart_line_extentions.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';

class ProductListWithBasicInfo extends StatelessWidget {
  final String? totalItemsTitle;
  final List<Object> list;

  const ProductListWithBasicInfo(
      {super.key, this.totalItemsTitle, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: totalItemsTitle != null,
          child: Container(
            width: double.maxFinite,
            color: OptiAppColors.backgroundWhite,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              totalItemsTitle!.format([list.length]),
              textAlign: TextAlign.start,
              style: OptiTextStyles.subtitle,
            ),
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFF5F5F5),
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String? imageUrl, title, productNumber, price;
            Object item = list[index];

            if (item is ProductEntity) {
              imageUrl = item.smallImagePath;
              title = item.shortDescription;
              productNumber = item.erpNumber;
            } else if (item is CartLineEntity) {
              imageUrl = item.smallImagePath;
              title = item.shortDescription;
              productNumber = item.erpNumber;
              price = item.updatePriceValueText();
            }

            return ProductListItemWithBasicInfo(
                imageUrl: imageUrl,
                title: title,
                productNumber: productNumber,
                price: price);
          },
        )
      ],
    );
  }
}

class ProductListItemWithBasicInfo extends StatelessWidget {
  final String? imageUrl, title, productNumber, price;

  const ProductListItemWithBasicInfo(
      {this.imageUrl, this.title, this.productNumber, this.price, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  imageUrl.makeImageUrl(),
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
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: OptiTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationConstants.itemNumber.localized()
                      .format([productNumber ?? '']),
                  style: OptiTextStyles.bodySmall.copyWith(
                    color: OptiAppColors.textDisabledColor,
                  ),
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: price != null,
                  child: Text(
                    price ?? '',
                    style: OptiTextStyles.bodySmallHighlight,
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
