import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryGridWidget extends StatelessWidget {

  final List<Category> list;
  final Function(BuildContext, Category) callback;

  const CategoryGridWidget({super.key, required this.list, required this.callback});

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
        return CategoryGridItemWidget(height: itemHeight, category: category, callback: callback);
      },
    );
  }

  double _calculateHeight(double width) {
    double oneThirdWidth = width / 3;
    double height = oneThirdWidth * (3 / 4);
    return height;
  }

}

class CategoryGridItemWidget extends StatelessWidget {

  final double height;
  final Category category;
  final Function(BuildContext, Category) callback;

  const CategoryGridItemWidget({super.key, required this.height, required this.category, required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback(context, category);
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
                category.smallImagePath.makeImageUrl(),
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // This function is called when the image fails to load
                  return Container(
                    color:
                    OptiAppColors.backgroundGray, // Placeholder color
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              alignment: Alignment.center,
              child: Text(
                category.shortDescription ?? '',
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