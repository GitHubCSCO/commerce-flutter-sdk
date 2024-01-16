import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:commerce_flutter_app/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/cms_mode.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_mode.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:commerce_flutter_app/features/domain/mapper/content_management/page_management_mapper.dart';
import 'package:commerce_flutter_app/features/domain/service/content_configuration_service_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ContentConfigurationService implements IContentConfigurationService {
  static const String shopContentPageName = "shop";
  static const String shopContentManagementPersistenceKey =
      "ShopContentManagementPersistenceKey";
  static const String searchLandingContentPageName = "search";
  static const String searchLandingContentManagementPersistenceKey =
      "SearchLandingContentManagementPersistenceKey";
  static const String accountContentPageName = "account";
  static const String accountContentManagementPersistenceKey =
      "AccountContentManagementPersistenceKey";
  static const String vmiMainContentPageName = "vmimain";
  static const String vmiMainContentManagementPersistenceKey =
      "VmiMainContentManagementPersistenceKey";

  static const String switchContentModeFormatUri =
      "/contentadmin/shell/switchtocontentmode?contentmode={0}";
  static const String switchSpireContentModeFormatUri =
      "/api/internal/contentAdmin/SwitchContentMode?ContentMode={0}";

  ContentConfigurationService(this._mobileSpireContentService,
      this._cacheService, this._mobileContentService);
  final IMobileSpireContentService _mobileSpireContentService;
  final IMobileContentService _mobileContentService;
  final ICacheService _cacheService;

  final Cookie cmsCurrentContentModeViewingCookie =
      Cookie("cms_CurrentContentMode", "Viewing");
  final Cookie cmsCurrentContentModeEditingCookie =
      Cookie("cms_CurrentContentMode", "Previewing");
  final Cookie cmsCurrentContentModeSignartureCookieDelete =
      Cookie("cms_CurrentContentModeSignature", "");
  final Cookie cmsCurrentContentModeCookieDelete =
      Cookie("cms_CurrentContentMode", "");

  ContentMode currentContentMode = ContentMode.live;
  CMSMode currentCMSMode = CMSMode.classic;

  final Cookie cmsCurrentContentModeSignartureCookie = Cookie('', '');

  @override
  Future<PageContentManagement> getPersistedLiveContentManagement(
      PageContentType contentType) async {
    final persistenceKey = getPersistenceKeyForContentType(contentType);
    var persistedBytes =
        await _cacheService.loadPersistedBytesData(persistenceKey);
    if (persistedBytes.isNotEmpty) {
      var stringResponse = utf8.decode(persistedBytes);
      if (stringResponse.isNotEmpty) {
        var json = jsonDecode(stringResponse);
        var pageContentManagement = PageContentManagement.fromJson(json);
        return pageContentManagement;
      }
    }
    return PageContentManagement();
  }

  @override
  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadAndPersistLiveContentManagement(PageContentType contentType,
          {bool useCache = true}) async {
    final result =
        await getPageContentManagmentDataRepresentationForContentType(
            contentType, useCache);
    switch (result) {
      case Success(value: final value):
        {
          if (value != null) {
            final pageContentManagementEntity =
                PageContentManagementMapper().toEntity(value);

            persistContentManagementData(value, contentType);
            return Success(pageContentManagementEntity);
          } else {
            final persistedConternManagement =
                await getPersistedLiveContentManagement(contentType);
            final pageContentManagementEntity = PageContentManagementMapper()
                .toEntity(persistedConternManagement);
            return Success(pageContentManagementEntity);
          }
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadPreviewContentManagement(PageContentType contentType,
          {bool useCache = false}) async {
    final result =
        await getPageContentManagmentDataRepresentationForContentType(
            contentType, useCache);
    switch (result) {
      case Success(value: final value):
        {
          final pageContentManagementEntity = PageContentManagementMapper()
              .toEntity(value ?? PageContentManagement());
          return Success(pageContentManagementEntity);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  Future<Result<PageContentManagement, ErrorResponse>>
      getPageContentManagmentDataRepresentationForContentType(
          PageContentType contentType, bool useCache) async {
    final String pageKey = getPageKeyForContentType(contentType);
    var response =
        await _mobileSpireContentService.getPageContenManagmentSpire(pageKey);
    switch (response) {
      case Success(value: final value):
        {
          if (value != null && value.page != null) {
            currentCMSMode = CMSMode.spire;
            return Success(value);
          } else {
            var classicResponse = await _mobileContentService
                .getPageContentManagementClassic(pageKey);

            switch (classicResponse) {
              case Success(value: final value):
                {
                  return Success(value);
                }

              case Failure(errorResponse: final errorResponse):
                {
                  return Failure(errorResponse);
                }
            }
          }
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  String getPageKeyForContentType(PageContentType contentType) {
    switch (contentType) {
      case PageContentType.shop:
        return shopContentPageName;
      case PageContentType.searchLanding:
        return searchLandingContentPageName;
      case PageContentType.account:
        return accountContentPageName;
      case PageContentType.vmiMain:
        return vmiMainContentPageName;
      default:
        return '';
    }
  }

  String getPersistenceKeyForContentType(PageContentType contentType) {
    switch (contentType) {
      case PageContentType.shop:
        return shopContentManagementPersistenceKey;
      case PageContentType.searchLanding:
        return searchLandingContentManagementPersistenceKey;
      case PageContentType.account:
        return accountContentManagementPersistenceKey;
      case PageContentType.vmiMain:
        return vmiMainContentManagementPersistenceKey;
      default:
        return '';
    }
  }

  void persistContentManagementData(
      PageContentManagement response, PageContentType contentType) {
    var json = response.toJson();
    var jsonString = jsonEncode(json);
    Uint8List bytes = Uint8List.fromList(utf8.encode(jsonString));
    var persistenceKey = getPersistenceKeyForContentType(contentType);
    _cacheService.persistBytesData(persistenceKey, bytes);
  }
}
