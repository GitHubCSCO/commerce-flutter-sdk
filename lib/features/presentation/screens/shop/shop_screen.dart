import 'package:commerce_flutter_app/features/presentation/widget/slideshow_section_widget.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 180,
            child: SlideShowSectionWidget(),
          ),
          Container(
            height: 180,
            child: SlideShowSectionWidget(),
          )
        ],
      )
    );
  }
}
