import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/mixins/list_grid_view_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/category/category_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SubCategoryScreen extends BaseStatelessWidget {
  final Category? category;
  const SubCategoryScreen({
    super.key,
    this.category,
  });

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) =>
          sl<CategoryBloc>()..add(CategoryLoadEvent(category: category)),
      child: SubCategoryPage(
        category: category,
      ),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    var viewScreenEvent = AnalyticsEvent(AnalyticsConstants.eventViewScreen,
            AnalyticsConstants.screenNameCategory)
        .withProperty(
            name: AnalyticsConstants.eventPropertyCategoryId,
            strValue: category?.id.toString())
        .withProperty(
            name: AnalyticsConstants.eventPropertyCategoryName,
            strValue: category?.name);
    return viewScreenEvent;
  }
}

class SubCategoryPage extends StatefulWidget {
  final Category? category;

  const SubCategoryPage({
    super.key,
    this.category,
  });

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage>
    with ListGridViewMenuMixIn {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.category?.shortDescription ??
                LocalizationConstants.categories.localized(),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(
              websitePath: widget.category?.path,
              toolMenuList: getToolMenu(context)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CategoryBloc>().add(
                CategoryLoadEvent(category: widget.category),
              );
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
