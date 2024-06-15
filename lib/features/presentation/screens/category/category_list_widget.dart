import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryListWidget<T extends BaseModel> extends StatelessWidget {

  final List<T> list;
  final Function(BuildContext, T) callback;

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
          return CategoryListItemWidget<T>(callback: callback, item: category);
        },
      ),
    );
  }

}

class CategoryListItemWidget<T extends BaseModel> extends StatelessWidget {

  final T item;
  final Function(BuildContext, T) callback;

  const CategoryListItemWidget({super.key, required this.item, required this.callback});

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
    } else {
      imagePath = '';
      description = '';
    }

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
                  imagePath.makeImageUrl(),
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
              description,
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