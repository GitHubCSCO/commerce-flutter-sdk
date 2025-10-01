import 'models.dart';
part 'page_content_management.g.dart';

@JsonSerializable()
class PageContentManagement {
  PageInformation? page;
  int? statusCode;
  String? redirectTo;
  bool? authorizationFailed;
  bool? isAuthenticatedOnServer;
  bool? bypassedAuthorization;
  bool? requiresAuthorization;
  Map<String, dynamic>? alternateLanguageUrls;
  @JsonKey(name: 'widgets')
  List<PageClassicWidget>? pageClassicWidget;

  PageContentManagement(
      {this.page,
      this.statusCode,
      this.redirectTo,
      this.authorizationFailed,
      this.isAuthenticatedOnServer,
      this.bypassedAuthorization,
      this.requiresAuthorization,
      this.alternateLanguageUrls,
      this.pageClassicWidget});

  factory PageContentManagement.fromJson(Map<String, dynamic> json) =>
      _$PageContentManagementFromJson(json);
  Map<String, dynamic> toJson() => _$PageContentManagementToJson(this);
}

@JsonSerializable()
class PageInformation {
  String? nodeId;
  String? name;
  String? type;
  String? parentId;
  int? sortOrder;
  String? websiteId;
  String? variantName;
  String? layoutPageId;
  String? templateHash;
  List<PageWidget>? widgets;
  String? id;
  PageSettings? generalFields;
  Localization? translatableFields;
  Map<String, dynamic>? contextualFields;

