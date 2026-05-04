import 'package:commerce_flutter_sdk/src/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/legacy_configuration_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('LegacyConfigurationEntityMapper', () {
    late LegacyConfigurationEntityMapper mapper;

    setUp(() {
      mapper = LegacyConfigurationEntityMapper();
    });

    test(
        'should correctly map LegacyConfiguration to LegacyConfigurationEntity',
        () {
      // Arrange
      final legacyConfiguration = LegacyConfiguration(
        hasDefaults: true,
        isKit: false,
        configSections: [
          ConfigSection(
            id: 'section_001',
            sectionName: 'Color Options',
            sortOrder: 1,
            sectionOptions: [
              ConfigSectionOption(
                id: 'option_001',
                productId: 'prod_001',
                description: 'Bright red color option',
                price: 25.99,
                selected: true,
                sortOrder: 1,
                name: 'Red',
                quantity: 1,
              ),
              ConfigSectionOption(
                id: 'option_002',
                productId: 'prod_002',
                description: 'Deep blue color option',
                price: 30.50,
                selected: false,
                sortOrder: 2,
                name: 'Blue',
                quantity: 2,
              ),
            ],
          ),
          ConfigSection(
            id: 'section_002',
            sectionName: 'Size Options',
            sortOrder: 2,
            sectionOptions: [
              ConfigSectionOption(
                id: 'option_003',
                productId: 'prod_003',
                description: 'Large size option',
                price: 15.75,
                selected: false,
                sortOrder: 1,
                name: 'Large',
                quantity: 1,
              ),
            ],
          ),
        ],
      );

      // Act
      final result = mapper.toEntity(legacyConfiguration);

      // Assert
      expect(result.hasDefaults, equals(true));
      expect(result.isKit, equals(false));
      expect(result.sections, hasLength(2));

      // Check first section
      expect(result.sections![0].id, equals('section_001'));
      expect(result.sections![0].sectionName, equals('Color Options'));
      expect(result.sections![0].sortOrder, equals(1));
      expect(result.sections![0].options, hasLength(2));

      // Check first option in first section
      expect(result.sections![0].options![0].id, equals('option_001'));
      expect(result.sections![0].options![0].price, equals(25.99));
      expect(result.sections![0].options![0].selected, equals(true));

      // Check second section
      expect(result.sections![1].id, equals('section_002'));
      expect(result.sections![1].sectionName, equals('Size Options'));
      expect(result.sections![1].options, hasLength(1));
    });

    test(
        'should correctly map LegacyConfigurationEntity to LegacyConfiguration',
        () {
      // Arrange
      const legacyConfigurationEntity = LegacyConfigurationEntity(
        hasDefaults: false,
        isKit: true,
        sections: [
          ConfigSectionEntity(
            id: 'section_test',
            sectionName: 'Test Section',
            sortOrder: 1,
            options: [
              ConfigSectionOptionEntity(
                id: 'option_test',
                sectionOptionId: 'so_test',
                sectionName: 'Test Section',
                productName: 'Test Product',
                productId: 'prod_test',
                description: 'Test description',
                price: 99.99,
                userProductPrice: true,
                selected: false,
                sortOrder: 1,
                name: 'Test',
                quantity: 3,
              ),
            ],
          ),
        ],
      );

      // Act
      final result = mapper.toModel(legacyConfigurationEntity);

      // Assert
      expect(result, isNotNull);
      expect(result!.hasDefaults, equals(false));
      expect(result.isKit, equals(true));
      expect(result.configSections, hasLength(1));

      expect(result.configSections![0].id, equals('section_test'));
      expect(result.configSections![0].sectionName, equals('Test Section'));
      expect(result.configSections![0].sortOrder, equals(1));
      expect(result.configSections![0].sectionOptions, hasLength(1));

      expect(
          result.configSections![0].sectionOptions![0].id, equals('option_test'));
      expect(result.configSections![0].sectionOptions![0].price, equals(99.99));
      expect(result.configSections![0].sectionOptions![0].quantity, equals(3));
    });

    test('should handle null LegacyConfiguration', () {
      // Act
      final result = mapper.toEntity(null);

      // Assert
      expect(result.hasDefaults, isNull);
      expect(result.isKit, isNull);
      expect(result.sections, isNull);
    });

    test('should handle null LegacyConfigurationEntity', () {
      // Act
      final result = mapper.toModel(null);

      // Assert
      expect(result, isNull);
    });

    test('should handle LegacyConfiguration with null sections', () {
      // Arrange
      final legacyConfiguration = LegacyConfiguration(
        hasDefaults: true,
        isKit: false,
        configSections: null,
      );

      // Act
      final result = mapper.toEntity(legacyConfiguration);

      // Assert
      expect(result.hasDefaults, equals(true));
      expect(result.isKit, equals(false));
      expect(result.sections, isNull);
    });

    test('should handle empty sections list', () {
      // Arrange
      final legacyConfiguration = LegacyConfiguration(
        hasDefaults: false,
        isKit: true,
        configSections: [],
      );

      // Act
      final result = mapper.toEntity(legacyConfiguration);

      // Assert
      expect(result.hasDefaults, equals(false));
      expect(result.isKit, equals(true));
      expect(result.sections, isEmpty);
    });

    test('should handle complex nested configuration', () {
      // Arrange
      final legacyConfiguration = LegacyConfiguration(
        hasDefaults: true,
        isKit: true,
        configSections: [
          ConfigSection(
            id: 'multi_section_001',
            sectionName: 'Premium Options',
            sortOrder: 1,
            sectionOptions: List.generate(
                5,
                (index) => ConfigSectionOption(
                      id: 'premium_option_$index',
                      productId: 'premium_prod_$index',
                      description:
                          'Premium option number $index with advanced features',
                      price: 100.0 + (index * 25.50),
                      selected: index == 0,
                      sortOrder: index + 1,
                      name: 'Premium $index',
                      quantity: index + 1,
                    )),
          ),
          ConfigSection(
            id: 'basic_section_001',
            sectionName: 'Basic Options',
            sortOrder: 2,
            sectionOptions: List.generate(
                3,
                (index) => ConfigSectionOption(
                      id: 'basic_option_$index',
                      productId: 'basic_prod_$index',
                      description: 'Basic option $index',
                      price: 10.0 + (index * 5.25),
                      selected: false,
                      sortOrder: index + 1,
                      name: 'Basic $index',
                      quantity: 1,
                    )),
          ),
        ],
      );

      // Act
      final result = mapper.toEntity(legacyConfiguration);

      // Assert
      expect(result.hasDefaults, equals(true));
      expect(result.isKit, equals(true));
      expect(result.sections, hasLength(2));

      // Check premium section
      expect(result.sections![0].options, hasLength(5));
      expect(result.sections![0].options![0].price, equals(100.0));
      expect(result.sections![0].options![1].price, equals(125.50));
      expect(result.sections![0].options![2].price, equals(151.0));
      expect(result.sections![0].options![0].selected, equals(true));
      expect(result.sections![0].options![1].selected, equals(false));

      // Check basic section
      expect(result.sections![1].options, hasLength(3));
      expect(result.sections![1].options![0].price, equals(10.0));
      expect(result.sections![1].options![1].price, equals(15.25));
      expect(result.sections![1].options![2].price, equals(20.50));
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalConfiguration = LegacyConfiguration(
        hasDefaults: true,
        isKit: false,
        configSections: [
          ConfigSection(
            id: 'roundtrip_section',
            sectionName: 'Roundtrip Test',
            sortOrder: 1,
            sectionOptions: [
              ConfigSectionOption(
                id: 'roundtrip_option',
                productId: 'rt_prod_001',
                description: 'Testing roundtrip conversion',
                price: 42.75,
                selected: true,
                sortOrder: 1,
                name: 'Roundtrip',
                quantity: 2,
              ),
            ],
          ),
        ],
      );

      // Act
      final entity = mapper.toEntity(originalConfiguration);
      final convertedBack = mapper.toModel(entity);

      // Assert
      expect(convertedBack, isNotNull);
      expect(convertedBack!.hasDefaults,
          equals(originalConfiguration.hasDefaults));
      expect(convertedBack.isKit, equals(originalConfiguration.isKit));
      expect(convertedBack.configSections![0].id,
          equals(originalConfiguration.configSections![0].id));
      expect(convertedBack.configSections![0].sectionOptions![0].price,
          equals(originalConfiguration.configSections![0].sectionOptions![0].price));
      expect(convertedBack.configSections![0].sectionOptions![0].quantity,
          equals(originalConfiguration.configSections![0].sectionOptions![0].quantity));
    });
  });

  group('ConfigSectionEntityMapper', () {
    late ConfigSectionEntityMapper mapper;

    setUp(() {
      mapper = ConfigSectionEntityMapper();
    });

    test('should correctly map ConfigSection to ConfigSectionEntity', () {
      // Arrange
      final configSection = ConfigSection(
        id: 'cs_001',
        sectionName: 'Material Options',
        sortOrder: 3,
        sectionOptions: [
          ConfigSectionOption(
            id: 'material_001',
            productId: 'steel_001',
            description: 'High-grade steel material',
            price: 150.00,
            selected: true,
            sortOrder: 1,
            name: 'Steel',
            quantity: 1,
          ),
        ],
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(result.id, equals('cs_001'));
      expect(result.sectionName, equals('Material Options'));
      expect(result.sortOrder, equals(3));
      expect(result.options, hasLength(1));
      expect(result.options![0].price, equals(150.00));
    });

    test('should correctly map ConfigSectionEntity to ConfigSection', () {
      // Arrange
      const configSectionEntity = ConfigSectionEntity(
        id: 'cse_001',
        sectionName: 'Finish Options',
        sortOrder: 2,
        options: [
          ConfigSectionOptionEntity(
            id: 'finish_001',
            sectionOptionId: 'fin_001',
            sectionName: 'Finish Options',
            productName: 'Matte Finish',
            productId: 'matte_001',
            description: 'Smooth matte finish',
            price: 75.50,
            userProductPrice: true,
            selected: false,
            sortOrder: 1,
            name: 'Matte',
            quantity: 1,
          ),
        ],
      );

      // Act
      final result = mapper.toModel(configSectionEntity);

      // Assert
      expect(result.id, equals('cse_001'));
      expect(result.sectionName, equals('Finish Options'));
      expect(result.sortOrder, equals(2));
      expect(result.sectionOptions, hasLength(1));
      expect(result.sectionOptions![0].price, equals(75.50));
    });

    test('should handle ConfigSection with null options', () {
      // Arrange
      final configSection = ConfigSection(
        id: 'cs_null_options',
        sectionName: 'Empty Section',
        sortOrder: 1,
        sectionOptions: null,
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(result.id, equals('cs_null_options'));
      expect(result.sectionName, equals('Empty Section'));
      expect(result.sortOrder, equals(1));
      expect(result.options, isNull);
    });

    test('should handle ConfigSection with empty options list', () {
      // Arrange
      final configSection = ConfigSection(
        id: 'cs_empty_options',
        sectionName: 'No Options Section',
        sortOrder: 0,
        sectionOptions: [],
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(result.id, equals('cs_empty_options'));
      expect(result.sectionName, equals('No Options Section'));
      expect(result.sortOrder, equals(0));
      expect(result.options, isEmpty);
    });

    test('should handle ConfigSection with null fields', () {
      // Arrange
      final configSection = ConfigSection(
        id: null,
        sectionName: null,
        sortOrder: null,
        sectionOptions: null,
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(result.id, isNull);
      expect(result.sectionName, isNull);
      expect(result.sortOrder, isNull);
      expect(result.options, isNull);
    });

    test('should handle special characters in section name', () {
      // Arrange
      final configSection = ConfigSection(
        id: 'special_chars_section',
        sectionName:
            'Cafe & Restaurant Equipment - "Professional Grade" (Model #2023)',
        sortOrder: 1,
        sectionOptions: [],
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(
          result.sectionName,
          equals(
              'Cafe & Restaurant Equipment - "Professional Grade" (Model #2023)'));
    });
  });

  group('ConfigSectionOptionEntityMapper', () {
    late ConfigSectionOptionEntityMapper mapper;

    setUp(() {
      mapper = ConfigSectionOptionEntityMapper();
    });

    test(
        'should correctly map ConfigSectionOption to ConfigSectionOptionEntity',
        () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: 'cso_001',
        productId: 'warranty_ext_001',
        description: '3-year extended warranty with comprehensive coverage',
        price: 299.99,
        selected: true,
        sortOrder: 1,
        name: 'Extended 3Y',
        quantity: 1,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, equals('cso_001'));
      expect(result.productId, equals('warranty_ext_001'));
      expect(result.description,
          equals('3-year extended warranty with comprehensive coverage'));
      expect(result.price, equals(299.99));
      expect(result.selected, equals(true));
      expect(result.sortOrder, equals(1));
      expect(result.name, equals('Extended 3Y'));
      expect(result.quantity, equals(1));
    });

    test(
        'should correctly map ConfigSectionOptionEntity to ConfigSectionOption',
        () {
      // Arrange
      const configSectionOptionEntity = ConfigSectionOptionEntity(
        id: 'csoe_001',
        sectionOptionId: 'soe_001',
        sectionName: 'Installation Options',
        productName: 'Professional Installation',
        productId: 'install_pro_001',
        description: 'Professional installation by certified technicians',
        price: 199.50,
        userProductPrice: true,
        selected: false,
        sortOrder: 2,
        name: 'Pro Install',
        quantity: 1,
      );

      // Act
      final result = mapper.toModel(configSectionOptionEntity);

      // Assert
      expect(result.id, equals('csoe_001'));
      expect(result.productId, equals('install_pro_001'));
      expect(result.description,
          equals('Professional installation by certified technicians'));
      expect(result.price, equals(199.50));
      expect(result.selected, equals(false));
      expect(result.sortOrder, equals(2));
      expect(result.name, equals('Pro Install'));
      expect(result.quantity, equals(1));
    });

    test('should handle ConfigSectionOption with all null fields', () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: null,
        productId: null,
        description: null,
        price: null,
        selected: null,
        sortOrder: null,
        name: null,
        quantity: null,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, isNull);
      expect(result.productId, isNull);
      expect(result.description, isNull);
      expect(result.price, isNull);
      expect(result.selected, isNull);
      expect(result.sortOrder, isNull);
      expect(result.name, isNull);
      expect(result.quantity, isNull);
    });

    test('should handle different price types correctly', () {
      // Arrange
      final testCases = [
        {'price': 0, 'description': 'zero price'},
        {'price': 0.01, 'description': 'minimal price'},
        {'price': 999.99, 'description': 'high price'},
        {'price': 1234.567, 'description': 'decimal price'},
        {'price': -50.0, 'description': 'negative price (discount)'},
      ];

      for (final testCase in testCases) {
        // Arrange
        final configSectionOption = ConfigSectionOption(
          id: 'price_test_${testCase['price']}',
          productId: 'price_test_prod',
          description: 'Testing ${testCase['description']}',
          price: testCase['price'] as num,
          selected: false,
          sortOrder: 1,
          name: 'Price Test',
          quantity: 1,
        );

        // Act
        final result = mapper.toEntity(configSectionOption);

        // Assert
        expect(result.price, equals(testCase['price']),
            reason: 'Failed for ${testCase['description']}');
        expect(
            result.description, equals('Testing ${testCase['description']}'));
      }
    });

    test('should handle mixed null and non-null fields correctly', () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: 'mixed_null_test',
        productId: 'mixed_prod_001',
        description: 'Some fields are null, others are not',
        price: null,
        selected: null,
        sortOrder: 5,
        name: null,
        quantity: 2.5,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, equals('mixed_null_test'));
      expect(result.productId, equals('mixed_prod_001'));
      expect(
          result.description, equals('Some fields are null, others are not'));
      expect(result.price, isNull);
      expect(result.selected, isNull);
      expect(result.sortOrder, equals(5));
      expect(result.name, isNull);
      expect(result.quantity, equals(2.5));
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalOption = ConfigSectionOption(
        id: 'roundtrip_option',
        productId: 'rt_prod_001',
        description: 'Testing roundtrip conversion for configuration option',
        price: 123.45,
        selected: false,
        sortOrder: 3,
        name: 'Roundtrip Option',
        quantity: 2.75,
      );

      // Act
      final entity = mapper.toEntity(originalOption);
      final convertedBack = mapper.toModel(entity);

      // Assert
      expect(convertedBack.id, equals(originalOption.id));
      expect(convertedBack.productId, equals(originalOption.productId));
      expect(convertedBack.description, equals(originalOption.description));
      expect(convertedBack.price, equals(originalOption.price));
      expect(convertedBack.selected, equals(originalOption.selected));
      expect(convertedBack.sortOrder, equals(originalOption.sortOrder));
      expect(convertedBack.name, equals(originalOption.name));
      expect(convertedBack.quantity, equals(originalOption.quantity));
    });

    test('should handle copyWith functionality correctly', () {
      // Arrange
      const originalEntity = ConfigSectionOptionEntity(
        id: 'copy_test',
        sectionOptionId: 'ct_001',
        sectionName: 'Copy Test Section',
        productName: 'Original Product',
        productId: 'orig_prod_001',
        description: 'Original description',
        price: 50.0,
        userProductPrice: false,
        selected: false,
        sortOrder: 1,
        name: 'Original',
        quantity: 1,
      );

      // Act
      final copiedEntity = originalEntity.copyWith(
        productName: 'Updated Product',
        price: 75.0,
        selected: true,
        quantity: 2,
      );

      // Assert
      expect(copiedEntity.id, equals('copy_test'));
      expect(copiedEntity.sectionOptionId, equals('ct_001'));
      expect(copiedEntity.productName, equals('Updated Product'));
      expect(copiedEntity.productId, equals('orig_prod_001'));
      expect(copiedEntity.description, equals('Original description'));
      expect(copiedEntity.price, equals(75.0));
      expect(copiedEntity.userProductPrice, equals(false));
      expect(copiedEntity.selected, equals(true));
      expect(copiedEntity.sortOrder, equals(1));
      expect(copiedEntity.name, equals('Original'));
      expect(copiedEntity.quantity, equals(2));
    });
  });
}
