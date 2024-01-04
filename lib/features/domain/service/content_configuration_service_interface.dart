import 'dart:async';

import 'package:commerce_flutter_app/features/domain/entity/content_management/page_content_management_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_mode.dart';
import 'package:commerce_flutter_app/features/domain/enums/content_type.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IContentConfigurationService {
  ContentMode get currentContentMode;

  Future<Result<PageContentManagementEntity, ErrorResponse>>
      getPersistedLiveContentManagement(ContentType contentType);

  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadAndPersistLiveContentManagement(ContentType contentType,
          {bool useCache = true});

  Future<Result<PageContentManagementEntity, ErrorResponse>>
      loadPreviewContentManagement(ContentType contentType,
          {bool useCache = false});
}
