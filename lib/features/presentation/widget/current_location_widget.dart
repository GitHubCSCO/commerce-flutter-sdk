import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:flutter/material.dart';

class CurrentLocationWidget extends StatelessWidget {
  final CurrentLocationWidgetEntity currentLocationWidgetEntity;

  const CurrentLocationWidget(
      {super.key, required this.currentLocationWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(currentLocationWidgetEntity.title ?? ""),
    );
  }
}
