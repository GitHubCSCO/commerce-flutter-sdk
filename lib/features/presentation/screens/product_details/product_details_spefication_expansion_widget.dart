import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/extensions/html_string_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProductDetailsExpansionItemWidget extends StatelessWidget {
  final ProductDetailItemEntity specification;

  const ProductDetailsExpansionItemWidget(
      {super.key, required this.specification});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              title: Text(
                specification.title,
                style: OptiTextStyles.titleSmall,
              ),
              collapsedBackgroundColor: Colors.white,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: HtmlWidget(
                    specification.htmlContent.styleHtmlContent() ?? '',
                    textStyle: OptiTextStyles.body,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, .0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
