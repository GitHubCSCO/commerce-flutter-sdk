import 'package:commerce_flutter_sdk/src/features/domain/mapper/content_management/page_management_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  final mapper = PageContentManagementMapper();

  group('PageContentManagementMapper', () {
    test(
        'should map PageContentManagement to PageContentManagementEntity correctly',
        () {
      // Arrange
      final pageContentManagement = PageContentManagement(
        page: PageInformation(
          nodeId: "123",
          name: "Test Page",
          type: "Standard",
          parentId: "0",
          sortOrder: 1,
          websiteId: "456",
          variantName: "A",
          layoutPageId: "789",
          templateHash: "hash123",
          widgets: [],
          id: "page_001",
          generalFields: PageSettings(
            hideHeader: false,
            hideFooter: true,
            hideFromSearchEngines: false,
            hideFromSiteSearch: true,
            hideBreadcrumbs: false,
            excludeFromNavigation: true,
            excludeFromSignInRequired: false,
            variantName: "Variant A",
            horizontalRule: "solid",
            tags: ["tag1", "tag2"],
          ),
          translatableFields: Localization(
            title: {"en": "Localized Title", "fr": "Titre Localisé"},
            links: {"en": "link1", "fr": "lien1"},
            slides: {"en": "slide1", "fr": "diapositive1"},
          ),
          contextualFields: {"key": "value"},
        ),
        statusCode: 200,
        redirectTo: "/home",
        authorizationFailed: false,
        isAuthenticatedOnServer: true,
        bypassedAuthorization: false,
        requiresAuthorization: true,
        alternateLanguageUrls: {"en": "/en/home", "fr": "/fr/accueil"},
        pageClassicWidget: [],
      );

      // Act
      final result = mapper.toEntity(pageContentManagement);

      // Assert
      expect(result.page?.nodeId, "123");
      expect(result.page?.name, "Test Page");
      expect(result.statusCode, 200);
      expect(result.redirectTo, "/home");
      expect(result.authorizationFailed, false);
      expect(result.isAuthenticatedOnServer, true);
      expect(result.requiresAuthorization, true);
      expect(result.alternateLanguageUrls,
          {"en": "/en/home", "fr": "/fr/accueil"});
      expect(result.page?.generalFields?.hideFooter, true);
      expect(result.page?.generalFields?.tags, ["tag1", "tag2"]);
      expect(result.page?.translatableFields?.title,
          {"en": "Localized Title", "fr": "Titre Localisé"});
      expect(result.page?.translatableFields?.links,
          {"en": "link1", "fr": "lien1"});
      expect(result.page?.translatableFields?.slides,
          {"en": "slide1", "fr": "diapositive1"});
    });

    test('should handle null values correctly', () {
      // Arrange
      final pageContentManagement = PageContentManagement(
        page: null,
        statusCode: 404,
        redirectTo: null,
        authorizationFailed: true,
        isAuthenticatedOnServer: false,
        bypassedAuthorization: false,
        requiresAuthorization: false,
        alternateLanguageUrls: null,
        pageClassicWidget: [],
      );

      // Act
      final result = mapper.toEntity(pageContentManagement);

      // Assert
      expect(result.page, isNull);
      expect(result.statusCode, 404);
      expect(result.redirectTo, isNull);
      expect(result.authorizationFailed, true);
      expect(result.isAuthenticatedOnServer, false);
      expect(result.requiresAuthorization, false);
      expect(result.alternateLanguageUrls, isNull);
    });

    test('should handle empty maps in Localization correctly', () {
      // Arrange
      final pageContentManagement = PageContentManagement(
        page: PageInformation(
          nodeId: "123",
          name: "Test Page",
          type: "Standard",
          parentId: "0",
          sortOrder: 1,
          websiteId: "456",
          variantName: "A",
          layoutPageId: "789",
          templateHash: "hash123",
          widgets: [],
          id: "page_001",
          generalFields: PageSettings(
            hideHeader: false,
            hideFooter: true,
            hideFromSearchEngines: false,
            hideFromSiteSearch: true,
            hideBreadcrumbs: false,
            excludeFromNavigation: true,
            excludeFromSignInRequired: false,
            variantName: "Variant A",
            horizontalRule: "solid",
            tags: ["tag1", "tag2"],
          ),
          translatableFields: Localization(
            title: {},
            links: {},
            slides: {},
          ),
          contextualFields: {"key": "value"},
        ),
        statusCode: 200,
        redirectTo: "/home",
        authorizationFailed: false,
        isAuthenticatedOnServer: true,
        bypassedAuthorization: false,
        requiresAuthorization: true,
        alternateLanguageUrls: {},
        pageClassicWidget: [],
      );

      // Act
      final result = mapper.toEntity(pageContentManagement);

      // Assert
      expect(result.page?.nodeId, "123");
      expect(result.page?.name, "Test Page");
      expect(result.statusCode, 200);
      expect(result.redirectTo, "/home");
      expect(result.authorizationFailed, false);
      expect(result.isAuthenticatedOnServer, true);
      expect(result.requiresAuthorization, true);
      expect(result.alternateLanguageUrls, {});
      expect(result.page?.translatableFields?.title, {});
      expect(result.page?.translatableFields?.links, {});
      expect(result.page?.translatableFields?.slides, {});
    });
  });
}
