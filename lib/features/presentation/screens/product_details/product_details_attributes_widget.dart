import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_attributes_entity.dart';
import 'package:flutter/material.dart';

class ProductDetailsAttributesWidget extends StatefulWidget {
  final ProductDetailsAttributesEntity productDetailsAttributesEntity;

  const ProductDetailsAttributesWidget(
      {Key? key, required this.productDetailsAttributesEntity})
      : super(key: key);

  @override
  _ProductDetailsAttributesWidgetState createState() =>
      _ProductDetailsAttributesWidgetState();
}

class _ProductDetailsAttributesWidgetState
    extends State<ProductDetailsAttributesWidget> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    int itemCount = _showAll
        ? widget.productDetailsAttributesEntity.productAttributes.length
        : (widget.productDetailsAttributesEntity.productAttributes.length > 3
            ? 3
            : widget.productDetailsAttributesEntity.productAttributes.length);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(itemCount, (index) {
            final attribute =
                widget.productDetailsAttributesEntity.productAttributes[index];
            final aggregatedValues = attribute.attributeValues
                    ?.map((value) => value.valueDisplay)
                    .where((valueDisplay) => valueDisplay != null)
                    .join(' ') ??
                '';
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    attribute.label ?? '',
                    maxLines: null,
                    overflow: TextOverflow.visible,
                    style: OptiTextStyles.subtitle,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Text(
                    aggregatedValues,
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            );
          }),
          if (widget.productDetailsAttributesEntity.productAttributes.length >
              5)
            TextButton(
              onPressed: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              child: Text(_showAll ? 'Show less' : 'Show more'),
            ),
        ],
      ),
    );
  }
}
