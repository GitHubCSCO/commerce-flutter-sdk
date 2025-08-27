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
        sections: [
          ConfigSection(
            id: 'section_001',
            sectionName: 'Color Options',
            sortOrder: 1,
            options: [
              ConfigSectionOption(
                id: 'option_001',
                sectionOptionId: 'so_001',
                sectionName: 'Color Options',
                productName: 'Red Variant',
                productId: 'prod_001',
                description: 'Bright red color option',
                price: 25.99,
                userProductPrice: false,
                selected: true,
                sortOrder: 1,
                name: 'Red',
                quantity: 1,
              ),
              ConfigSectionOption(
                id: 'option_002',
                sectionOptionId: 'so_002',
                sectionName: 'Color Options',
                productName: 'Blue Variant',
                productId: 'prod_002',
                description: 'Deep blue color option',
                price: 30.50,
                userProductPrice: true,
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
            options: [
              ConfigSectionOption(
                id: 'option_003',
                sectionOptionId: 'so_003',
                sectionName: 'Size Options',
                productName: 'Large Size',
                productId: 'prod_003',
                description: 'Large size option',
                price: 15.75,
                userProductPrice: false,
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
      expect(result.sections![0].options![0].sectionOptionId, equals('so_001'));
      expect(
          result.sections![0].options![0].productName, equals('Red Variant'));
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
      expect(result.sections, hasLength(1));

      expect(result.sections![0].id, equals('section_test'));
      expect(result.sections![0].sectionName, equals('Test Section'));
      expect(result.sections![0].sortOrder, equals(1));
      expect(result.sections![0].options, hasLength(1));

      expect(result.sections![0].options![0].id, equals('option_test'));
      expect(
          result.sections![0].options![0].productName, equals('Test Product'));
      expect(result.sections![0].options![0].price, equals(99.99));
      expect(result.sections![0].options![0].quantity, equals(3));
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
        sections: null,
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
        sections: [],
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
        sections: [
          ConfigSection(
            id: 'multi_section_001',
            sectionName: 'Premium Options',
            sortOrder: 1,
            options: List.generate(
                5,
                (index) => ConfigSectionOption(
                      id: 'premium_option_$index',
                      sectionOptionId: 'po_$index',
                      sectionName: 'Premium Options',
                      productName: 'Premium Product $index',
                      productId: 'premium_prod_$index',
                      description:
                          'Premium option number $index with advanced features',
                      price: 100.0 + (index * 25.50),
                      userProductPrice: index % 2 == 0,
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
            options: List.generate(
                3,
                (index) => ConfigSectionOption(
                      id: 'basic_option_$index',
                      sectionOptionId: 'bo_$index',
                      sectionName: 'Basic Options',
                      productName: 'Basic Product $index',
                      productId: 'basic_prod_$index',
                      description: 'Basic option $index',
                      price: 10.0 + (index * 5.25),
                      userProductPrice: false,
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
        sections: [
          ConfigSection(
            id: 'roundtrip_section',
            sectionName: 'Roundtrip Test',
            sortOrder: 1,
            options: [
              ConfigSectionOption(
                id: 'roundtrip_option',
                sectionOptionId: 'rt_001',
                sectionName: 'Roundtrip Test',
                productName: 'Roundtrip Product',
                productId: 'rt_prod_001',
                description: 'Testing roundtrip conversion',
                price: 42.75,
                userProductPrice: true,
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
      expect(convertedBack.sections![0].id,
          equals(originalConfiguration.sections![0].id));
      expect(convertedBack.sections![0].options![0].price,
          equals(originalConfiguration.sections![0].options![0].price));
      expect(convertedBack.sections![0].options![0].quantity,
          equals(originalConfiguration.sections![0].options![0].quantity));
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
        options: [
          ConfigSectionOption(
            id: 'material_001',
            sectionOptionId: 'mat_001',
            sectionName: 'Material Options',
            productName: 'Steel Material',
            productId: 'steel_001',
            description: 'High-grade steel material',
            price: 150.00,
            userProductPrice: false,
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
      expect(result.options![0].productName, equals('Steel Material'));
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
      expect(result.options, hasLength(1));
      expect(result.options![0].productName, equals('Matte Finish'));
      expect(result.options![0].price, equals(75.50));
    });

    test('should handle ConfigSection with null options', () {
      // Arrange
      final configSection = ConfigSection(
        id: 'cs_null_options',
        sectionName: 'Empty Section',
        sortOrder: 1,
        options: null,
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
        options: [],
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
        options: null,
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
            'Café & Restaurant Equipment - "Professional Grade" (Model #2023)',
        sortOrder: 1,
        options: [],
      );

      // Act
      final result = mapper.toEntity(configSection);

      // Assert
      expect(
          result.sectionName,
          equals(
              'Café & Restaurant Equipment - "Professional Grade" (Model #2023)'));
    });

    test('should handle negative and large sort orders', () {
      // Arrange
      final testCases = [
        {'sortOrder': -5, 'description': 'negative sort order'},
        {'sortOrder': 0, 'description': 'zero sort order'},
        {'sortOrder': 999999, 'description': 'very large sort order'},
      ];

      for (final testCase in testCases) {
        // Arrange
        final configSection = ConfigSection(
          id: 'sort_test_${testCase['sortOrder']}',
          sectionName: 'Sort Test Section',
          sortOrder: testCase['sortOrder'] as int,
          options: [],
        );

        // Act
        final result = mapper.toEntity(configSection);

        // Assert
        expect(result.sortOrder, equals(testCase['sortOrder']),
            reason: 'Failed for ${testCase['description']}');
      }
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
        sectionOptionId: 'so_001',
        sectionName: 'Warranty Options',
        productName: 'Extended Warranty',
        productId: 'warranty_ext_001',
        description: '3-year extended warranty with comprehensive coverage',
        price: 299.99,
        userProductPrice: false,
        selected: true,
        sortOrder: 1,
        name: 'Extended 3Y',
        quantity: 1,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, equals('cso_001'));
      expect(result.sectionOptionId, equals('so_001'));
      expect(result.sectionName, equals('Warranty Options'));
      expect(result.productName, equals('Extended Warranty'));
      expect(result.productId, equals('warranty_ext_001'));
      expect(result.description,
          equals('3-year extended warranty with comprehensive coverage'));
      expect(result.price, equals(299.99));
      expect(result.userProductPrice, equals(false));
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
      expect(result.sectionOptionId, equals('soe_001'));
      expect(result.sectionName, equals('Installation Options'));
      expect(result.productName, equals('Professional Installation'));
      expect(result.productId, equals('install_pro_001'));
      expect(result.description,
          equals('Professional installation by certified technicians'));
      expect(result.price, equals(199.50));
      expect(result.userProductPrice, equals(true));
      expect(result.selected, equals(false));
      expect(result.sortOrder, equals(2));
      expect(result.name, equals('Pro Install'));
      expect(result.quantity, equals(1));
    });

    test('should handle ConfigSectionOption with all null fields', () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: null,
        sectionOptionId: null,
        sectionName: null,
        productName: null,
        productId: null,
        description: null,
        price: null,
        userProductPrice: null,
        selected: null,
        sortOrder: null,
        name: null,
        quantity: null,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, isNull);
      expect(result.sectionOptionId, isNull);
      expect(result.sectionName, isNull);
      expect(result.productName, isNull);
      expect(result.productId, isNull);
      expect(result.description, isNull);
      expect(result.price, isNull);
      expect(result.userProductPrice, isNull);
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
          sectionOptionId: 'pt_${testCase['price']}',
          sectionName: 'Price Test',
          productName: 'Price Test Product',
          productId: 'price_test_prod',
          description: 'Testing ${testCase['description']}',
          price: testCase['price'] as num,
          userProductPrice: false,
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

    test('should handle different quantity types correctly', () {
      // Arrange
      final testCases = [
        {'quantity': 0, 'description': 'zero quantity'},
        {'quantity': 1, 'description': 'single quantity'},
        {'quantity': 10, 'description': 'multiple quantity'},
        {'quantity': 0.5, 'description': 'fractional quantity'},
        {'quantity': 1000.25, 'description': 'large decimal quantity'},
      ];

      for (final testCase in testCases) {
        // Arrange
        final configSectionOption = ConfigSectionOption(
          id: 'qty_test',
          sectionOptionId: 'qt_001',
          sectionName: 'Quantity Test',
          productName: 'Quantity Test Product',
          productId: 'qty_test_prod',
          description: 'Testing ${testCase['description']}',
          price: 10.0,
          userProductPrice: false,
          selected: false,
          sortOrder: 1,
          name: 'Qty Test',
          quantity: testCase['quantity'] as num,
        );

        // Act
        final result = mapper.toEntity(configSectionOption);

        // Assert
        expect(result.quantity, equals(testCase['quantity']),
            reason: 'Failed for ${testCase['description']}');
      }
    });

    test('should handle boolean fields correctly', () {
      // Arrange
      final testCases = [
        {
          'userProductPrice': true,
          'selected': true,
          'description': 'both true'
        },
        {
          'userProductPrice': false,
          'selected': false,
          'description': 'both false'
        },
        {
          'userProductPrice': true,
          'selected': false,
          'description': 'mixed true/false'
        },
        {
          'userProductPrice': false,
          'selected': true,
          'description': 'mixed false/true'
        },
      ];

      for (final testCase in testCases) {
        // Arrange
        final configSectionOption = ConfigSectionOption(
          id: 'bool_test',
          sectionOptionId: 'bt_001',
          sectionName: 'Boolean Test',
          productName: 'Boolean Test Product',
          productId: 'bool_test_prod',
          description: 'Testing ${testCase['description']}',
          price: 10.0,
          userProductPrice: testCase['userProductPrice'] as bool,
          selected: testCase['selected'] as bool,
          sortOrder: 1,
          name: 'Bool Test',
          quantity: 1,
        );

        // Act
        final result = mapper.toEntity(configSectionOption);

        // Assert
        expect(result.userProductPrice, equals(testCase['userProductPrice']),
            reason: 'userProductPrice failed for ${testCase['description']}');
        expect(result.selected, equals(testCase['selected']),
            reason: 'selected failed for ${testCase['description']}');
      }
    });

    test('should handle very long text fields correctly', () {
      // Arrange
      final longProductName =
          'Professional Grade Industrial Equipment for Commercial Kitchen Applications with Advanced Temperature Control and Energy Efficiency Features' *
              2;
      final longDescription =
          'This is a comprehensive description of a complex product configuration option that includes detailed technical specifications, installation requirements, warranty information, and compatibility details for various system configurations' *
              3;

      final configSectionOption = ConfigSectionOption(
        id: 'long_text_test',
        sectionOptionId: 'ltt_001',
        sectionName: 'Long Text Test Section',
        productName: longProductName,
        productId: 'long_text_prod_001',
        description: longDescription,
        price: 1500.00,
        userProductPrice: false,
        selected: true,
        sortOrder: 1,
        name: 'Long Text Product',
        quantity: 1,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.productName, equals(longProductName));
      expect(result.description, equals(longDescription));
      expect(result.price, equals(1500.00));
    });

    test('should handle special characters in all text fields correctly', () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: 'special_chars_001',
        sectionOptionId: 'sc_001_äöü',
        sectionName: 'Café & Restaurant Equipment',
        productName: 'Professional "Grade A" Equipment (Model #2023)',
        productId: 'prod_café_001',
        description:
            'High-quality equipment with special features: €2,499 value, 100% satisfaction guaranteed!',
        price: 2499.99,
        userProductPrice: false,
        selected: true,
        sortOrder: 1,
        name: 'Café Equipment™',
        quantity: 1,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.sectionOptionId, equals('sc_001_äöü'));
      expect(result.sectionName, equals('Café & Restaurant Equipment'));
      expect(result.productName,
          equals('Professional "Grade A" Equipment (Model #2023)'));
      expect(result.productId, equals('prod_café_001'));
      expect(
          result.description,
          equals(
              'High-quality equipment with special features: €2,499 value, 100% satisfaction guaranteed!'));
      expect(result.name, equals('Café Equipment™'));
    });

    test('should handle mixed null and non-null fields correctly', () {
      // Arrange
      final configSectionOption = ConfigSectionOption(
        id: 'mixed_null_test',
        sectionOptionId: null,
        sectionName: 'Mixed Null Test',
        productName: null,
        productId: 'mixed_prod_001',
        description: 'Some fields are null, others are not',
        price: null,
        userProductPrice: true,
        selected: null,
        sortOrder: 5,
        name: null,
        quantity: 2.5,
      );

      // Act
      final result = mapper.toEntity(configSectionOption);

      // Assert
      expect(result.id, equals('mixed_null_test'));
      expect(result.sectionOptionId, isNull);
      expect(result.sectionName, equals('Mixed Null Test'));
      expect(result.productName, isNull);
      expect(result.productId, equals('mixed_prod_001'));
      expect(
          result.description, equals('Some fields are null, others are not'));
      expect(result.price, isNull);
      expect(result.userProductPrice, equals(true));
      expect(result.selected, isNull);
      expect(result.sortOrder, equals(5));
      expect(result.name, isNull);
      expect(result.quantity, equals(2.5));
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalOption = ConfigSectionOption(
        id: 'roundtrip_option',
        sectionOptionId: 'rt_option_001',
        sectionName: 'Roundtrip Test Section',
        productName: 'Roundtrip Test Product',
        productId: 'rt_prod_001',
        description: 'Testing roundtrip conversion for configuration option',
        price: 123.45,
        userProductPrice: true,
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
      expect(convertedBack.sectionOptionId,
          equals(originalOption.sectionOptionId));
      expect(convertedBack.sectionName, equals(originalOption.sectionName));
      expect(convertedBack.productName, equals(originalOption.productName));
      expect(convertedBack.productId, equals(originalOption.productId));
      expect(convertedBack.description, equals(originalOption.description));
      expect(convertedBack.price, equals(originalOption.price));
      expect(convertedBack.userProductPrice,
          equals(originalOption.userProductPrice));
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
      expect(copiedEntity.id, equals('copy_test')); // unchanged
      expect(copiedEntity.sectionOptionId, equals('ct_001')); // unchanged
      expect(copiedEntity.productName, equals('Updated Product')); // changed
      expect(copiedEntity.productId, equals('orig_prod_001')); // unchanged
      expect(copiedEntity.description,
          equals('Original description')); // unchanged
      expect(copiedEntity.price, equals(75.0)); // changed
      expect(copiedEntity.userProductPrice, equals(false)); // unchanged
      expect(copiedEntity.selected, equals(true)); // changed
      expect(copiedEntity.sortOrder, equals(1)); // unchanged
      expect(copiedEntity.name, equals('Original')); // unchanged
      expect(copiedEntity.quantity, equals(2)); // changed
    });
  });
}
