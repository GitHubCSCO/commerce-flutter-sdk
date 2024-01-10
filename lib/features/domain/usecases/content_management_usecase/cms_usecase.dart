import 'package:commerce_flutter_app/features/domain/converter/cms_converter/text_justification_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_widget_entity.dart';
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
          case WidgetType.productCarousel:
          case WidgetType.mobileSearchHistory:
          case WidgetType.unknown:
          default:
            break;
        }
      }
    }

    return widgetEntities;
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
    }

    return carouselWidget;
  }
}
