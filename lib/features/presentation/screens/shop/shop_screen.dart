import 'package:commerce_flutter_app/features/presentation/widget/action_grid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_section_widget.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: getWidgets(),
      )
    );
  }

  List<Widget> getWidgets() {
    List<Widget> widgets = [];
    widgets.add(CarouselSectionWidget());
    widgets.add(ActionGridSectionWidget());
    widgets.add(ProductCarouselSectionWidget(title: 'Top Sellers'));
    widgets.add(ProductCarouselSectionWidget(title: 'VAT Products'));
    widgets.add(ProductCarouselSectionWidget(title: 'VMI Products'));
    widgets.add(ActionListSectionWidget());
    widgets.add(SearchHistorySectionWidget());
    return widgets;
  }

}
