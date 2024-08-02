import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/location_note_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/previous_orders_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/carousel_indicator/carousel_indicator_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_grid_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/action_list_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/carousel_section_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/current_location_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/listview_divider_item.dart';
import 'package:commerce_flutter_app/features/presentation/widget/location_note_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/previous_orders_widget.dart';
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

          if ((carouselWidgetEntity.childWidgets ?? []).isEmpty) {
            return null;
          }

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

      case CurrentLocationWidgetEntity:
        {
          final CurrentLocationWidgetEntity currentLocationWidgetEntity =
              widgetEntity as CurrentLocationWidgetEntity;
          return buildCurrentLocationSectionWidget(
              currentLocationWidgetEntity: currentLocationWidgetEntity);
        }

      case PreviousOrdersWidgetEntity:
        {
          final PreviousOrdersWidgetEntity previousOrdersWidgetEntity =
              widgetEntity as PreviousOrdersWidgetEntity;
          return buildPreviousOrdersSectionWidget(
              previousOrdersWidgetEntity: previousOrdersWidgetEntity);
        }

      case LocationNoteWidgetEntity:
        {
          final LocationNoteWidgetEntity locationNoteWidgetEntity =
              widgetEntity as LocationNoteWidgetEntity;
          return buildLocationNoteSectionWidget(
              locationNoteWidgetEntity: locationNoteWidgetEntity);
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
    return ActionListSectionWidget(actionsWidgetEntity: actionsWidgetEntity);
  }

  Widget buildProductCarouselSectionWidget(
      {required ProductCarouselWidgetEntity productCarouselWidgetEntity}) {
    return BlocProvider<ProductCarouselCubit>(
      create: (context) => sl<ProductCarouselCubit>()
        ..getCarouselProducts(productCarouselWidgetEntity),
      child: BlocListener<RootBloc, RootState>(
        listener: (context, state) {
          if (state is RootPricingInventoryReload) {
            context
                .read<ProductCarouselCubit>()
                .getCarouselProducts(productCarouselWidgetEntity);
          }
        },
        child: ProductCarouselSectionWidget(
            productCarouselWidgetEntity: productCarouselWidgetEntity),
      ),
    );
  }

  Widget buildSearchHistorySectionWidget(
      {required SearchHistoryWidgetEntity searchHistoryWidgetEntity}) {
    return SearchHistorySectionWidget(
        searchHistoryWidgetEntity: searchHistoryWidgetEntity);
  }

  Widget buildCurrentLocationSectionWidget(
      {required CurrentLocationWidgetEntity currentLocationWidgetEntity}) {
    return CurrentLocationWidget(
        currentLocationWidgetEntity: currentLocationWidgetEntity);
  }

  Widget buildPreviousOrdersSectionWidget(
      {required PreviousOrdersWidgetEntity previousOrdersWidgetEntity}) {
    return PreviousOrdersWidget(
        previousOrdersWidgetEntity: previousOrdersWidgetEntity);
  }

  Widget buildLocationNoteSectionWidget(
      {required LocationNoteWidgetEntity locationNoteWidgetEntity}) {
    return LocationNoteWidget(
        locationNoteWidgetEntity: locationNoteWidgetEntity);
  }
}
