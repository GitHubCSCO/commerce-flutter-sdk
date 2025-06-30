import 'package:commerce_flutter_sdk/src/features/domain/entity/sort_options_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/sort_option_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('SortOptionEntityMapper', () {
    test('should correctly map SortOption to SortOptionEntity', () {
      // Arrange
      final model = SortOption(
        displayName: "Price: Low to High",
        sortType: "price_asc",
      );

      // Act
      final result = SortOptionEntityMapper.toEntity(model);

      // Assert
      expect(result.displayName, model.displayName);
      expect(result.sortType, model.sortType);
    });

    test('should correctly map SortOptionEntity to SortOption', () {
      // Arrange
      const entity = SortOptionEntity(
        displayName: "Price: High to Low",
        sortType: "price_desc",
      );

      // Act
      final result = SortOptionEntityMapper.toModel(entity);

      // Assert
      expect(result.displayName, entity.displayName);
      expect(result.sortType, entity.sortType);
    });

    test('should handle null values correctly when mapping to SortOptionEntity',
        () {
      // Arrange
      final model = SortOption(
        displayName: null,
        sortType: null,
      );

      // Act
      final result = SortOptionEntityMapper.toEntity(model);

      // Assert
      expect(result.displayName, isNull);
      expect(result.sortType, isNull);
    });

    test('should handle null values correctly when mapping to SortOption', () {
      // Arrange
      const entity = SortOptionEntity(
        displayName: null,
        sortType: null,
      );

      // Act
      final result = SortOptionEntityMapper.toModel(entity);

      // Assert
      expect(result.displayName, isNull);
      expect(result.sortType, isNull);
    });

    test('should maintain data integrity in roundtrip conversion', () {
      // Arrange
      final originalModel = SortOption(
        displayName: "Alphabetical: A to Z",
        sortType: "name_asc",
      );

      // Act
      final entity = SortOptionEntityMapper.toEntity(originalModel);
      final resultModel = SortOptionEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.displayName, originalModel.displayName);
      expect(resultModel.sortType, originalModel.sortType);
    });

    test('should handle typical sort options correctly', () {
      // Test various realistic sort options
      final testCases = [
        {
          'displayName': 'Newest First',
          'sortType': 'date_desc',
        },
        {
          'displayName': 'Oldest First',
          'sortType': 'date_asc',
        },
        {
          'displayName': 'Most Popular',
          'sortType': 'popularity_desc',
        },
        {
          'displayName': 'Best Rating',
          'sortType': 'rating_desc',
        },
        {
          'displayName': 'Relevance',
          'sortType': 'relevance',
        },
      ];

      for (final testCase in testCases) {
        // Arrange
        final model = SortOption(
          displayName: testCase['displayName'] as String,
          sortType: testCase['sortType'] as String,
        );

        // Act
        final entity = SortOptionEntityMapper.toEntity(model);
        final resultModel = SortOptionEntityMapper.toModel(entity);

        // Assert
        expect(entity.displayName, testCase['displayName']);
        expect(entity.sortType, testCase['sortType']);
        expect(resultModel.displayName, testCase['displayName']);
        expect(resultModel.sortType, testCase['sortType']);
      }
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final model = SortOption(
        displayName: "",
        sortType: "",
      );

      // Act
      final result = SortOptionEntityMapper.toEntity(model);

      // Assert
      expect(result.displayName, "");
      expect(result.sortType, "");
    });

    test('should handle mixed null and non-null values', () {
      // Test case 1: displayName is null, sortType is not null
      final model1 = SortOption(
        displayName: null,
        sortType: "custom_sort",
      );

      final result1 = SortOptionEntityMapper.toEntity(model1);
      expect(result1.displayName, isNull);
      expect(result1.sortType, "custom_sort");

      // Test case 2: displayName is not null, sortType is null
      final model2 = SortOption(
        displayName: "Custom Sort",
        sortType: null,
      );

      final result2 = SortOptionEntityMapper.toEntity(model2);
      expect(result2.displayName, "Custom Sort");
      expect(result2.sortType, isNull);
    });

    test('should handle special characters and unicode in displayName', () {
      // Arrange
      final model = SortOption(
        displayName: "Price: Low → High ↑",
        sortType: "price_asc_unicode",
      );

      // Act
      final entity = SortOptionEntityMapper.toEntity(model);
      final resultModel = SortOptionEntityMapper.toModel(entity);

      // Assert
      expect(entity.displayName, "Price: Low → High ↑");
      expect(resultModel.displayName, "Price: Low → High ↑");
      expect(entity.sortType, "price_asc_unicode");
      expect(resultModel.sortType, "price_asc_unicode");
    });

    test('should handle long strings correctly', () {
      // Arrange
      const longDisplayName =
          "A very long sort option display name that might be used in some specific scenarios where detailed descriptions are needed";
      const longSortType =
          "very_long_sort_type_identifier_that_might_be_used_in_complex_sorting_scenarios";

      final model = SortOption(
        displayName: longDisplayName,
        sortType: longSortType,
      );

      // Act
      final entity = SortOptionEntityMapper.toEntity(model);
      final resultModel = SortOptionEntityMapper.toModel(entity);

      // Assert
      expect(entity.displayName, longDisplayName);
      expect(entity.sortType, longSortType);
      expect(resultModel.displayName, longDisplayName);
      expect(resultModel.sortType, longSortType);
    });
  });
}
