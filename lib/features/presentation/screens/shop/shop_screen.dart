import 'package:commerce_flutter_app/features/presentation/widget/action_grid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopBloc = BlocProvider.of<ShopPageBloc>(context);
    shopBloc.add(const ShopPageLoadEvent());

    return Scaffold(
        body: ListView(
      children: getWidgets(),
    ));
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
