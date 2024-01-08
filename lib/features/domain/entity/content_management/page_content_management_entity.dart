import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';

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
  int? timerSpeed;
  int? animationSpeed;
  ProductCarouselType? carouselType;
  TopSellersCategoriesSpan? displayProductsFrom;
  List<String>? selectedCategoryIds;
  bool? showImage;
  bool? showTitle;
  bool? showPrice;
  ActionsLayout? layout;
  

  PageWidgetFieldsEntity({
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

class Slide {
  Map<String, dynamic>? fields;

  Slide({
    this.fields,
  });
}

class Link {
  Map<String, dynamic>? fields;

  Link({
    this.fields,
  });
}
