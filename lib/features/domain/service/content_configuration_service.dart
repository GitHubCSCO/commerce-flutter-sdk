import 'dart:async';
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

  ContentMode currentContentMode = ContentMode.live;
  CMSMode currentCMSMode = CMSMode.classic;

  ContentConfigurationService(this._mobileSpireContentService);
  final IMobileSpireContentService _mobileSpireContentService;

  @override
  Future<Result<PageContentManagementEntity, ErrorResponse>>
      getPersistedLiveContentManagement(PageContentType contentType) {
    // TODO: implement getPersistedLiveContentManagement
    throw UnimplementedError();
  }

  @override
  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadAndPersistLiveContentManagement(PageContentType contentType,
          {bool useCache = true}) {
    // TODO: implement loadAndPersistLiveContentManagement
    throw UnimplementedError();
  }

  @override
  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadPreviewContentManagement(PageContentType contentType,
          {bool useCache = false}) async {
    final String pageKey = getPageKeyForContentType(contentType);

    final result =
        await _mobileSpireContentService.getPageContenManagmentSpire(pageKey);

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
}
