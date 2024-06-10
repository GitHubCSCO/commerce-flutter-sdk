import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryPage();
  }

}

class CategoryPage extends StatefulWidget {

  CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.categories, style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(isViewOnWebsiteEnable: false, toolMenuList: _getToolMenu(context)),
        ],
      ),
      body: isGridView
          ? CategoryGridWidget(list: [], callback: _handleCategoryClick)
          : CategoryListWidget(list: [], callback: _handleCategoryClick),
    );
  }

  void _handleCategoryClick(BuildContext context, Category category) {

  }

  List<ToolMenu> _getToolMenu(BuildContext context) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(
      title: LocalizationConstants.listView,
      action: () {
        setState(() {
          isGridView = false;
        });
      }
    ));
    list.add(ToolMenu(
        title: LocalizationConstants.gridView,
        action: () {
          setState(() {
            isGridView = true;
          });
        }
    ));
    return list;
  }
}