import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
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

  BrandEntity? brandEntity;
  List<BrandCategory>? brandCategories;
  List<BrandProductLine>? brandProductLines;

  BrandDetailsEntity(
      {this.brandEntity, this.brandCategories, this.brandProductLines});

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
                    BrandInfoWidget(brandEntity: state.brandDetailsEntity.brandEntity),
                    if((state.brandDetailsEntity.brandCategories?.length ?? 0) > 0) ...[
                      const SizedBox(height: 8),
                      CategoryCarouselWidget(brand: brand, list: state.brandDetailsEntity.brandCategories),
                    ],
                    if((state.brandDetailsEntity.brandProductLines?.length ?? 0) > 0) ...[
                      const SizedBox(height: 8),
                      BrandProductLinesWidget(brand: brand, list: state.brandDetailsEntity.brandProductLines),
                    ],
                    if((state.brandDetailsEntity.brandEntity?.topSellerProducts?.length ?? 0) > 0) ...[
                      const SizedBox(height: 8),
                      TopSellerProductsWidget(list: state.brandDetailsEntity.brandEntity?.topSellerProducts),
                      const SizedBox(height: 32),
                    ],
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

  final BrandEntity? brandEntity;

  const BrandInfoWidget({super.key, required this.brandEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OptiAppColors.backgroundWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                (brandEntity?.logoSmallImagePath ?? '').makeImageUrl(),
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
              brandEntity?.htmlContent?.styleHtmlContent() ?? '',
              textStyle: OptiTextStyles.body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: PrimaryButton(
              onPressed: () {
                final productPageEntity = ProductPageEntity('', ProductParentType.brand, brandEntity: brandEntity);
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
  final Brand brand;

  const CategoryCarouselWidget({super.key, required this.brand, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: OptiAppColors.backgroundWhite,
      width: double.infinity,
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
                final brandCategory = list?[index];
                return InkWell(
                  onTap: () async {
                    //TODO need to fix it. This is anti pattern
                    var result = await context.read<BrandDetailsCubit>().onSelectBrandCategory(brandCategory);
                    if(result?.subCategories?.isNotEmpty == true){
                      AppRoute.brandCategory.navigateBackStack(
                        context,
                        extra: (brand, brandCategory, null)
                      );
                    }else{
                      final productPageEntity = ProductPageEntity(
                        '', 
                        ProductParentType.brand, 
                        brandEntityId: brandCategory?.brandId, 
                        brandEntityTitle: brandCategory?.categoryName,
                      );
                      AppRoute.product.navigateBackStack(context, extra: productPageEntity); 
                    }
                    // //! TODO caution
                    // //! TODO we are passing multiple objects through extra using record
                    // //! TODO either we need to organize this record in a better way or use any other data structure
                    // if((brandCategory?.subCategories?.length ?? 0) > 0 && brandCategory?.categoryId.isNullOrEmpty == false){
                    //   AppRoute.brandCategory.navigateBackStack(
                    //     context,
                    //     extra: (brand, brandCategory, null)
                    //   );
                    // }else{
                    //   final productPageEntity = ProductPageEntity(
                    //     '', 
                    //     ProductParentType.brand, 
                    //     brandEntityId: brandCategory?.brandId, 
                    //     brandEntityTitle: brandCategory?.categoryName,
                    //   );
                    //   AppRoute.product.navigateBackStack(context, extra: productPageEntity);
                    // }
                  },
                  child: CategoryCarouselItemWidget(
                    category: brandCategory,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TertiaryButton(
              onPressed: () {
                  //! TODO caution
                  //! TODO we are passing multiple objects through extra using record
                  //! TODO either we need to organize this record in a better way or use any other data structure
                  AppRoute.brandCategory.navigateBackStack(
                    context,
                    extra: (brand, null, null)
                  );
                  // CustomSnackBar.showComingSoonSnackBar(context);
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
  final Brand brand;

  const BrandProductLinesWidget({super.key, required this.brand, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: OptiAppColors.backgroundWhite,
      width: double.infinity,
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
                  AppRoute.brandProductLines.navigateBackStack(
                    context,
                    extra: brand
                  );
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

class TopSellerProductsWidget extends StatelessWidget {

  final List<ProductEntity>? list;

  const TopSellerProductsWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: OptiAppColors.backgroundWhite,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              LocalizationConstants.topSellers,
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
                final topSellerProductEntityLine = list?[index];
                return InkWell(
                  onTap: () {
                      var productId = topSellerProductEntityLine?.styleParentId ?? topSellerProductEntityLine?.id;
                      //TODO what if productid is null, 
                      AppRoute.topLevelProductDetails.navigateBackStack(context,
                          pathParameters: {"productId": productId.toString()},
                          extra: topSellerProductEntityLine);                      
                  },
                  child: TopSellerProductItemWidget(
                      topSellerProductEntityLine: topSellerProductEntityLine),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class TopSellerProductItemWidget extends StatelessWidget {

  final ProductEntity? topSellerProductEntityLine;

  const TopSellerProductItemWidget({super.key, required this.topSellerProductEntityLine});

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
                (topSellerProductEntityLine?.smallImagePath ?? '').makeImageUrl(),
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
            child: Text(topSellerProductEntityLine?.shortDescription ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: OptiTextStyles.bodySmall),
          ),
        ],
      ),
    );
  }
}