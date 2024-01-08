import 'package:commerce_flutter_app/features/presentation/widget/linkgrid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/linklist_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/slideshow_section_widget.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SlideShowSectionWidget(),
          LinkGridSectionWidget(),
          ProductCarouselSectionWidget(title: 'Top Sellers'),
          ProductCarouselSectionWidget(title: 'VAT Products'),
          ProductCarouselSectionWidget(title: 'VMI Products'),
          LinkListSectionWidget(),
          SearchHistorySectionWidget()
        ],
      )
    );
  }
}
