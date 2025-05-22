// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_content_management.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageContentManagement _$PageContentManagementFromJson(
        Map<String, dynamic> json) =>
    PageContentManagement(
      page: json['page'] == null
          ? null
          : PageInformation.fromJson(json['page'] as Map<String, dynamic>),
      statusCode: (json['statusCode'] as num?)?.toInt(),
      redirectTo: json['redirectTo'] as String?,
      authorizationFailed: json['authorizationFailed'] as bool?,
      isAuthenticatedOnServer: json['isAuthenticatedOnServer'] as bool?,
      bypassedAuthorization: json['bypassedAuthorization'] as bool?,
      requiresAuthorization: json['requiresAuthorization'] as bool?,
      alternateLanguageUrls:
          json['alternateLanguageUrls'] as Map<String, dynamic>?,
      pageClassicWidget: (json['widgets'] as List<dynamic>?)
          ?.map((e) => PageClassicWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageContentManagementToJson(
    PageContentManagement instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page?.toJson());
  writeNotNull('statusCode', instance.statusCode);
  writeNotNull('redirectTo', instance.redirectTo);
  writeNotNull('authorizationFailed', instance.authorizationFailed);
  writeNotNull('isAuthenticatedOnServer', instance.isAuthenticatedOnServer);
  writeNotNull('bypassedAuthorization', instance.bypassedAuthorization);
  writeNotNull('requiresAuthorization', instance.requiresAuthorization);
  writeNotNull('alternateLanguageUrls', instance.alternateLanguageUrls);
  writeNotNull(
      'widgets', instance.pageClassicWidget?.map((e) => e.toJson()).toList());
  return val;
}

PageInformation _$PageInformationFromJson(Map<String, dynamic> json) =>
    PageInformation(
      nodeId: json['nodeId'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      parentId: json['parentId'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      websiteId: json['websiteId'] as String?,
      variantName: json['variantName'] as String?,
      layoutPageId: json['layoutPageId'] as String?,
      templateHash: json['templateHash'] as String?,
      widgets: (json['widgets'] as List<dynamic>?)
          ?.map((e) => PageWidget.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      generalFields: json['generalFields'] == null
          ? null
          : PageSettings.fromJson(
              json['generalFields'] as Map<String, dynamic>),
      translatableFields: json['translatableFields'] == null
          ? null
          : Localization.fromJson(
              json['translatableFields'] as Map<String, dynamic>),
      contextualFields: json['contextualFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PageInformationToJson(PageInformation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeId', instance.nodeId);
  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  writeNotNull('parentId', instance.parentId);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('websiteId', instance.websiteId);
  writeNotNull('variantName', instance.variantName);
  writeNotNull('layoutPageId', instance.layoutPageId);
  writeNotNull('templateHash', instance.templateHash);
  writeNotNull('widgets', instance.widgets?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  writeNotNull('generalFields', instance.generalFields?.toJson());
  writeNotNull('translatableFields', instance.translatableFields?.toJson());
  writeNotNull('contextualFields', instance.contextualFields);
  return val;
}

PageSettings _$PageSettingsFromJson(Map<String, dynamic> json) => PageSettings(
      hideHeader: json['hideHeader'] as bool?,
      hideFooter: json['hideFooter'] as bool?,
      hideFromSearchEngines: json['hideFromSearchEngines'] as bool?,
      hideFromSiteSearch: json['hideFromSiteSearch'] as bool?,
      hideBreadcrumbs: json['hideBreadcrumbs'] as bool?,
      excludeFromNavigation: json['excludeFromNavigation'] as bool?,
      excludeFromSignInRequired: json['excludeFromSignInRequired'] as bool?,
      variantName: json['variantName'] as String?,
      horizontalRule: json['horizontalRule'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PageSettingsToJson(PageSettings instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hideHeader', instance.hideHeader);
  writeNotNull('hideFooter', instance.hideFooter);
  writeNotNull('hideFromSearchEngines', instance.hideFromSearchEngines);
  writeNotNull('hideFromSiteSearch', instance.hideFromSiteSearch);
  writeNotNull('hideBreadcrumbs', instance.hideBreadcrumbs);
  writeNotNull('excludeFromNavigation', instance.excludeFromNavigation);
  writeNotNull('excludeFromSignInRequired', instance.excludeFromSignInRequired);
  writeNotNull('variantName', instance.variantName);
  writeNotNull('horizontalRule', instance.horizontalRule);
  writeNotNull('tags', instance.tags);
  return val;
}

PageClassicChildWidget _$PageClassicChildWidgetFromJson(
        Map<String, dynamic> json) =>
    PageClassicChildWidget(
      contentKey: (json['contentKey'] as num?)?.toInt(),
      className: json['className'] as String?,
      type: json['type'] as String?,
      icon: json['icon'] as String?,
      childWidgets: (json['childWidgets'] as List<dynamic>?)
              ?.map((e) =>
                  PageClassicChildWidget.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      text: json['text'] as String?,
      url: json['url'] as String?,
      secondaryTextColor: json['secondaryTextColor'] as String?,
      primaryTextColor: json['primaryTextColor'] as String?,
      imageUrl: json['imageUrl'] as String?,
      textJustification: json['textJustification'] as String?,
      applyDarkOverlayToImage: json['applyDarkOverlayToImage'] as bool?,
      primaryText: json['primaryText'] as String?,
      secondaryText: json['secondaryText'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$PageClassicChildWidgetToJson(
    PageClassicChildWidget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentKey', instance.contentKey);
  writeNotNull('className', instance.className);
  writeNotNull(
      'childWidgets', instance.childWidgets?.map((e) => e.toJson()).toList());
  writeNotNull('type', instance.type);
  writeNotNull('icon', instance.icon);
  writeNotNull('text', instance.text);
  writeNotNull('url', instance.url);
  writeNotNull('secondaryTextColor', instance.secondaryTextColor);
  writeNotNull('primaryTextColor', instance.primaryTextColor);
  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('textJustification', instance.textJustification);
  writeNotNull('applyDarkOverlayToImage', instance.applyDarkOverlayToImage);
  writeNotNull('primaryText', instance.primaryText);
  writeNotNull('secondaryText', instance.secondaryText);
  writeNotNull('link', instance.link);
  return val;
}

PageClassicWidget _$PageClassicWidgetFromJson(Map<String, dynamic> json) =>
    PageClassicWidget(
      id: toInt(json['contentKey']),
      type: json['class'] as String?,
      childWidgets: (json['childWidgets'] as List<dynamic>?)
              ?.map((e) =>
                  PageClassicChildWidget.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      displayThumbnailImage: json['displayThumbnailImage'] as bool?,
      displayTopSellersFrom: json['displayTopSellersFrom'] as String?,
      displayAddToCart: json['displayAddToCart'] as bool?,
      numberOfProductsToDisplay:
          (json['numberOfProductsToDisplay'] as num?)?.toInt(),
      displayPartNumbers: json['displayPartNumbers'] as bool?,
      selectedCategoryIds: json['selectedCategoryIds'] as String?,
      title: json['title'] as String?,
      carouselType: json['carouselType'] as String?,
      displayAddToMyLists: json['displayAddToMyLists'] as bool?,
      displayDescription: json['displayDescription'] as bool?,
      displayPrice: json['displayPrice'] as bool?,
      seedWithManuallyAssigned: json['seedWithManuallyAssigned'] as String?,
      cssClass: json['cssClass'] as String?,
      timerSpeed: (json['timerSpeed'] as num?)?.toInt(),
      animationSpeed: (json['animationSpeed'] as num?)?.toInt(),
      numberOfPreviousSearches: toInt(json['numberOfPreviousSearches']),
      addToList: json['addToList'] as bool?,
      saveOrder: json['saveOrder'] as bool?,
      addDiscount: json['addDiscount'] as bool?,
    );

Map<String, dynamic> _$PageClassicWidgetToJson(PageClassicWidget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentKey', instance.id);
  writeNotNull('class', instance.type);
  writeNotNull(
      'childWidgets', instance.childWidgets?.map((e) => e.toJson()).toList());
  writeNotNull('displayThumbnailImage', instance.displayThumbnailImage);
  writeNotNull('displayTopSellersFrom', instance.displayTopSellersFrom);
  writeNotNull('displayAddToCart', instance.displayAddToCart);
  writeNotNull('numberOfProductsToDisplay', instance.numberOfProductsToDisplay);
  writeNotNull('displayPartNumbers', instance.displayPartNumbers);
  writeNotNull('selectedCategoryIds', instance.selectedCategoryIds);
  writeNotNull('title', instance.title);
  writeNotNull('carouselType', instance.carouselType);
  writeNotNull('displayAddToMyLists', instance.displayAddToMyLists);
  writeNotNull('displayDescription', instance.displayDescription);
  writeNotNull('displayPrice', instance.displayPrice);
  writeNotNull('seedWithManuallyAssigned', instance.seedWithManuallyAssigned);
  writeNotNull('cssClass', instance.cssClass);
  writeNotNull('timerSpeed', instance.timerSpeed);
  writeNotNull('animationSpeed', instance.animationSpeed);
  writeNotNull('addToList', instance.addToList);
  writeNotNull('saveOrder', instance.saveOrder);
  writeNotNull('addDiscount', instance.addDiscount);
  writeNotNull('numberOfPreviousSearches', instance.numberOfPreviousSearches);
  return val;
}

PageWidget _$PageWidgetFromJson(Map<String, dynamic> json) => PageWidget(
      parentId: json['parentId'] as String?,
      type: json['type'] as String?,
      zone: json['zone'] as String?,
      isLayout: json['isLayout'] as bool?,
      id: json['id'] as String?,
      generalFields: json['generalFields'] == null
          ? null
          : PageWidgetFields.fromJson(
              json['generalFields'] as Map<String, dynamic>),
      translatableFields: json['translatableFields'] == null
          ? null
          : TranslatableFields.fromJson(
              json['translatableFields'] as Map<String, dynamic>),
      contextualFields: json['contextualFields'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PageWidgetToJson(PageWidget instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parentId', instance.parentId);
  writeNotNull('type', instance.type);
  writeNotNull('zone', instance.zone);
  writeNotNull('isLayout', instance.isLayout);
  writeNotNull('id', instance.id);
  writeNotNull('generalFields', instance.generalFields?.toJson());
  writeNotNull('translatableFields', instance.translatableFields?.toJson());
  writeNotNull('contextualFields', instance.contextualFields);
  return val;
}

TranslatableFields _$TranslatableFieldsFromJson(Map<String, dynamic> json) =>
    TranslatableFields(
      title: json['title'] as Map<String, dynamic>?,
      slides: json['slides'] as Map<String, dynamic>?,
      links: json['links'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TranslatableFieldsToJson(TranslatableFields instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('slides', instance.slides);
  writeNotNull('links', instance.links);
  return val;
}

Localization _$LocalizationFromJson(Map<String, dynamic> json) => Localization(
      title: json['title'] as Map<String, dynamic>?,
      links: json['links'] as Map<String, dynamic>?,
      slides: json['slides'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LocalizationToJson(Localization instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('links', instance.links);
  writeNotNull('slides', instance.slides);
  return val;
}

PageWidgetFields _$PageWidgetFieldsFromJson(Map<String, dynamic> json) =>
    PageWidgetFields(
      previousSearches: toInt(json['previousSearches']),
      showPartNumbers: json['showPartNumbers'] as bool?,
      slides: (json['slides'] as List<dynamic>?)
          ?.map((e) => PageSlide.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => PageLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      timerSpeed: (json['timerSpeed'] as num?)?.toInt(),
      animationSpeed: (json['animationSpeed'] as num?)?.toInt(),
      carouselType: json['carouselType'] as String?,
      displayProductsFrom: json['displayProductsFrom'] as String?,
      selectedCategoryIds: (json['selectedCategoryIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      showImage: json['showImage'] as bool?,
      showTitle: json['showTitle'] as bool?,
      showPrice: json['showPrice'] as bool?,
      layout: json['layout'] as String?,
    );

Map<String, dynamic> _$PageWidgetFieldsToJson(PageWidgetFields instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('previousSearches', instance.previousSearches);
  writeNotNull('timerSpeed', instance.timerSpeed);
  writeNotNull('animationSpeed', instance.animationSpeed);
  writeNotNull('carouselType', instance.carouselType);
  writeNotNull('displayProductsFrom', instance.displayProductsFrom);
  writeNotNull('selectedCategoryIds', instance.selectedCategoryIds);
  writeNotNull('showImage', instance.showImage);
  writeNotNull('showTitle', instance.showTitle);
  writeNotNull('showPrice', instance.showPrice);
  writeNotNull('layout', instance.layout);
  writeNotNull('slides', instance.slides?.map((e) => e.toJson()).toList());
  writeNotNull('links', instance.links?.map((e) => e.toJson()).toList());
  writeNotNull('showPartNumbers', instance.showPartNumbers);
  return val;
}

PageSlide _$PageSlideFromJson(Map<String, dynamic> json) => PageSlide(
      slide: json['fields'] == null
          ? null
          : Slide.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageSlideToJson(PageSlide instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fields', instance.slide?.toJson());
  return val;
}

Slide _$SlideFromJson(Map<String, dynamic> json) => Slide(
      image: json['image'] as String?,
      link: json['link'] as String?,
      background: json['background'] as String?,
      heading: json['heading'] as String?,
      subheading: json['subheading'] as String?,
      applyDarkOverlayToImage: json['applyDarkOverlayToImage'] as bool?,
      backgroundColor: json['backgroundColor'] as String?,
      headingColor: json['headingColor'] as String?,
      subheadingColor: json['subheadingColor'] as String?,
      textAlignment: json['textAlignment'] as String?,
    );

Map<String, dynamic> _$SlideToJson(Slide instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.image);
  writeNotNull('link', instance.link);
  writeNotNull('background', instance.background);
  writeNotNull('heading', instance.heading);
  writeNotNull('subheading', instance.subheading);
  writeNotNull('applyDarkOverlayToImage', instance.applyDarkOverlayToImage);
  writeNotNull('backgroundColor', instance.backgroundColor);
  writeNotNull('headingColor', instance.headingColor);
  writeNotNull('subheadingColor', instance.subheadingColor);
  writeNotNull('textAlignment', instance.textAlignment);
  return val;
}

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageLinkToJson(PageLink instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fields', instance.fields?.toJson());
  return val;
}

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      icon: json['icon'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      text: json['text'] as String?,
      requiresAuth: json['requires_auth'] as bool?,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('icon', instance.icon);
  writeNotNull('type', instance.type);
  writeNotNull('url', instance.url);
  writeNotNull('text', instance.text);
  writeNotNull('requires_auth', instance.requiresAuth);
  return val;
}
