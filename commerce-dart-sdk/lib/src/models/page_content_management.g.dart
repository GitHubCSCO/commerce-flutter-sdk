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
        PageContentManagement instance) =>
    <String, dynamic>{
      if (instance.page?.toJson() case final value?) 'page': value,
      if (instance.statusCode case final value?) 'statusCode': value,
      if (instance.redirectTo case final value?) 'redirectTo': value,
      if (instance.authorizationFailed case final value?)
        'authorizationFailed': value,
      if (instance.isAuthenticatedOnServer case final value?)
        'isAuthenticatedOnServer': value,
      if (instance.bypassedAuthorization case final value?)
        'bypassedAuthorization': value,
      if (instance.requiresAuthorization case final value?)
        'requiresAuthorization': value,
      if (instance.alternateLanguageUrls case final value?)
        'alternateLanguageUrls': value,
      if (instance.pageClassicWidget?.map((e) => e.toJson()).toList()
          case final value?)
        'widgets': value,
    };

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

Map<String, dynamic> _$PageInformationToJson(PageInformation instance) =>
    <String, dynamic>{
      if (instance.nodeId case final value?) 'nodeId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.type case final value?) 'type': value,
      if (instance.parentId case final value?) 'parentId': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.websiteId case final value?) 'websiteId': value,
      if (instance.variantName case final value?) 'variantName': value,
      if (instance.layoutPageId case final value?) 'layoutPageId': value,
      if (instance.templateHash case final value?) 'templateHash': value,
      if (instance.widgets?.map((e) => e.toJson()).toList() case final value?)
        'widgets': value,
      if (instance.id case final value?) 'id': value,
      if (instance.generalFields?.toJson() case final value?)
        'generalFields': value,
      if (instance.translatableFields?.toJson() case final value?)
        'translatableFields': value,
      if (instance.contextualFields case final value?)
        'contextualFields': value,
    };

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

Map<String, dynamic> _$PageSettingsToJson(PageSettings instance) =>
    <String, dynamic>{
      if (instance.hideHeader case final value?) 'hideHeader': value,
      if (instance.hideFooter case final value?) 'hideFooter': value,
      if (instance.hideFromSearchEngines case final value?)
        'hideFromSearchEngines': value,
      if (instance.hideFromSiteSearch case final value?)
        'hideFromSiteSearch': value,
      if (instance.hideBreadcrumbs case final value?) 'hideBreadcrumbs': value,
      if (instance.excludeFromNavigation case final value?)
        'excludeFromNavigation': value,
      if (instance.excludeFromSignInRequired case final value?)
        'excludeFromSignInRequired': value,
      if (instance.variantName case final value?) 'variantName': value,
      if (instance.horizontalRule case final value?) 'horizontalRule': value,
      if (instance.tags case final value?) 'tags': value,
    };

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
        PageClassicChildWidget instance) =>
    <String, dynamic>{
      if (instance.contentKey case final value?) 'contentKey': value,
      if (instance.className case final value?) 'className': value,
      if (instance.childWidgets?.map((e) => e.toJson()).toList()
          case final value?)
        'childWidgets': value,
      if (instance.type case final value?) 'type': value,
      if (instance.icon case final value?) 'icon': value,
      if (instance.text case final value?) 'text': value,
      if (instance.url case final value?) 'url': value,
      if (instance.secondaryTextColor case final value?)
        'secondaryTextColor': value,
      if (instance.primaryTextColor case final value?)
        'primaryTextColor': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.textJustification case final value?)
        'textJustification': value,
      if (instance.applyDarkOverlayToImage case final value?)
        'applyDarkOverlayToImage': value,
      if (instance.primaryText case final value?) 'primaryText': value,
      if (instance.secondaryText case final value?) 'secondaryText': value,
      if (instance.link case final value?) 'link': value,
    };

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

Map<String, dynamic> _$PageClassicWidgetToJson(PageClassicWidget instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'contentKey': value,
      if (instance.type case final value?) 'class': value,
      if (instance.childWidgets?.map((e) => e.toJson()).toList()
          case final value?)
        'childWidgets': value,
      if (instance.displayThumbnailImage case final value?)
        'displayThumbnailImage': value,
      if (instance.displayTopSellersFrom case final value?)
        'displayTopSellersFrom': value,
      if (instance.displayAddToCart case final value?)
        'displayAddToCart': value,
      if (instance.numberOfProductsToDisplay case final value?)
        'numberOfProductsToDisplay': value,
      if (instance.displayPartNumbers case final value?)
        'displayPartNumbers': value,
      if (instance.selectedCategoryIds case final value?)
        'selectedCategoryIds': value,
      if (instance.title case final value?) 'title': value,
      if (instance.carouselType case final value?) 'carouselType': value,
      if (instance.displayAddToMyLists case final value?)
        'displayAddToMyLists': value,
      if (instance.displayDescription case final value?)
        'displayDescription': value,
      if (instance.displayPrice case final value?) 'displayPrice': value,
      if (instance.seedWithManuallyAssigned case final value?)
        'seedWithManuallyAssigned': value,
      if (instance.cssClass case final value?) 'cssClass': value,
      if (instance.timerSpeed case final value?) 'timerSpeed': value,
      if (instance.animationSpeed case final value?) 'animationSpeed': value,
      if (instance.addToList case final value?) 'addToList': value,
      if (instance.saveOrder case final value?) 'saveOrder': value,
      if (instance.addDiscount case final value?) 'addDiscount': value,
      if (instance.numberOfPreviousSearches case final value?)
        'numberOfPreviousSearches': value,
    };

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

