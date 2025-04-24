import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/mixins/list_grid_view_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product/product_collection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product/search_products_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

//TODO we need to take another look at the name of each class in this file
//TODO these classes are associated with category or brand product list page

enum ProductParentType {
  search,
  category,
  brand,
  brandProductLine,
  brandCategory,
  ;

  factory ProductParentType.fromJson(Map<String, dynamic> json) =>
      ProductParentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['productParentType'],
      );

  Map<String, dynamic> toJson() =>
      {'productParentType': toString().split('.').last};
}

class ProductPageEntity {
  String query = '';
  ProductParentType parentType;
  String? pageTitle;
  Category? category;
  String? categoryId;
  String? categoryTitle;
  BrandEntity? brandEntity;
  String? brandEntityId;
  String? brandEntityTitle;
  BrandProductLine? brandProductLine;

  ProductPageEntity(this.query, this.parentType,
      {this.pageTitle,
      this.category,
      this.categoryId,
      this.categoryTitle,
      this.brandEntity,
      this.brandEntityId,
      this.brandEntityTitle,
      this.brandProductLine});

  ProductPageEntity copyWith({
    String? query,
    ProductParentType? parentType,
    Category? category,
    String? categoryId,
    String? categoryTitle,
    BrandEntity? brandEntity,
    String? brandEntityId,
    String? brandEntityTitle,
  }) {
    return ProductPageEntity(
      query ?? this.query,
      parentType ?? this.parentType,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      brandEntity: brandEntity ?? this.brandEntity,
      brandEntityId: brandEntityId ?? this.brandEntityId,
      brandEntityTitle: brandEntityTitle ?? this.brandEntityTitle,
    );
  }

  factory ProductPageEntity.fromJson(Map<String, dynamic> json) {
    return ProductPageEntity(
      json['query'],
      ProductParentType.fromJson(json['productParentType']),
      pageTitle: json['pageTitle'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      categoryId: json['categoryId'],
      categoryTitle: json['categoryTitle'],
      brandEntity: json['brandEntity'] != null
          ? BrandEntity.fromJson(json['brandEntity'])
          : null,
      brandEntityId: json['brandEntityId'],
      brandEntityTitle: json['brandEntityTitle'],
      brandProductLine: json['brandProductLine'] != null
          ? BrandProductLine.fromJson(json['brandProductLine'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'productParentType': parentType.toJson(),
      'pageTitle': pageTitle,
      'category': category?.toJson(),
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'brandEntity': brandEntity?.toJson(),
      'brandEntityId': brandEntityId,
      'brandEntityTitle': brandEntityTitle,
      'brandProductLine': brandProductLine?.toJson(),
    };
  }
}

class ProductScreen extends StatelessWidget {
  final ProductPageEntity pageEntity;

  const ProductScreen({super.key, required this.pageEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCollectionBloc>(
      create: (context) => sl<ProductCollectionBloc>()
        ..add(ProductLoadEvent(entity: pageEntity)),
      child: ProductPage(pageEntity: pageEntity),
    );
  }
}

class ProductPage extends StatefulWidget {
  final ProductPageEntity pageEntity;

  ProductPage({super.key, required this.pageEntity});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with ListGridViewMenuMixIn {
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isGridView = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(widget.pageEntity),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(
              screenName: _getScreenName(widget.pageEntity),
              websitePath: _getWebsitePath(widget.pageEntity),
              toolMenuList: getToolMenu(context)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Input(
              hintText: LocalizationConstants.search.localized(),
              suffixIcon: IconButton(
                icon: SvgAssetImage(
                  assetName: AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  textEditingController.clear();
                  context.read<ProductCollectionBloc>().add(ProductLoadEvent(
                      entity: widget.pageEntity.copyWith(query: '')));
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                context.read<ProductCollectionBloc>().add(ProductLoadEvent(
                    entity: widget.pageEntity
                        .copyWith(query: textEditingController.text)));
              },
              controller: textEditingController,
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductCollectionBloc, ProductState>(
              builder: (context, state) {
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
                          create: (context) => sl<SearchProductsCubit>()
                            ..initialSetup(widget.pageEntity)
                            ..loadInitialSearchProducts(
                                productCollectionResult),
                        ),
                      ],
                      child: SearchProductsWidget(
                        onPageChanged: (page) {},
                        productListType: _getProductListType(widget.pageEntity),
                        isGridView: isGridView,
                      ),
                    );
                  case ProductFailed():
                  default:
                    return Center(
                        child: Text(
                            LocalizationConstants.searchNoResults.localized(),
                            style: OptiTextStyles.body));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ProductListType _getProductListType(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return ProductListType.categoryProducts;
    } else if (entity.parentType == ProductParentType.brand) {
      return ProductListType.shopBrandProducts;
    } else if (entity.parentType == ProductParentType.brandCategory) {
      return ProductListType.shopBrandCategoryProducts;
    } else if (entity.parentType == ProductParentType.brandProductLine) {
      return ProductListType.shopBrandProductLineProducts;
    } else {
      return ProductListType.searchProducts;
    }
  }

  String _getTitle(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return entity.category?.shortDescription ??
          entity.categoryTitle ??
          LocalizationConstants.categories.localized();
    } else if (entity.parentType == ProductParentType.brand) {
      return entity.brandEntity?.name ??
          entity.brandEntityTitle ??
          LocalizationConstants.brands.localized();
    } else {
      return entity.pageTitle ?? "Product list";
    }
  }

  String? _getWebsitePath(ProductPageEntity entity) {
    if (entity.parentType == ProductParentType.category) {
      return entity.category?.path;
    } else if (entity.parentType == ProductParentType.brand) {
      return entity.brandEntity?.detailPagePath;
    } else if (entity.parentType == ProductParentType.brandProductLine) {
      return entity.brandProductLine?.productListPagePath;
    }
    return null;
  }

  String? _getScreenName(ProductPageEntity entity) {
    switch (entity.parentType) {
      case ProductParentType.search:
        return AnalyticsConstants.screenNameSearch;
      case ProductParentType.category:
        return AnalyticsConstants.screenNameProductList;
      case ProductParentType.brand:
        return AnalyticsConstants.screenNameBrandProductList;
      case ProductParentType.brandProductLine:
        return AnalyticsConstants.screenNameBrandProductLineProductList;
      case ProductParentType.brandCategory:
        return AnalyticsConstants.screenNameBrandCategoryProductList;
    }
  }
}
