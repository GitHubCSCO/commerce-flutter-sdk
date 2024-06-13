import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/brand/brand_details/brand_details_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandDetailsEntity {

  Brand? brand;
  List<BrandCategory>? brandCategories;
  List<BrandProductLine>? brandProductLines;
  List<Product>? products;

  BrandDetailsEntity(
      {this.brand, this.brandCategories, this.brandProductLines, this.products});

}

class BrandDetailsScreen extends StatelessWidget {

  final Brand brand;

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandDetailsCubit>(
      create: (context) => sl<BrandDetailsCubit>()..getBrandDetails(brand),
      child: BrandDetailsPage(brand: brand),
    );
  }

}

class BrandDetailsPage extends StatelessWidget {

  final Brand brand;

  const BrandDetailsPage({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            brand.name ?? '', style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(isViewOnWebsiteEnable: false,
              toolMenuList: []),
        ],
      ),
      body: BlocBuilder<BrandDetailsCubit, BrandDetailsState>(builder: (context, state) {
        switch (state) {
          case BrandDetailsInitial():
          case BrandDetailsLLoading():
            return const Center(child: CircularProgressIndicator());
          case BrandDetailsLoaded():
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    BrandInfoWidget(brand: state.brandDetailsEntity.brand),
                    const SizedBox(height: 8),
                    CategoryCarouselWidget(list: state.brandDetailsEntity.brandCategories),
                    const SizedBox(height: 8),
                    BrandProductLinesWidget(list: state.brandDetailsEntity.brandProductLines),
                  ],
                ),
              ),
            );
          case BrandDetailsFailed():
          default:
            return const Center();
        }
      }),
    );
  }

}

class BrandInfoWidget extends StatelessWidget {

  final Brand? brand;

  const BrandInfoWidget({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                (brand?.logoSmallImagePath ?? '').makeImageUrl(),
                fit: BoxFit.fitHeight,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              brand?.htmlContent?.styleHtmlContent() ?? '',
              textStyle: OptiTextStyles.body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: PrimaryButton(
              onPressed: () {
                final productPageEntity = ProductPageEntity('', ProductParentType.brand, brand: brand);
                AppRoute.product.navigateBackStack(context, extra: productPageEntity);
              },
              text: LocalizationConstants.shopAllBrandProducts,
            ),
          )
        ],
      ),
    );
  }

}

class CategoryCarouselWidget extends StatelessWidget {

  final List<BrandCategory>? list;

  const CategoryCarouselWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: OptiAppColors.backgroundWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              LocalizationConstants.shopByCategory,
              style: OptiTextStyles.titleLarge,
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: list?.length ?? 0,
              separatorBuilder: (context, index) =>
              const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = list?[index];
                return InkWell(
                  onTap: () {

                  },
                  child: CategoryCarouselItemWidget(
                      category: category),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TertiaryButton(
              onPressed: () {

              },
              child: const Text(LocalizationConstants.shopAllBrandCategories),
            ),
          ),
        ],
      ),
    );
  }

}

class CategoryCarouselItemWidget extends StatelessWidget {

  final BrandCategory? category;

  const CategoryCarouselItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: OptiAppColors.backgroundGray),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                (category?.featuredImagePath ?? '').makeImageUrl(),
                fit: BoxFit.fitHeight,
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
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(category?.categoryName ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: OptiTextStyles.bodySmall),
          ),
        ],
      ),
    );
  }

}


class BrandProductLinesWidget extends StatelessWidget {

  final List<BrandProductLine>? list;

  const BrandProductLinesWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: OptiAppColors.backgroundWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              LocalizationConstants.shopProductLines,
              style: OptiTextStyles.titleLarge,
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: list?.length ?? 0,
              separatorBuilder: (context, index) =>
              const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final brandProductLine = list?[index];
                return InkWell(
                  onTap: () {

                  },
                  child: BrandProductLinesItemWidget(
                      brandProductLine: brandProductLine),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TertiaryButton(
              backgroundColor: OptiAppColors.grayBackgroundColor,
              onPressed: () {

              },
              child: const Text(LocalizationConstants.shopAllBrandProductLines),
            ),
          ),
        ],
      ),
    );
  }

}

class BrandProductLinesItemWidget extends StatelessWidget {

  final BrandProductLine? brandProductLine;

  const BrandProductLinesItemWidget(
      {super.key, required this.brandProductLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: OptiAppColors.backgroundGray),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                (brandProductLine?.featuredImagePath ?? '').makeImageUrl(),
                fit: BoxFit.fitHeight,
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
          const SizedBox(height: 8),
          SizedBox(
            height: 30,
            child: Text(brandProductLine?.name ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: OptiTextStyles.bodySmall),
          ),
        ],
      ),
    );
  }

}
