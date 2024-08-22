import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/mixins/list_grid_view_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/brand_category/brand_category_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandCategoryScreen extends StatelessWidget {
  Brand brand;
  BrandCategory? brandCategory;
  GetBrandSubCategoriesResult? brandSubCategories;
  BrandCategoryScreen(
      {super.key,
      required this.brand,
      this.brandCategory,
      this.brandSubCategories});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandCategoryBloc>(
      create: (context) => sl<BrandCategoryBloc>()
        ..add(BrandCategoryLoadEvent(
            brand: brand,
            brandCategory: brandCategory,
            brandSubCategories: brandSubCategories)),
      child: BrandCategoryPage(
          brand: brand, categoryTitle: brandCategory?.categoryName),
    );
  }
}

class BrandCategoryPage extends StatefulWidget {
  late final String? categoryTitle;
  final Brand brand;

  BrandCategoryPage({super.key, required this.brand, this.categoryTitle});

  @override
  State<BrandCategoryPage> createState() => _BrandCategoryPageState();
}

class _BrandCategoryPageState extends State<BrandCategoryPage>
    with ListGridViewMenuMixIn {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.categoryTitle ??
                LocalizationConstants.categories.localized(),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(
              websitePath: widget.brand.detailPagePath,
              toolMenuList: getToolMenu(context)),
        ],
      ),
      body: BlocBuilder<BrandCategoryBloc, BrandCategoryState>(
        builder: (context, state) {
          switch (state) {
            case BrandCategoryInitial():
            case BrandCategoryLoading():
              return const Center(child: CircularProgressIndicator());
            case BrandCategoryLoaded():
              return Container(
                child: isGridView
                    ? CategoryGridWidget(
                        list: state.list,
                        callback: (ctxt, category) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandCategory: category);
                        })
                    : CategoryListWidget(
                        list: state.list,
                        callback: (ctxt, category) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandCategory: category);
                        }),
              );
            case BrandSubCategoryLoaded():
              return Container(
                child: isGridView
                    ? CategoryGridWidget(
                        list: state.list,
                        callback: (ctxt, category) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandSubCategories: category);
                        })
                    : CategoryListWidget(
                        list: state.list,
                        callback: (ctxt, category) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandSubCategories: category);
                        }),
              );
            case BrandCategoryFailed():
            default:
              return const Center();
          }
        },
      ),
    );
  }

  //TODO need to fix it. This is anti pattern
  //! TODO caution
  //! TODO we are passing multiple objects through extra using record
  //! TODO either we need to organize this record in a better way or use any other data structure
  Future<void> _handleCategoryClick(BuildContext context, Brand brand,
      {BrandCategory? brandCategory,
      GetBrandSubCategoriesResult? brandSubCategories}) async {
    var result = await context
        .read<BrandCategoryBloc>()
        .onSelectBrandCategory(brandCategory);
    if (result?.subCategories?.isNotEmpty == true) {
      AppRoute.brandCategory
          .navigateBackStack(context, extra: (brand, brandCategory, null));
    } else {
      final brandEntity = BrandEntityMapper.toEntity(brand);
      final productPageEntity = ProductPageEntity(
        '',
        ProductParentType.brandCategory,
        brandEntity: brandEntity,
        brandEntityId: brandCategory?.brandId,
        categoryId: brandCategory?.categoryId,
        brandEntityTitle: brandCategory?.categoryName,
      );
      AppRoute.product.navigateBackStack(context, extra: productPageEntity);
    }

    // if((brandCategory?.subCategories?.length ?? 0) > 0){
    //   AppRoute.brandCategory.navigateBackStack(
    //     context,
    //     extra: (brand, brandCategory, null)
    //   );
    // }else if((brandSubCategories?.subCategories?.length ?? 0) > 0){
    //   AppRoute.brandCategory.navigateBackStack(
    //     context,
    //     extra: (brand, null, brandSubCategories)
    //   );
    // }else{
    //   final productPageEntity = ProductPageEntity('',
    //     ProductParentType.brand,
    //     brandEntityId: brandCategory?.brandId ?? brandSubCategories?.brandId,
    //     brandEntityTitle: brandCategory?.categoryName ?? brandSubCategories?.categoryName
    //   );
    //   AppRoute.product.navigateBackStack(context, extra: productPageEntity);
    // }
  }
}
