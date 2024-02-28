import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/action_link/action_link_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_id_fetch_cubit/product_id_fetch_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_grid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/listview_divider_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/product_carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseDynamicContentScreen extends StatelessWidget {
  const BaseDynamicContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    throw UnimplementedError();
  }

  List<Widget> buildContentWidgets(List<WidgetEntity> widgetEntities) {
    List<Widget> widgets = [];
    final dividerWidget = buildDividerWidget();

    for (WidgetEntity widgetEntity in widgetEntities) {
      final Widget? widget = buildContentWidget(widgetEntity);

      if (widget != null) {
        widgets.add(widget);
        widgets.add(dividerWidget);
      }
    }

    return widgets;
  }

  Widget? buildContentWidget(WidgetEntity widgetEntity) {
    switch (widgetEntity.runtimeType) {
      case CarouselWidgetEntity:
        {
          final CarouselWidgetEntity carouselWidgetEntity =
              widgetEntity as CarouselWidgetEntity;

          return buildCarouselSectionWidget(
              carouselWidgetEntity: carouselWidgetEntity);
        }
      case ActionsWidgetEntity:
        {
          final ActionsWidgetEntity actionsWidgetEntity =
              widgetEntity as ActionsWidgetEntity;

          return (actionsWidgetEntity.layout == ActionsLayout.grid)
              ? buildActionGridSectionWidget(
                  actionsWidgetEntity: actionsWidgetEntity)
              : buildActionListSectionWidget(
                  actionsWidgetEntity: actionsWidgetEntity);
        }
      case ProductCarouselWidgetEntity:
        {
          final ProductCarouselWidgetEntity productCarouselWidgetEntity =
              widgetEntity as ProductCarouselWidgetEntity;

          return buildProductCarouselSectionWidget(
              productCarouselWidgetEntity: productCarouselWidgetEntity);
        }
      case SearchHistoryWidgetEntity:
        {
          final SearchHistoryWidgetEntity searchHistoryWidgetEntity =
              widgetEntity as SearchHistoryWidgetEntity;

          return buildSearchHistorySectionWidget(
              searchHistoryWidgetEntity: searchHistoryWidgetEntity);
        }
    }
    return null;
  }

  Widget buildDividerWidget() {
    return const ListViewDivider();
  }

  Widget buildCarouselSectionWidget(
      {required CarouselWidgetEntity carouselWidgetEntity}) {
    return BlocProvider(
      create: (context) => CarouselIndicatorCubit(),
      child: CarouselSectionWidget(carouselWidgetEntity: carouselWidgetEntity),
    );
  }

  Widget buildActionGridSectionWidget(
      {required ActionsWidgetEntity actionsWidgetEntity}) {
    return ActionGridSectionWidget(actionsWidgetEntity: actionsWidgetEntity);
  }

  Widget buildActionListSectionWidget(
      {required ActionsWidgetEntity actionsWidgetEntity}) {
    return BlocProvider(
      create: (context) =>
          sl<ActionLinkCubit>()..viewableActions(actionsWidgetEntity),
      child: ActionListSectionWidget(actionsWidgetEntity: actionsWidgetEntity),
    );
  }

  Widget buildProductCarouselSectionWidget(
      {required ProductCarouselWidgetEntity productCarouselWidgetEntity}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCarouselCubit>(
            create: (context) => sl<ProductCarouselCubit>()
              ..getProducts(productCarouselWidgetEntity)),

          BlocProvider<ProductIDFetchCubit>(create: (context) => sl<ProductIDFetchCubit>())
      ],
      child: ProductCarouselSectionWidget(
          productCarouselWidgetEntity: productCarouselWidgetEntity),
    );
  }

  Widget buildSearchHistorySectionWidget(
      {required SearchHistoryWidgetEntity searchHistoryWidgetEntity}) {
    return BlocProvider<SearchHistoryCubit>(
        create: (context) => sl<SearchHistoryCubit>()..getSearchHistory(),
        child: SearchHistorySectionWidget(
            searchHistoryWidgetEntity: searchHistoryWidgetEntity));
  }
}
