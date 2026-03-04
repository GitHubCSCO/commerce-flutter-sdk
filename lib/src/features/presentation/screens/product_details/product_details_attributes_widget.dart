import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_details/product_details_attributes_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAttributesWidget extends StatefulWidget {
  final ProductDetailsAttributesEntity productDetailsAttributesEntity;
  final String productNumber;

  const ProductDetailsAttributesWidget(
      {super.key,
      required this.productDetailsAttributesEntity,
      required this.productNumber});

  @override
  _ProductDetailsAttributesWidgetState createState() =>
      _ProductDetailsAttributesWidgetState();
}

class _ProductDetailsAttributesWidgetState
    extends State<ProductDetailsAttributesWidget> {
  void trackAttributesEvent() {
    context.read<RootBloc>().add(RootAnalyticsEvent(AnalyticsEvent(
            AnalyticsConstants.eventViewAttributes,
            AnalyticsConstants.screenNameProductDetail)
        .withProperty(
            name: AnalyticsConstants.eventPropertyProductNumber,
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
              collapsedBackgroundColor: Colors.white,
              title: Text(
                LocalizationConstants.specifications.localized(),
                style: OptiTextStyles.titleSmall,
              ),
              onExpansionChanged: (bool expanded) {
                if (expanded) {
                  trackAttributesEvent();
                }
              },
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 16.0),
                  child: Column(
                    children: List.generate(
                      widget.productDetailsAttributesEntity.productAttributes
                          .length,
                      (index) {
                        final attribute = widget.productDetailsAttributesEntity
                            .productAttributes[index];
                        final aggregatedValues = attribute.attributeValues
                                ?.map((value) => value.valueDisplay)
                                .where((valueDisplay) => valueDisplay != null)
                                .join(' ') ??
                            '';
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  aggregatedValues,
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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
