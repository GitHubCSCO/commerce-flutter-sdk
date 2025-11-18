import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_detail_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/html_content_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsExpansionItemWidget extends StatefulWidget {
  final ProductDetailItemEntity specification;
  final String productNumber;

  const ProductDetailsExpansionItemWidget({
    super.key,
    required this.specification,
    required this.productNumber,
  });

  @override
  State<ProductDetailsExpansionItemWidget> createState() =>
      _ProductDetailsExpansionItemWidgetState();
}

class _ProductDetailsExpansionItemWidgetState
    extends State<ProductDetailsExpansionItemWidget> {
  bool _isExpanded = false;

  void trackAttributesEvent() {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventViewSpecification,
            AnalyticsConstants.screenNameProductDetail)
        .withProperty(
            name: AnalyticsConstants.eventPropertySpecificationId,
            strValue: widget.specification.id)
        .withProperty(
            name: AnalyticsConstants.eventPropertySpecificationName,
            strValue: widget.specification.title)
        .withProperty(
            name: AnalyticsConstants.eventPropertyErpNumber,
            strValue: widget.productNumber)));
  }

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
                widget.specification.title,
                style: OptiTextStyles.titleSmall,
              ),
              collapsedBackgroundColor: Colors.white,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: HtmlContentWebView(
                    htmlContent: widget.specification.htmlContent,
                    textStyle: OptiTextStyles.body,
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
                if (expanded) {
                  trackAttributesEvent();
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