Map<String, dynamic> _$PageWidgetToJson(PageWidget instance) =>
    <String, dynamic>{
      if (instance.parentId case final value?) 'parentId': value,
      if (instance.type case final value?) 'type': value,
      if (instance.zone case final value?) 'zone': value,
      if (instance.isLayout case final value?) 'isLayout': value,
      if (instance.id case final value?) 'id': value,
      if (instance.generalFields?.toJson() case final value?)
        'generalFields': value,
      if (instance.translatableFields?.toJson() case final value?)
        'translatableFields': value,
      if (instance.contextualFields case final value?)
        'contextualFields': value,
    };

TranslatableFields _$TranslatableFieldsFromJson(Map<String, dynamic> json) =>
    TranslatableFields(
      title: json['title'] as Map<String, dynamic>?,
      slides: json['slides'] as Map<String, dynamic>?,
      links: json['links'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TranslatableFieldsToJson(TranslatableFields instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.slides case final value?) 'slides': value,
      if (instance.links case final value?) 'links': value,
    };

Localization _$LocalizationFromJson(Map<String, dynamic> json) => Localization(
      title: json['title'] as Map<String, dynamic>?,
      links: json['links'] as Map<String, dynamic>?,
      slides: json['slides'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LocalizationToJson(Localization instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.links case final value?) 'links': value,
      if (instance.slides case final value?) 'slides': value,
    };

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

Map<String, dynamic> _$PageWidgetFieldsToJson(PageWidgetFields instance) =>
    <String, dynamic>{
      if (instance.previousSearches case final value?)
        'previousSearches': value,
      if (instance.timerSpeed case final value?) 'timerSpeed': value,
      if (instance.animationSpeed case final value?) 'animationSpeed': value,
      if (instance.carouselType case final value?) 'carouselType': value,
      if (instance.displayProductsFrom case final value?)
        'displayProductsFrom': value,
      if (instance.selectedCategoryIds case final value?)
        'selectedCategoryIds': value,
      if (instance.showImage case final value?) 'showImage': value,
      if (instance.showTitle case final value?) 'showTitle': value,
      if (instance.showPrice case final value?) 'showPrice': value,
      if (instance.layout case final value?) 'layout': value,
      if (instance.slides?.map((e) => e.toJson()).toList() case final value?)
        'slides': value,
      if (instance.links?.map((e) => e.toJson()).toList() case final value?)
        'links': value,
      if (instance.showPartNumbers case final value?) 'showPartNumbers': value,
    };

PageSlide _$PageSlideFromJson(Map<String, dynamic> json) => PageSlide(
      slide: json['fields'] == null
          ? null
          : Slide.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageSlideToJson(PageSlide instance) => <String, dynamic>{
      if (instance.slide?.toJson() case final value?) 'fields': value,
    };

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

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      if (instance.image case final value?) 'image': value,
      if (instance.link case final value?) 'link': value,
      if (instance.background case final value?) 'background': value,
      if (instance.heading case final value?) 'heading': value,
      if (instance.subheading case final value?) 'subheading': value,
      if (instance.applyDarkOverlayToImage case final value?)
        'applyDarkOverlayToImage': value,
      if (instance.backgroundColor case final value?) 'backgroundColor': value,
      if (instance.headingColor case final value?) 'headingColor': value,
      if (instance.subheadingColor case final value?) 'subheadingColor': value,
      if (instance.textAlignment case final value?) 'textAlignment': value,
    };

PageLink _$PageLinkFromJson(Map<String, dynamic> json) => PageLink(
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PageLinkToJson(PageLink instance) => <String, dynamic>{
      if (instance.fields?.toJson() case final value?) 'fields': value,
    };

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      icon: json['icon'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      text: json['text'] as String?,
      requiresAuth: json['requires_auth'] as bool?,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      if (instance.icon case final value?) 'icon': value,
      if (instance.type case final value?) 'type': value,
      if (instance.url case final value?) 'url': value,
      if (instance.text case final value?) 'text': value,
      if (instance.requiresAuth case final value?) 'requires_auth': value,
    };
