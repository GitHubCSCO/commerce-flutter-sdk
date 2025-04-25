import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/mixins/list_grid_view_mixin.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/category/category_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryScreen extends BaseStatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => sl<CategoryBloc>()..add(TopCategoryLoadEvent()),
      child: const CategoryPage(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameTopCategories,
      );
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with ListGridViewMenuMixIn {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.categories.localized(),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(
              isViewOnWebsiteEnable: false, toolMenuList: getToolMenu(context)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CategoryBloc>().add(TopCategoryLoadEvent());
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            switch (state) {
              case CategoryInitial():
              case CategoryLoading():
                return const Center(child: CircularProgressIndicator());
              case CategoryLoaded():
                return Container(
                  child: isGridView
                      ? CategoryGridWidget(
                          list: state.list, callback: _handleCategoryClick)
                      : CategoryListWidget(
                          list: state.list, callback: _handleCategoryClick),
                );
              case CategoryFailed():
              default:
                return const CustomScrollView(
                  slivers: <Widget>[
                    SliverFillRemaining(child: Center()),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  void _handleCategoryClick(BuildContext context, Category category) {
    if ((category.subCategories?.length ?? 0) > 0) {
      AppRoute.shopSubCategory.navigateBackStack(
        context,
        extra: category,
      );
    } else {
      final productPageEntity =
          ProductPageEntity('', ProductParentType.category, category: category);
      AppRoute.product.navigateBackStack(context, extra: productPageEntity);
    }
  }
}
