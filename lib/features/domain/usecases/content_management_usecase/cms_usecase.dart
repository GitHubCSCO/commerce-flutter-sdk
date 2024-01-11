import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/converter/cms_converter/text_justification_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CmsUseCase {
  late PageContentType contentType;

  final IContentConfigurationService _contentConfigurationService;
  final ISessionService _sessionService;

  CmsUseCase(this._contentConfigurationService, this._sessionService,
      {PageContentType? contentType}) {
    this.contentType = contentType ?? PageContentType.account;
  }

  Future<Result<List<WidgetEntity>, ErrorResponse>> getCMSData() async {
    print('CmsUseCase loaddata');

    final result = await _contentConfigurationService
        .loadPreviewContentManagement(contentType);

    switch (result) {
      case Success(value: final pageData):
        {
          var session = await _sessionService.getCurrentSession();

          switch (session) {
            case Success(value: final session):
              {
                var currentSession = _sessionService.currentSession ?? session;

                var widgetList = pageData?.page?.widgets ?? [];
                final widgetEntityList =
                    await getWidgetEntityList(widgetList, currentSession);
                return Success(widgetEntityList);
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

  Future<List<WidgetEntity>> getWidgetEntityList(
      List<PageWidgetEntity> pageWidgets, Session? currentSession) async {
    List<WidgetEntity> widgetEntities = [];

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
          case WidgetType.unknown:
          default:
            break;
        }
      }
    }

    return widgetEntities;
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
    var actionsWidget = ActionsWidgetEntity();
    var actionList = <Action>[];
    actionsWidget =
        actionsWidget.copyWith(layout: pageWidget.generalFields?.layout);

    if (pageWidget.generalFields?.links != null &&
        pageWidget.generalFields!.links!.isNotEmpty) {
      for (var action in pageWidget.generalFields?.links ?? []) {
        actionList.add(Action(
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
              actionList.add(Action(
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
    var carouselWidget = CarouselWidgetEntity();
    if (pageWidget.generalFields != null) {
      carouselWidget = carouselWidget.copyWith(
          timerSpeed: pageWidget.generalFields?.timerSpeed);
      carouselWidget = carouselWidget.copyWith(
          animationSpeed: pageWidget.generalFields?.animationSpeed);

      List<CarouselSlideWidgetEntity> carouselSlideEntityList = [];
      if (pageWidget.generalFields?.slides != null &&
          pageWidget.generalFields!.slides!.isNotEmpty) {
        for (final item in pageWidget.generalFields!.slides!) {
          final slideWidget = CarouselSlideWidgetEntity(
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
}
