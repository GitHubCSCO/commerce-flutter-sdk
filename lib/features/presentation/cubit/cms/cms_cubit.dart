import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/location_note_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/previous_orders_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_carousel/product_carousel_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/action_link_usecase/action_link_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_history_usecase/search_history_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'cms_state.dart';

class CmsCubit extends Cubit<CmsState> {
  final ActionLinkUseCase _actionLinkUseCase;
  final ProductCarouselUseCase _productCarouselUseCase;
  final SearchHistoryUseCase _searchHistoryUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;

  CmsCubit(
      {required ActionLinkUseCase actionLinkUseCase,
      required ProductCarouselUseCase productCarouselUseCase,
      required SearchHistoryUseCase searchHistoryUseCase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _actionLinkUseCase = actionLinkUseCase,
        _productCarouselUseCase = productCarouselUseCase,
        _searchHistoryUseCase = searchHistoryUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(CmsInitialState());

  void loading() {
    emit(CmsLoadingState());
  }

  void failedLoading() {
    emit(CmsFailureState());
  }

  Future<void> buildCMSWidgets(List<WidgetEntity> widgetEntities) async {
    List<WidgetEntity> entities = [];
    List<Future<WidgetEntity?>> futures = [];
    for (var widgetEntity in widgetEntities) {
      futures.add(buildContentWidget(widgetEntity));
    }

    List<WidgetEntity?> results = await Future.wait(futures);
    for (var entity in results) {
      if (entity != null) {
        entities.add(entity);
      }
    }
    emit(CmsLoadedState(widgetEntities: entities));
  }

  Future<WidgetEntity?> buildContentWidget(WidgetEntity widgetEntity) async {
    switch (widgetEntity.runtimeType) {
      case CarouselWidgetEntity:
        {
          final CarouselWidgetEntity carouselWidgetEntity =
              widgetEntity as CarouselWidgetEntity;
          return carouselWidgetEntity;
        }
      case ActionsWidgetEntity:
        {
          final ActionsWidgetEntity actionsWidgetEntity =
              widgetEntity as ActionsWidgetEntity;
          final list = await _actionLinkUseCase
              .getViewableActions(actionsWidgetEntity.actions);
          if (list.isEmpty) {
            return null;
          } else {
            actionsWidgetEntity.actions?.clear();
            actionsWidgetEntity.actions?.addAll(list);
            return actionsWidgetEntity;
          }
        }
      case ProductCarouselWidgetEntity:
        {
          final ProductCarouselWidgetEntity productCarouselWidgetEntity =
              widgetEntity as ProductCarouselWidgetEntity;
          final result =
              await _productCarouselUseCase.getProducts(widgetEntity);
          switch (result) {
            case Success():
              final productPricingEnabled =
                  await _pricingInventoryUseCase.getProductPricingEnable();
              final productList = result.value ?? [];
              if (productList.isEmpty) {
                return null;
              } else {
                productCarouselWidgetEntity.productCarouselList?.clear();
                final list = productList
                    .map((productEntity) => ProductCarouselEntity(
                        product: productEntity,
                        productPricingEnabled: productPricingEnabled))
                    .toList();
                productCarouselWidgetEntity.productCarouselList?.addAll(list);
              }
              return productCarouselWidgetEntity;
            default:
              return null;
          }
        }
      case SearchHistoryWidgetEntity:
        {
          final SearchHistoryWidgetEntity searchHistoryWidgetEntity =
              widgetEntity as SearchHistoryWidgetEntity;
          return searchHistoryWidgetEntity;
        }
      case CurrentLocationWidgetEntity:
        {
          final CurrentLocationWidgetEntity currentLocationWidgetEntity =
              widgetEntity as CurrentLocationWidgetEntity;
          return currentLocationWidgetEntity;
        }
      case PreviousOrdersWidgetEntity:
        {
          final PreviousOrdersWidgetEntity previousOrdersWidgetEntity =
              widgetEntity as PreviousOrdersWidgetEntity;
          return previousOrdersWidgetEntity;
        }
      case LocationNoteWidgetEntity:
        {
          final LocationNoteWidgetEntity locationNoteWidgetEntity =
              widgetEntity as LocationNoteWidgetEntity;
          return locationNoteWidgetEntity;
        }
    }
    return null;
  }
}
