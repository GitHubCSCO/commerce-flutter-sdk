import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryGridWidget<T extends BaseModel> extends StatelessWidget {
  final List<T> list;
  final Function(BuildContext, T) callback;

  const CategoryGridWidget(
      {super.key, required this.list, required this.callback});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemHeight = _calculateHeight(width);

    return GridView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        final category = list[index];
        return CategoryGridItemWidget<T>(
            height: itemHeight, item: category, callback: callback);
      },
    );
  }

  double _calculateHeight(double width) {
    double oneThirdWidth = width / 3;
    double height = oneThirdWidth * (3 / 4);
    return height;
  }
}

class CategoryGridItemWidget<T extends BaseModel> extends StatelessWidget {
  final double height;
  final T item;
  final Function(BuildContext, T) callback;

  const CategoryGridItemWidget(
      {super.key,
      required this.height,
      required this.item,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String description;

    if (item is Category) {
      imagePath = (item as Category).smallImagePath ?? '';
      description = (item as Category).shortDescription ?? '';
    } else if (item is BrandCategory) {
      imagePath = (item as BrandCategory).featuredImagePath ?? '';
      description = (item as BrandCategory).categoryName ?? '';
    } else if (item is GetBrandSubCategoriesResult) {
      imagePath = (item as GetBrandSubCategoriesResult).featuredImagePath ?? '';
      description = (item as GetBrandSubCategoriesResult).categoryName ?? '';
    } else if (item is BrandProductLine) {
      imagePath = (item as BrandProductLine).featuredImagePath ?? '';
      description = (item as BrandProductLine).name ?? '';
    } else {
      imagePath = '';
      description = '';
    }

    return InkWell(
      onTap: () {
        callback(context, item);
      },
      child: Container(
        color: OptiAppColors.backgroundWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: height,
              child: Image.network(
                imagePath.makeImageUrl(),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              alignment: Alignment.center,
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: OptiTextStyles.bodyExtraSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
