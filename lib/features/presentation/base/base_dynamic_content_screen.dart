import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_grid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_section_widget.dart';
import 'package:flutter/material.dart';


class BaseDynamicContentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    throw UnimplementedError();
  }

  List<Widget> buildContentWidgets(List<WidgetEntity> widgetEntities) {
    List<Widget> widgets = [];

    for (WidgetEntity widgetEntity in widgetEntities) {
      final Widget? widget = buildContentWidget(widgetEntity);

      if (widget != null) {
        widgets.add(widget);
      }
    }

    // Example additional widgets:
    // widgets.add(buildCarouselSectionWidget());
    // widgets.add(buildActionGridSectionWidget());
    // widgets.add(buildProductCarouselSectionWidget(title: 'Top Sellers'));
    // widgets.add(buildProductCarouselSectionWidget(title: 'VAT Products'));
    // widgets.add(buildProductCarouselSectionWidget(title: 'VMI Products'));
    // widgets.add(buildActionListSectionWidget());
    // widgets.add(buildSearchHistorySectionWidget());

    return widgets;
  }

  Widget? buildContentWidget(WidgetEntity widgetEntity) {
    switch (widgetEntity.runtimeType) {
      case CarouselWidgetEntity:
        {
          final CarouselWidgetEntity carouselWidgetEntity = widgetEntity as CarouselWidgetEntity;

          return buildCarouselSectionWidget(carouselWidgetEntity: carouselWidgetEntity);
        }
      case ActionsWidgetEntity:
        {
          final ActionsWidgetEntity actionsWidgetEntity = widgetEntity as ActionsWidgetEntity;

          return (actionsWidgetEntity.layout == ActionsLayout.grid)
              ? buildActionGridSectionWidget(actionsWidgetEntity: actionsWidgetEntity)
              : buildActionListSectionWidget(actionsWidgetEntity: actionsWidgetEntity);
        }
      case ProductCarouselWidgetEntity:
        {
          final ProductCarouselWidgetEntity productCarouselWidgetEntity = widgetEntity as ProductCarouselWidgetEntity;

          return buildProductCarouselSectionWidget(productCarouselWidgetEntity: productCarouselWidgetEntity);
        }
      case SearchHistoryWidgetEntity:
        {
          final SearchHistoryWidgetEntity searchHistoryWidgetEntity = widgetEntity as SearchHistoryWidgetEntity;

          return buildSearchHistorySectionWidget(searchHistoryWidgetEntity: searchHistoryWidgetEntity);
        }
    }
    return null;
  }

  Widget buildCarouselSectionWidget({required CarouselWidgetEntity carouselWidgetEntity}) {
    return CarouselSectionWidget(carouselWidgetEntity: carouselWidgetEntity);
  }

  Widget buildActionGridSectionWidget({required ActionsWidgetEntity actionsWidgetEntity}) {
    return ActionGridSectionWidget(actionsWidgetEntity: actionsWidgetEntity);
  }

  Widget buildActionListSectionWidget({required ActionsWidgetEntity actionsWidgetEntity}) {
    return ActionListSectionWidget(actionsWidgetEntity: actionsWidgetEntity);
  }

  Widget buildProductCarouselSectionWidget({required ProductCarouselWidgetEntity productCarouselWidgetEntity}) {
    return ProductCarouselSectionWidget(productCarouselWidgetEntity: productCarouselWidgetEntity);
  }

  Widget buildSearchHistorySectionWidget({required SearchHistoryWidgetEntity searchHistoryWidgetEntity}) {
    return SearchHistorySectionWidget(searchHistoryWidgetEntity: searchHistoryWidgetEntity);
  }

}