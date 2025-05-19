import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/mixins/map_mixin.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DealerLocationWidgetItem extends StatefulWidget {
  final Dealer dealerData;

  DealerLocationWidgetItem({
    required this.dealerData,
  });

  @override
  _DealerLocationWidgetItemState createState() =>
      _DealerLocationWidgetItemState();
}

class _DealerLocationWidgetItemState extends State<DealerLocationWidgetItem>
    with MapDirection {
  bool _isHoursExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.dealerData.name ?? "",
              style: OptiTextStyles.subtitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.dealerData.address1 ?? "",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${widget.dealerData.city}, ${widget.dealerData.state} ${widget.dealerData.postalCode}",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.dealerData.phone ?? "",
              style: OptiTextStyles.body,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Text(
                      LocalizationConstants.hours.localized(),
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      setState(() {
                        _isHoursExpanded = !_isHoursExpanded;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: Text(
                      LocalizationConstants.directions.localized(),
                      textAlign: TextAlign.center,
                      style: OptiTextStyles.link,
                    ),
                    onTap: () {
                      _onDirectionsClick(widget.dealerData.latitude ?? 0.0,
                          widget.dealerData.longitude ?? 0.0);
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Distance ${widget.dealerData.distance?.toStringAsFixed(2)} Mi",
                    textAlign: TextAlign.center,
                    style: OptiTextStyles.body,
                  ),
                ],
              ),
            ),
            if (_isHoursExpanded)
              HtmlWidget(
                widget.dealerData.htmlContent ?? "",
                textStyle: OptiTextStyles.body,
              ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onDirectionsClick(double longitude, double latitude) async {
    await launchMap(latitude, longitude);
  }
}
