import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product/product_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

//TODO we need to take another look at the name of each class in this file
//TODO these classes are associated with category or brand product list page

enum ProductParentType {
  category,
  brand
}

class ProductPageEntity {

  String query = '';
  ProductParentType parentType;
  Category? category;
  Brand? brand;

  ProductPageEntity(this.query, this.parentType, {this.category, this.brand});

  ProductPageEntity copyWith({
    String? query,
    ProductParentType? parentType,
    Category? category,
    Brand? brand,
  }) {
    return ProductPageEntity(
      query ?? this.query,
      parentType ?? this.parentType,
      category: category ?? this.category,
      brand: brand ?? this.brand,
    );
  }

}

class ProductScreen extends StatelessWidget {

  final ProductPageEntity pageEntity;

  const ProductScreen({super.key, required this.pageEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) => sl<ProductBloc>()..add(ProductLoadEvent(entity: pageEntity)),
      child: ProductPage(pageEntity: pageEntity),
    );
  }
}
class ProductPage extends StatelessWidget {

  final ProductPageEntity pageEntity;

  ProductPage({super.key, required this.pageEntity});

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _getTitle(pageEntity), style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(isViewOnWebsiteEnable: false,
              toolMenuList: []),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Input(
              hintText: LocalizationConstants.search,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  textEditingController.clear();
                  context
                      .read<ProductBloc>()
                      .add(ProductLoadEvent(entity: pageEntity.copyWith(query: '')));
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                context
                    .read<ProductBloc>()
                    .add(ProductLoadEvent(entity: pageEntity.copyWith(query: textEditingController.text)));
              },
              controller: textEditingController,
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              switch (state) {
                case ProductInitial():
                case ProductLoading():
                  return const Center(child: CircularProgressIndicator());
                case ProductLoaded():
                  final productCollectionResult = state.result;
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<AddToCartCubit>(
                        create: (context) => sl<AddToCartCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => sl<SearchProductsCubit>()..loadInitialSearchProducts(productCollectionResult),
                      ),
                    ],
                    //TODO from category product list to search product list
                    //TODO sort and filter does not work properly
                    //TODO either we should take another look whether to use SearchProductsWidget or introduce a new product list screen
                    child: SearchProductsWidget(
                      onPageChanged: (page) {},
                    ),
                  );
                case ProductFailed():
                default:
                  return Center(
                      child: Text(LocalizationConstants.searchNoResults,
                          style: OptiTextStyles.body));
              }
            }),
          ),
        ],
      ),
    );
  }

  String _getTitle(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return entity.category?.name ?? LocalizationConstants.categories;
    } else {
      return entity.brand?.name ?? LocalizationConstants.brands;
    }
  }
}