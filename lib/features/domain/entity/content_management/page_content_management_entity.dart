import 'package:commerce_flutter_app/features/domain/converter/cms_converter/action_layout_type_converter.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PageContentManagementEntity {
  PageInformationEntity? page;
  int? statusCode;
  String? redirectTo;
  bool? authorizationFailed;
  bool? isAuthenticatedOnServer;
  bool? bypassedAuthorization;
  bool? requiresAuthorization;
  Map<String, dynamic>? alternateLanguageUrls;

  PageContentManagementEntity({
    this.page,
    this.statusCode,
    this.redirectTo,
    this.authorizationFailed,
    this.isAuthenticatedOnServer,
    this.bypassedAuthorization,
    this.requiresAuthorization,
    this.alternateLanguageUrls,
  });
}

class PageInformationEntity {
  String? nodeId;
  String? name;
  PageType? type;
  String? parentId;
  int? sortOrder;
  String? websiteId;
  String? variantName;
  String? layoutPageId;
  String? templateHash;
  List<PageWidgetEntity>? widgets;
  String? id;
  PageSettingsEntity? generalFields;
  LocalizationEntity? translatableFields;
  Map<String, dynamic>? contextualFields;

  PageInformationEntity({
    this.nodeId,
    this.name,
    this.type,
    this.parentId,
    this.sortOrder,
    this.websiteId,
    this.variantName,
    this.layoutPageId,
    this.templateHash,
    this.widgets,
    this.id,
    this.generalFields,
    this.translatableFields,
    this.contextualFields,
  });
}

class PageSettingsEntity {
  bool? hideHeader;
  bool? hideFooter;
  bool? hideFromSearchEngines;
  bool? hideFromSiteSearch;
  bool? hideBreadcrumbs;
  bool? excludeFromNavigation;
  bool? excludeFromSignInRequired;
  String? variantName;
  String? horizontalRule;
  List<String>? tags;

  PageSettingsEntity({
    this.hideHeader,
    this.hideFooter,
    this.hideFromSearchEngines,
    this.hideFromSiteSearch,
    this.hideBreadcrumbs,
    this.excludeFromNavigation,
    this.excludeFromSignInRequired,
    this.variantName,
    this.horizontalRule,
    this.tags,
  });
}

class PageWidgetEntity {
  String? parentId;
  WidgetType? type;
  String? zone;
  bool? isLayout;
  String? id;
  PageWidgetFieldsEntity? generalFields;
  TranslatableFieldsEntity? translatableFields;
  Map<String, dynamic>? contextualFields;

  PageWidgetEntity({
    this.parentId,
    this.type,
    this.zone,
    this.isLayout,
    this.id,
    this.generalFields,
    this.translatableFields,
    this.contextualFields,
  });
}

class TranslatableFieldsEntity {
  Map<String, dynamic>? title;
  Map<String, dynamic>? slides;
  Map<String, dynamic>? links;

  TranslatableFieldsEntity({
    this.title,
    this.slides,
    this.links,
  });
}

class LocalizationEntity {
  Map<String, dynamic>? title;
  Map<String, dynamic>? links;
  Map<String, dynamic>? slides;

  LocalizationEntity({
    this.title,
    this.links,
    this.slides,
  });
}

class PageWidgetFieldsEntity {
  int? previousSearches;
  int? timerSpeed;
  int? animationSpeed;
  ProductCarouselType? carouselType;
  TopSellersCategoriesSpan? displayProductsFrom;
  List<String>? selectedCategoryIds;
  bool? showImage;
  bool? showTitle;
  bool? showPrice;
  ActionsLayout? layout;
  List<PageSlideEntity>? slides;
  List<PageLinkEntity>? links;

  PageWidgetFieldsEntity({
    this.previousSearches,
    this.slides,
    this.links,
    this.timerSpeed,
    this.animationSpeed,
    this.carouselType,
    this.displayProductsFrom,
    this.selectedCategoryIds,
    this.showImage,
    this.showTitle,
    this.showPrice,
    this.layout,
  });
}

class PageSlideEntity {
  SlideEntity? slide;

  PageSlideEntity({this.slide});
}

class SlideEntity {
  String? image;
  String? link;
  String? background;
  String? heading;
  String? subheading;
  bool? applyDarkOverlayToImage;
  String? backgroundColor;
  String? headingColor;
  String? subheadingColor;
  TextJustification? textAlignment;

  SlideEntity({
    this.image,
    this.link,
    this.background,
    this.heading,
    this.subheading,
    this.applyDarkOverlayToImage,
    this.backgroundColor,
    this.headingColor,
    this.subheadingColor,
    this.textAlignment,
  });
}

class PageLinkEntity {
  FieldsEntity? fields;

  PageLinkEntity({
    this.fields,
  });
}

class FieldsEntity {
  String? icon;
  String? type;
  String? url;
  String? text;
  @JsonKey(name: 'requires_auth')
  bool? requiresAuth;
  FieldsEntity({
    this.icon,
    this.type,
    this.url,
    this.text,
    this.requiresAuth,
  });
}
