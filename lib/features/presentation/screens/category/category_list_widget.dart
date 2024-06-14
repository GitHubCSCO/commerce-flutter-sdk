import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryListWidget extends StatelessWidget {

  final List<Category> list;
  final Function(BuildContext, Category) callback;

  const CategoryListWidget({super.key, required this.list, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView.separated(
        itemCount: list.length ?? 0,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          thickness: 0.3,
        ),
        itemBuilder: (context, index) {
          final category = list[index];
          return CategoryListItemWidget(callback: callback, category: category);
        },
      ),
    );
  }

}

class CategoryListItemWidget extends StatelessWidget {

  final Category category;
  final Function(BuildContext, Category) callback;

  const CategoryListItemWidget({super.key, required this.category, required this.callback});

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
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              category.shortDescription ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: OptiTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

}