  PageInformation({
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

  factory PageInformation.fromJson(Map<String, dynamic> json) =>
      _$PageInformationFromJson(json);
  Map<String, dynamic> toJson() => _$PageInformationToJson(this);
}

@JsonSerializable()
class PageSettings {
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

  PageSettings({
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

  factory PageSettings.fromJson(Map<String, dynamic> json) =>
      _$PageSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$PageSettingsToJson(this);
}

@JsonSerializable()
class PageClassicChildWidget {
  int? contentKey;
  String? className;
  List<PageClassicChildWidget>? childWidgets;
  String? type;
  String? icon;

  // Added unique fields
  String? text;
  String? url;
  String? secondaryTextColor;
  String? primaryTextColor;
  String? imageUrl;
  String? textJustification;
  bool? applyDarkOverlayToImage;
  String? primaryText;
  String? secondaryText;
  String? link;

  PageClassicChildWidget(
      {this.contentKey,
      this.className,
      this.type,
      this.icon,
      this.childWidgets = const [],
      this.text,
      this.url,
      this.secondaryTextColor,
      this.primaryTextColor,
      this.imageUrl,
      this.textJustification,
      this.applyDarkOverlayToImage,
      this.primaryText,
      this.secondaryText,
      this.link});

  factory PageClassicChildWidget.fromJson(Map<String, dynamic> json) =>
      _$PageClassicChildWidgetFromJson(json);
  Map<String, dynamic> toJson() => _$PageClassicChildWidgetToJson(this);
}

@JsonSerializable()
class PageClassicWidget {
  @JsonKey(name: 'contentKey', fromJson: toInt)
  int? id;

  @JsonKey(name: 'class')
  String? type;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? subType;

  @JsonKey(name: 'childWidgets')
  List<PageClassicChildWidget>? childWidgets;

  // Added unique fields
  bool? displayThumbnailImage;
  String? displayTopSellersFrom;
  bool? displayAddToCart;
  int? numberOfProductsToDisplay;
  bool? displayPartNumbers;
  String? selectedCategoryIds;
  String? title;
  String? carouselType;
  bool? displayAddToMyLists;
  bool? displayDescription;
  bool? displayPrice;
  String? seedWithManuallyAssigned;
  String? cssClass;
  int? timerSpeed;
  int? animationSpeed;
  bool? addToList;
  bool? saveOrder;
  bool? addDiscount;

  @JsonKey(fromJson: toInt)
  int? numberOfPreviousSearches;

  PageClassicWidget(
      {this.id,
      this.type,
      this.subType = '',
      this.childWidgets = const [],
      this.displayThumbnailImage,
      this.displayTopSellersFrom,
      this.displayAddToCart,
      this.numberOfProductsToDisplay,
      this.displayPartNumbers,
      this.selectedCategoryIds,
      this.title,
      this.carouselType,
      this.displayAddToMyLists,
      this.displayDescription,
      this.displayPrice,
      this.seedWithManuallyAssigned,
      this.cssClass,
      this.timerSpeed,
      this.animationSpeed,
      this.numberOfPreviousSearches,
      this.addToList,
      this.saveOrder,
      this.addDiscount});

  factory PageClassicWidget.fromJson(Map<String, dynamic> json) =>
      _$PageClassicWidgetFromJson(json);
  Map<String, dynamic> toJson() => _$PageClassicWidgetToJson(this);
}

@JsonSerializable()
class PageWidget {
  String? parentId;
  String? type;
  String? zone;
  bool? isLayout;
  String? id;
  PageWidgetFields? generalFields;
  TranslatableFields? translatableFields;
  Map<String, dynamic>? contextualFields;

  PageWidget({
    this.parentId,
    this.type,
    this.zone,
    this.isLayout,
    this.id,
    this.generalFields,
    this.translatableFields,
    this.contextualFields,
  });

  factory PageWidget.fromJson(Map<String, dynamic> json) =>
      _$PageWidgetFromJson(json);
  Map<String, dynamic> toJson() => _$PageWidgetToJson(this);
}

@JsonSerializable()
class TranslatableFields {
  Map<String, dynamic>? title;
  Map<String, dynamic>? slides;
  Map<String, dynamic>? links;

  TranslatableFields({
    this.title,
    this.slides,
    this.links,
  });

  factory TranslatableFields.fromJson(Map<String, dynamic> json) =>
      _$TranslatableFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$TranslatableFieldsToJson(this);
}

@JsonSerializable()
class Localization {
  Map<String, dynamic>? title;
  Map<String, dynamic>? links;
  Map<String, dynamic>? slides;

  Localization({
    this.title,
    this.links,
    this.slides,
  });

  factory Localization.fromJson(Map<String, dynamic> json) =>
      _$LocalizationFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizationToJson(this);
}

int toInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String && value == "") {
    return 0;
  } else if (value is String) {
    return int.parse(value);
  }

  return 0;
}

@JsonSerializable()
class PageWidgetFields {
  @JsonKey(fromJson: toInt)
  int? previousSearches;
  int? timerSpeed;
  int? animationSpeed;
  String? carouselType;
  String? displayProductsFrom;
  List<String>? selectedCategoryIds;
  bool? showImage;
  bool? showTitle;
  bool? showPrice;
  String? layout;
  List<PageSlide>? slides;
  List<PageLink>? links;
  bool? showPartNumbers;

  PageWidgetFields({
    this.previousSearches,
    this.showPartNumbers,
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

  factory PageWidgetFields.fromJson(Map<String, dynamic> json) =>
      _$PageWidgetFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$PageWidgetFieldsToJson(this);
}

@JsonSerializable()
class PageSlide {
  @JsonKey(name: 'fields')
  Slide? slide;

  PageSlide({this.slide});

  factory PageSlide.fromJson(Map<String, dynamic> json) =>
      _$PageSlideFromJson(json);
  Map<String, dynamic> toJson() => _$PageSlideToJson(this);
}

@JsonSerializable()
class Slide {
  String? image;
  String? link;
  String? background;
  String? heading;
  String? subheading;
  bool? applyDarkOverlayToImage;
  String? backgroundColor;
  String? headingColor;
  String? subheadingColor;
  String? textAlignment;

  Slide({
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

  factory Slide.fromJson(Map<String, dynamic> json) => _$SlideFromJson(json);
  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable()
class PageLink {
  Fields? fields;

  PageLink({
    this.fields,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) =>
      _$PageLinkFromJson(json);
  Map<String, dynamic> toJson() => _$PageLinkToJson(this);
}

@JsonSerializable()
class Fields {
  String? icon;
  String? type;
  String? url;
  String? text;
  @JsonKey(name: 'requires_auth')
  bool? requiresAuth;
  Fields({
    this.icon,
    this.type,
    this.url,
    this.text,
    this.requiresAuth,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);
  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
