import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/category/category_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => sl<CategoryBloc>()..add(CategoryLoadEvent()),
      child: const CategoryPage(),
    );
  }
}

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            LocalizationConstants.categories.localized(), style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(isViewOnWebsiteEnable: false,
              toolMenuList: _getToolMenu(context)),
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          switch (state) {
            case CategoryInitial():
            case CategoryLoading():
              return const Center(child: CircularProgressIndicator());
            case CategoryLoaded():
              return Container(
                child: isGridView
                    ? CategoryGridWidget(list: state.list, callback: _handleCategoryClick)
                    : CategoryListWidget(list: state.list, callback: _handleCategoryClick),
              );
            case CategoryFailed():
            default:
              return const Center();
          }
        },
      ),
    );
  }

  void _handleCategoryClick(BuildContext context, Category category) {
    if((category.subCategories?.length ?? 0) > 0){
      AppRoute.shopSubCategory.navigateBackStack(
        context,
        //TODO what if id or name is null, we need to take care of that
        //TODO we should find a better way to pass categorytitle, 
        //TODO because if category title is long or does have special character it mmight or might not work properly
          pathParameters: {
            "categoryId": category.id.toString(),
            "categoryTitle": category.shortDescription.toString(),
            "categoryPath": category.path.toString()
          });
    }else{
      final productPageEntity = ProductPageEntity('', ProductParentType.category, category: category);
      AppRoute.product.navigateBackStack(context, extra: productPageEntity);
    }
  }

  List<ToolMenu> _getToolMenu(BuildContext context) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(
        title: LocalizationConstants.listView.localized(),
        action: () {
          setState(() {
            isGridView = false;
          });
        }
    ));
    list.add(ToolMenu(
        title: LocalizationConstants.gridView.localized(),
        action: () {
          setState(() {
            isGridView = true;
          });
        }
    ));
    return list;
  }
}