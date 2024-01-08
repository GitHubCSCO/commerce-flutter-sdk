import 'package:commerce_flutter_app/features/presentation/widget/linklist_item_widget.dart';
import 'package:flutter/material.dart';

class LinkListSectionWidget extends StatelessWidget {
  const LinkListSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return LinkListItemWidget();
        },
      ),
    );
  }
}
