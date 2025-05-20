import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/cms_converter/text_justification_converter.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/cart_contents_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/cart_buttons_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/current_location_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/location_note_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/order_summary_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/previous_orders_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/shipping_method_widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/url_string_extensions.dart';

class CmsUseCase extends BaseUseCase {
  late PageContentType contentType;

  CmsUseCase({PageContentType? contentType}) : super() {
    this.contentType = contentType ?? PageContentType.account;
  }

  Future<Result<List<WidgetEntity>, ErrorResponse>> getCMSData() async {
    final result = await coreServiceProvider
        .getContentConfigurationService()
        .loadAndPersistLiveContentManagement(contentType);

    switch (result) {
      case Success(value: final pageData):
        {
          var session = await commerceAPIServiceProvider
              .getSessionService()
              .getCurrentSession();

          switch (session) {
            case Success(value: final session):
              {
                var currentSession = commerceAPIServiceProvider
                        .getSessionService()
                        .getCachedCurrentSession() ??
                    session;

                if (pageData?.pageClassicWidget != null) {
                  //for classic
                  var widgetList = pageData?.pageClassicWidget ?? [];
                  final widgetEntityList = await getWidgetEntityListClassic(
                      widgetList, currentSession);
                  return Success(widgetEntityList);
                } else {
                  // for spire
                  var widgetList = pageData?.page?.widgets ?? [];
                  final widgetEntityList = await getWidgetEntityListSpire(
                      widgetList, currentSession);
                  return Success(widgetEntityList);
                }
              }
            case Failure(errorResponse: final errorResponse):
              {
                return Failure(errorResponse);
              }
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  // classic

  Future<List<WidgetEntity>> getWidgetEntityListClassic(
      List<PageClassicWidgetEntity> pageClassicWidgets,
      Session? currentSession) async {
    var widgetEntities = <WidgetEntity>[];

    if (pageClassicWidgets.isEmpty) {
      return <WidgetEntity>[];
    } else {
      for (final pageClassicWidget in pageClassicWidgets) {
        switch (pageClassicWidget.type) {
          case WidgetType.mobileCarousel:
            final mobileCarouselWidget =
                await convertWidgetToCarouselWidgetEntityClassic(
                    pageClassicWidget, currentSession);
            widgetEntities.add(mobileCarouselWidget);
          case WidgetType.mobileCarouselSlide:
          case WidgetType.mobileLinkList:
            final listListWidget =
                await convertWidgetToMobileLinkListEntityClassic(
                    pageClassicWidget, currentSession);
            widgetEntities.add(listListWidget);
          case WidgetType.productCarousel:
            final productCarouselWidget =
                await convertWidgetToProductCarouselListEntityClassic(
                    pageClassicWidget, currentSession);
            widgetEntities.add(productCarouselWidget);
          case WidgetType.mobileSearchHistory:
            final searchHistoryWidget =
                await convertWidgetToSearchHistoryEntityClassic(
                    pageClassicWidget, currentSession);
            widgetEntities.add(searchHistoryWidget);
          case WidgetType.mobileCurrentLocation:
            final currentLocationWidget =
                CurrentLocationWidgetEntity(title: pageClassicWidget.title);
            widgetEntities.add(currentLocationWidget);
          case WidgetType.mobilePreviousOrders:
            final previousOrdersWidget =
                PreviousOrdersWidgetEntity(title: pageClassicWidget.title);
            widgetEntities.add(previousOrdersWidget);
          case WidgetType.mobileLocationNote:
            final locationNoteWidget =
                LocationNoteWidgetEntity(title: pageClassicWidget.title);
            widgetEntities.add(locationNoteWidget);
          case WidgetType.mobileCartButtonsWidget:
            final mobileCartWidget =
                await convertWidgetToMobileCartButtonWidgetEntityClassic(
                    pageClassicWidget);
            widgetEntities.add(mobileCartWidget);
          case WidgetType.unknown:
          default:
            break;
        }
      }
    }
    return widgetEntities;
  }

  Future<ActionsWidgetEntity> convertWidgetToMobileLinkListEntityClassic(
      PageClassicWidgetEntity pageClassicWidget,
      Session? currentSession) async {
    var actionsWidget = const ActionsWidgetEntity();
    var actionList = <ActionLinkEntity>[];
    var childWidgets = pageClassicWidget.childWidgets;
    childWidgets?.forEach((element) {
      final action = ActionLinkEntity(
        type: ActionTypeConverter.convert(element.type ?? ''),
        icon: element.icon,
        text: element.text,
        url: element.url,
      );
      actionList.add(action);
    });
    actionsWidget = actionsWidget.copyWith(
      type: pageClassicWidget.type,
      actions: actionList,
    );
    return actionsWidget;
  }

  Future<ProductCarouselWidgetEntity>
      convertWidgetToProductCarouselListEntityClassic(
          PageClassicWidgetEntity pageClassicWidget,
          Session? currentSession) async {
    var productCarouselWidget = ProductCarouselWidgetEntity();
    productCarouselWidget = productCarouselWidget.copyWith(
        carouselType: pageClassicWidget.carouselType,
        displayTopSellersFrom: pageClassicWidget.displayTopSellersFrom,
        selectedCategoryIds: pageClassicWidget.selectedCategoryIds
            ?.split(',')
            .map((s) => s)
            .toList(),
        displayPrice: pageClassicWidget.displayPrice,
        displayPartNumbers: pageClassicWidget.displayPartNumbers,
        title: pageClassicWidget.title);

    return productCarouselWidget;
  }

  Future<SearchHistoryWidgetEntity> convertWidgetToSearchHistoryEntityClassic(
      PageClassicWidgetEntity pageClassicWidget,
      Session? currentSession) async {
    var searchHistoryWidget = SearchHistoryWidgetEntity();

    searchHistoryWidget = searchHistoryWidget.copyWith(
        itemsCount: pageClassicWidget.numberOfPreviousSearches.toString(),
        title: pageClassicWidget.title);
    return searchHistoryWidget;
  }

  Future<CarouselWidgetEntity> convertWidgetToCarouselWidgetEntityClassic(
      PageClassicWidgetEntity pageClassicWidget,
      Session? currentSession) async {
    var carouselWidget = const CarouselWidgetEntity();

    carouselWidget =
        carouselWidget.copyWith(timerSpeed: pageClassicWidget.timerSpeed);
    carouselWidget = carouselWidget.copyWith(
        animationSpeed: pageClassicWidget.animationSpeed);

    var carouselSlideEntityList = <CarouselSlideWidgetEntity>[];

    for (final slide in pageClassicWidget.childWidgets ?? []) {
      if (slide is PageClassicChildWidgetEntity) {
        final slideWidget = CarouselSlideWidgetEntity(
            imagePath: slide.imageUrl?.makeImageUrl(),
            link: slide.link,
            primaryText: slide.primaryText,
            secondaryText: slide.secondaryText,
            primaryTextColorHex: slide.primaryTextColor,
            secondaryTextColorHex: slide.secondaryTextColor,
            textJustification: slide.textJustification);
        carouselSlideEntityList.add(slideWidget);
      }
    }
    carouselWidget =
        carouselWidget.copyWith(childWidgets: carouselSlideEntityList);

    carouselWidget = carouselWidget.copyWith(
      id: pageClassicWidget.id.toString(),
      type: pageClassicWidget.type,
    );

    return carouselWidget;
  }

  Future<CartButtonsWidgetEntity>
      convertWidgetToMobileCartButtonWidgetEntityClassic(
          PageClassicWidgetEntity pageClassicWidget) async {
    var cartWidget = const CartButtonsWidgetEntity();

    cartWidget =
        cartWidget.copyWith(isAddToListEnabled: pageClassicWidget.addToList);
    cartWidget = cartWidget.copyWith(
        isAddDiscountEnabled: pageClassicWidget.addDiscount);
    cartWidget =
        cartWidget.copyWith(isSavedOrderEnabled: pageClassicWidget.saveOrder);

    return cartWidget;
  }

  // spire
  Future<List<WidgetEntity>> getWidgetEntityListSpire(
      List<PageWidgetEntity> pageWidgets, Session? currentSession) async {
    var widgetEntities = <WidgetEntity>[];

    if (pageWidgets.isEmpty) {
      return <WidgetEntity>[];
    } else {
      for (final pageWidget in pageWidgets) {
        switch (pageWidget.type) {
          case WidgetType.mobileCarousel:
            final mobileCarouselWidget =
                await convertWidgetToCarouselWidgetEntity(
                    pageWidget, currentSession);
            widgetEntities.add(mobileCarouselWidget);
          case WidgetType.mobileCarouselSlide:
          case WidgetType.mobileLinkList:
            final listListWidget = await convertWidgetToMobileLinkListEntity(
                pageWidget, currentSession);
            widgetEntities.add(listListWidget);
          case WidgetType.productCarousel:
            final productCarouselWidget =
                await convertWidgetToProductCarouselListEntity(
                    pageWidget, currentSession);
            widgetEntities.add(productCarouselWidget);
          case WidgetType.mobileSearchHistory:
            final searchHistoryWidget =
                await convertWidgetToSearchHistoryEntity(
                    pageWidget, currentSession);
            widgetEntities.add(searchHistoryWidget);
          case WidgetType.mobileCartButtonsWidget:
            final mobileCartWidget =
                await convertWidgetToMobileCartButtonWidgetEntity(
                    pageWidget, currentSession);
            widgetEntities.add(mobileCartWidget);
          case WidgetType.unknown:
          default:
            break;
        }
      }
    }
    return widgetEntities;
  }

  Future<SearchHistoryWidgetEntity> convertWidgetToSearchHistoryEntity(
      PageWidgetEntity pageWidget, Session? currentSession) async {
    var searchHistoryWidget = SearchHistoryWidgetEntity();
    if (pageWidget.generalFields != null &&
        pageWidget.generalFields?.previousSearches != null) {
      searchHistoryWidget = searchHistoryWidget.copyWith(
          itemsCount: pageWidget.generalFields?.previousSearches.toString());
    }

    if (pageWidget.translatableFields != null) {
      var titles = pageWidget.translatableFields?.title as Map<String, dynamic>;
      titles.forEach((key, value) {
        if (currentSession?.language != null &&
            currentSession?.language?.id == key) {
          searchHistoryWidget = searchHistoryWidget.copyWith(title: value);
        }
      });
    }

    return searchHistoryWidget;
  }

  Future<ProductCarouselWidgetEntity> convertWidgetToProductCarouselListEntity(
      PageWidgetEntity pageWidget, Session? currentSession) async {
    var productCarouselWidget = ProductCarouselWidgetEntity();
    if (pageWidget.generalFields != null) {
      productCarouselWidget = productCarouselWidget.copyWith(
          carouselType: pageWidget.generalFields?.carouselType,
          displayTopSellersFrom: pageWidget.generalFields?.displayProductsFrom,
          selectedCategoryIds: pageWidget.generalFields?.selectedCategoryIds,
          displayPrice: pageWidget.generalFields?.showPrice,
          displayPartNumbers: pageWidget.generalFields?.showPartNumbers);
    }

    if (pageWidget.translatableFields != null) {
      var titles = pageWidget.translatableFields?.title as Map<String, dynamic>;
      titles.forEach((key, value) {
        if (currentSession?.language != null &&
            currentSession?.language?.id == key) {
          productCarouselWidget = productCarouselWidget.copyWith(title: value);
        }
      });
    }
    return productCarouselWidget;
  }

  Future<ActionsWidgetEntity> convertWidgetToMobileLinkListEntity(
      PageWidgetEntity pageWidget, Session? currentSession) async {
    var actionsWidget = const ActionsWidgetEntity();
    var actionList = <ActionLinkEntity>[];
    actionsWidget =
        actionsWidget.copyWith(layout: pageWidget.generalFields?.layout);

    if (pageWidget.generalFields?.links != null &&
        pageWidget.generalFields!.links!.isNotEmpty) {
      for (var action in pageWidget.generalFields?.links ?? []) {
        actionList.add(ActionLinkEntity(
          type: ActionTypeConverter.convert(action.fields?.type ?? ''),
          icon: action.fields?.icon,
          text: action.fields?.text,
          url: action.fields?.url,
          requiresAuth: action.fields?.requiresAuth,
        ));
      }
    } else if (pageWidget.translatableFields?.links != null) {
      var titles = pageWidget.translatableFields?.links as Map<String, dynamic>;
      titles.forEach((key, value) {
        if (currentSession?.language != null &&
            currentSession?.language?.id == key) {
          var pageLinks =
              (value as List).map((item) => PageLink.fromJson(item)).toList();
          if (pageLinks.isNotEmpty) {
            for (var pageLink in pageLinks) {
              actionList.add(ActionLinkEntity(
                type: ActionTypeConverter.convert(pageLink.fields?.type ?? ''),
                icon: pageLink.fields?.icon,
                text: pageLink.fields?.text,
                url: pageLink.fields?.url,
                requiresAuth: pageLink.fields?.requiresAuth,
              ));
            }
          }
        }
      });
    }
    actionsWidget = actionsWidget.copyWith(
      id: pageWidget.id,
      type: pageWidget.type,
    );
    actionsWidget = actionsWidget.copyWith(actions: actionList);
    return actionsWidget;
  }

  Future<CarouselWidgetEntity> convertWidgetToCarouselWidgetEntity(
      PageWidgetEntity pageWidget, Session? currentSession) async {
    var carouselWidget = const CarouselWidgetEntity();
    if (pageWidget.generalFields != null) {
      carouselWidget = carouselWidget.copyWith(
          timerSpeed: pageWidget.generalFields?.timerSpeed);
      carouselWidget = carouselWidget.copyWith(
          animationSpeed: pageWidget.generalFields?.animationSpeed);

      var carouselSlideEntityList = <CarouselSlideWidgetEntity>[];
      if (pageWidget.generalFields?.slides != null &&
          pageWidget.generalFields!.slides!.isNotEmpty) {
        for (final item in pageWidget.generalFields!.slides!) {
          final slideWidget = CarouselSlideWidgetEntity(
              background: item.slide?.background,
              backgroundColor: item.slide?.backgroundColor,
              imagePath: item.slide?.image,
              link: item.slide?.link,
              primaryText: item.slide?.heading,
              secondaryText: item.slide?.subheading,
              primaryTextColorHex: item.slide?.headingColor,
              secondaryTextColorHex: item.slide?.subheadingColor,
              textJustification: item.slide?.textAlignment);
          carouselSlideEntityList.add(slideWidget);
        }
        carouselWidget =
            carouselWidget.copyWith(childWidgets: carouselSlideEntityList);
      } else if (pageWidget.translatableFields?.slides != null) {
        var slides =
            pageWidget.translatableFields?.slides as Map<String, dynamic>;
        slides.forEach((key, value) {
          if (currentSession?.language != null &&
              currentSession?.language?.id == key) {
            var pageSlides = (value as List)
                .map((item) => PageSlide.fromJson(item))
                .toList();
            if (pageSlides.isNotEmpty) {
              for (var item in pageSlides) {
                var slideWidget = CarouselSlideWidgetEntity(
                    background: item.slide?.background,
                    backgroundColor: item.slide?.backgroundColor,
                    imagePath: item.slide?.image,
                    link: item.slide?.link,
                    primaryText: item.slide?.heading,
                    primaryTextColorHex: item.slide?.headingColor,
                    secondaryText: item.slide?.subheading,
                    secondaryTextColorHex: item.slide?.subheadingColor,
                    textJustification: TextJustificationConverter.convert(
                        item.slide?.textAlignment ?? ''));

                carouselSlideEntityList.add(slideWidget);
                carouselWidget = carouselWidget.copyWith(
                    childWidgets: carouselSlideEntityList);
              }
            }
          }
        });
      }

      carouselWidget = carouselWidget.copyWith(
        id: pageWidget.id,
        type: pageWidget.type,
      );
    }

    return carouselWidget;
  }

  Future<CartButtonsWidgetEntity> convertWidgetToMobileCartButtonWidgetEntity(
      PageWidgetEntity pageWidget, Session? currentSession) async {
    var cartWidget = const CartButtonsWidgetEntity();
    if (pageWidget.contextualFields != null) {
      var slides = pageWidget.contextualFields as Map<String, dynamic>;
      slides.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          value.forEach((innerKey, innerValue) {
            switch (key) {
              case 'addDiscount':
                cartWidget =
                    cartWidget.copyWith(isAddDiscountEnabled: innerValue);
                break;
              case 'saveOrder':
                cartWidget =
                    cartWidget.copyWith(isSavedOrderEnabled: innerValue);
                break;
              case 'addToList':
                cartWidget =
                    cartWidget.copyWith(isAddToListEnabled: innerValue);
                break;
            }
          });
        }
      });
    }

    return cartWidget;
  }
}
