import 'package:commerce_flutter_sdk/src/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/sort_options_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('PaginationEntityMapper', () {
    test('should correctly map Pagination to PaginationEntity with all fields',
        () {
      // Arrange
      final pagination = Pagination(
        currentPage: 2,
        page: 2,
        pageSize: 20,
        defaultPageSize: 10,
        totalItemCount: 150,
        numberOfPages: 8,
        pageSizeOptions: [10, 20, 50, 100],
        sortOptions: [
          SortOption(
            displayName: "Price: Low to High",
            sortType: "price_asc",
          ),
          SortOption(
            displayName: "Price: High to Low",
            sortType: "price_desc",
          ),
          SortOption(
            displayName: "Name: A to Z",
            sortType: "name_asc",
          ),
        ],
        sortType: "price_asc",
        nextPageUri: "https://api.example.com/products?page=3",
        prevPageUri: "https://api.example.com/products?page=1",
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.currentPage, 2);
      expect(result.page, 2);
      expect(result.pageSize, 20);
      expect(result.defaultPageSize, 10);
      expect(result.totalItemCount, 150);
      expect(result.numberOfPages, 8);
      expect(result.pageSizeOptions, [10, 20, 50, 100]);
      expect(result.sortType, "price_asc");
      expect(result.nextPageUri, "https://api.example.com/products?page=3");
      expect(result.prevPageUri, "https://api.example.com/products?page=1");

      // Verify sort options mapping
      expect(result.sortOptions, hasLength(3));
      expect(result.sortOptions?[0].displayName, "Price: Low to High");
      expect(result.sortOptions?[0].sortType, "price_asc");
      expect(result.sortOptions?[1].displayName, "Price: High to Low");
      expect(result.sortOptions?[1].sortType, "price_desc");
      expect(result.sortOptions?[2].displayName, "Name: A to Z");
      expect(result.sortOptions?[2].sortType, "name_asc");
    });

    test('should correctly map PaginationEntity to Pagination with all fields',
        () {
      // Arrange
      const paginationEntity = PaginationEntity(
        currentPage: 3,
        page: 3,
        pageSize: 50,
        defaultPageSize: 25,
        totalItemCount: 200,
        numberOfPages: 4,
        pageSizeOptions: [25, 50, 75, 100],
        sortOptions: [
          SortOptionEntity(
            displayName: "Date: Newest First",
            sortType: "date_desc",
          ),
          SortOptionEntity(
            displayName: "Date: Oldest First",
            sortType: "date_asc",
          ),
        ],
        sortType: "date_desc",
        nextPageUri: "https://api.example.com/orders?page=4",
        prevPageUri: "https://api.example.com/orders?page=2",
      );

      // Act
      final result = PaginationEntityMapper.toModel(paginationEntity);

      // Assert
      expect(result.currentPage, 3);
      expect(result.page, 3);
      expect(result.pageSize, 50);
      expect(result.defaultPageSize, 25);
      expect(result.totalItemCount, 200);
      expect(result.numberOfPages, 4);
      expect(result.pageSizeOptions, [25, 50, 75, 100]);
      expect(result.sortType, "date_desc");
      expect(result.nextPageUri, "https://api.example.com/orders?page=4");
      expect(result.prevPageUri, "https://api.example.com/orders?page=2");

      // Verify sort options mapping
      expect(result.sortOptions, hasLength(2));
      expect(result.sortOptions?[0].displayName, "Date: Newest First");
      expect(result.sortOptions?[0].sortType, "date_desc");
      expect(result.sortOptions?[1].displayName, "Date: Oldest First");
      expect(result.sortOptions?[1].sortType, "date_asc");
    });

    test(
        'should handle null values correctly in Pagination to PaginationEntity mapping',
        () {
      // Arrange
      final pagination = Pagination(
        currentPage: null,
        page: null,
        pageSize: null,
        defaultPageSize: null,
        totalItemCount: null,
        numberOfPages: null,
        pageSizeOptions: null,
        sortOptions: null,
        sortType: null,
        nextPageUri: null,
        prevPageUri: null,
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.currentPage, isNull);
      expect(result.page, isNull);
      expect(result.pageSize, isNull);
      expect(result.defaultPageSize, isNull);
      expect(result.totalItemCount, isNull);
      expect(result.numberOfPages, isNull);
      expect(result.pageSizeOptions, isNull);
      expect(result.sortOptions, isNull);
      expect(result.sortType, isNull);
      expect(result.nextPageUri, isNull);
      expect(result.prevPageUri, isNull);
    });

    test(
        'should handle null values correctly in PaginationEntity to Pagination mapping',
        () {
      // Arrange
      const paginationEntity = PaginationEntity(
        currentPage: null,
        page: null,
        pageSize: null,
        defaultPageSize: null,
        totalItemCount: null,
        numberOfPages: null,
        pageSizeOptions: null,
        sortOptions: null,
        sortType: null,
        nextPageUri: null,
        prevPageUri: null,
      );

      // Act
      final result = PaginationEntityMapper.toModel(paginationEntity);

      // Assert
      expect(result.currentPage, isNull);
      expect(result.page, isNull);
      expect(result.pageSize, isNull);
      expect(result.defaultPageSize, isNull);
      expect(result.totalItemCount, isNull);
      expect(result.numberOfPages, isNull);
      expect(result.pageSizeOptions, isNull);
      expect(result.sortOptions, isNull);
      expect(result.sortType, isNull);
      expect(result.nextPageUri, isNull);
      expect(result.prevPageUri, isNull);
    });

    test('should handle empty lists correctly', () {
      // Arrange
      final pagination = Pagination(
        currentPage: 1,
        page: 1,
        pageSize: 10,
        defaultPageSize: 10,
        totalItemCount: 0,
        numberOfPages: 0,
        pageSizeOptions: [],
        sortOptions: [],
        sortType: "default",
        nextPageUri: null,
        prevPageUri: null,
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.pageSizeOptions, hasLength(0));
      expect(result.sortOptions, hasLength(0));
      expect(result.totalItemCount, 0);
      expect(result.numberOfPages, 0);
    });

    test('should handle single page scenario correctly', () {
      // Arrange
      final pagination = Pagination(
        currentPage: 1,
        page: 1,
        pageSize: 25,
        defaultPageSize: 25,
        totalItemCount: 15,
        numberOfPages: 1,
        pageSizeOptions: [25, 50, 100],
        sortOptions: [
          SortOption(
            displayName: "Relevance",
            sortType: "relevance",
          ),
        ],
        sortType: "relevance",
        nextPageUri: null, // No next page
        prevPageUri: null, // No previous page
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.page, 1);
      expect(result.numberOfPages, 1);
      expect(result.totalItemCount, 15);
      expect(result.nextPageUri, isNull);
      expect(result.prevPageUri, isNull);
      expect(result.sortOptions, hasLength(1));
      expect(result.sortOptions?[0].displayName, "Relevance");
    });

    test('should handle large dataset pagination correctly', () {
      // Arrange
      final pagination = Pagination(
        currentPage: 50,
        page: 50,
        pageSize: 100,
        defaultPageSize: 20,
        totalItemCount: 10000,
        numberOfPages: 100,
        pageSizeOptions: [20, 50, 100, 200],
        sortOptions: [
          SortOption(
            displayName: "Most Popular",
            sortType: "popularity_desc",
          ),
          SortOption(
            displayName: "Best Rating",
            sortType: "rating_desc",
          ),
          SortOption(
            displayName: "Price: Low to High",
            sortType: "price_asc",
          ),
          SortOption(
            displayName: "Price: High to Low",
            sortType: "price_desc",
          ),
          SortOption(
            displayName: "Newest First",
            sortType: "date_desc",
          ),
        ],
        sortType: "popularity_desc",
        nextPageUri: "https://api.example.com/products?page=51&size=100",
        prevPageUri: "https://api.example.com/products?page=49&size=100",
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.page, 50);
      expect(result.pageSize, 100);
      expect(result.totalItemCount, 10000);
      expect(result.numberOfPages, 100);
      expect(result.pageSizeOptions, [20, 50, 100, 200]);
      expect(result.sortOptions, hasLength(5));
      expect(result.sortType, "popularity_desc");
      expect(result.nextPageUri, contains("page=51"));
      expect(result.prevPageUri, contains("page=49"));
    });

    test('should handle sort options with null values correctly', () {
      // Arrange
      final pagination = Pagination(
        currentPage: 1,
        page: 1,
        pageSize: 10,
        defaultPageSize: 10,
        totalItemCount: 50,
        numberOfPages: 5,
        pageSizeOptions: [10, 20],
        sortOptions: [
          SortOption(
            displayName: null,
            sortType: "custom_sort",
          ),
          SortOption(
            displayName: "Valid Option",
            sortType: null,
          ),
          SortOption(
            displayName: null,
            sortType: null,
          ),
        ],
        sortType: "custom_sort",
        nextPageUri: "https://api.example.com/products?page=2",
        prevPageUri: null,
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.sortOptions, hasLength(3));
      expect(result.sortOptions?[0].displayName, isNull);
      expect(result.sortOptions?[0].sortType, "custom_sort");
      expect(result.sortOptions?[1].displayName, "Valid Option");
      expect(result.sortOptions?[1].sortType, isNull);
      expect(result.sortOptions?[2].displayName, isNull);
      expect(result.sortOptions?[2].sortType, isNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalPagination = Pagination(
        currentPage: 5,
        page: 5,
        pageSize: 30,
        defaultPageSize: 15,
        totalItemCount: 300,
        numberOfPages: 10,
        pageSizeOptions: [15, 30, 60],
        sortOptions: [
          SortOption(
            displayName: "Alphabetical: A to Z",
            sortType: "name_asc",
          ),
          SortOption(
            displayName: "Alphabetical: Z to A",
            sortType: "name_desc",
          ),
        ],
        sortType: "name_asc",
        nextPageUri: "https://api.example.com/items?page=6",
        prevPageUri: "https://api.example.com/items?page=4",
      );

      // Act
      final entity = PaginationEntityMapper.toEntity(originalPagination);
      final convertedBack = PaginationEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.currentPage, originalPagination.currentPage);
      expect(convertedBack.page, originalPagination.page);
      expect(convertedBack.pageSize, originalPagination.pageSize);
      expect(convertedBack.defaultPageSize, originalPagination.defaultPageSize);
      expect(convertedBack.totalItemCount, originalPagination.totalItemCount);
      expect(convertedBack.numberOfPages, originalPagination.numberOfPages);
      expect(convertedBack.pageSizeOptions, originalPagination.pageSizeOptions);
      expect(convertedBack.sortType, originalPagination.sortType);
      expect(convertedBack.nextPageUri, originalPagination.nextPageUri);
      expect(convertedBack.prevPageUri, originalPagination.prevPageUri);

      // Verify sort options roundtrip
      expect(convertedBack.sortOptions, hasLength(2));
      expect(convertedBack.sortOptions?[0].displayName,
          originalPagination.sortOptions?[0].displayName);
      expect(convertedBack.sortOptions?[0].sortType,
          originalPagination.sortOptions?[0].sortType);
      expect(convertedBack.sortOptions?[1].displayName,
          originalPagination.sortOptions?[1].displayName);
      expect(convertedBack.sortOptions?[1].sortType,
          originalPagination.sortOptions?[1].sortType);
    });

    test('should handle edge case values correctly', () {
      // Arrange
      final pagination = Pagination(
        currentPage: 0, // Edge case: zero page
        page: 0,
        pageSize: 1, // Edge case: minimum page size
        defaultPageSize: 1,
        totalItemCount: 1, // Edge case: single item
        numberOfPages: 1,
        pageSizeOptions: [1], // Edge case: single option
        sortOptions: [
          SortOption(
            displayName: "", // Edge case: empty string
            sortType: "",
          ),
        ],
        sortType: "",
        nextPageUri: "", // Edge case: empty string
        prevPageUri: "",
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.currentPage, 0);
      expect(result.page, 0);
      expect(result.pageSize, 1);
      expect(result.totalItemCount, 1);
      expect(result.numberOfPages, 1);
      expect(result.pageSizeOptions, [1]);
      expect(result.sortOptions, hasLength(1));
      expect(result.sortOptions?[0].displayName, "");
      expect(result.sortOptions?[0].sortType, "");
      expect(result.sortType, "");
      expect(result.nextPageUri, "");
      expect(result.prevPageUri, "");
    });

    test('should handle realistic e-commerce pagination scenario', () {
      // Arrange - Typical product search pagination
      final pagination = Pagination(
        currentPage: 3,
        page: 3,
        pageSize: 24, // Common product grid size
        defaultPageSize: 24,
        totalItemCount: 487, // Realistic product count
        numberOfPages: 21, // 487 / 24 = ~20.3, so 21 pages
        pageSizeOptions: [12, 24, 48, 96],
        sortOptions: [
          SortOption(
            displayName: "Featured",
            sortType: "featured",
          ),
          SortOption(
            displayName: "Price: Low to High",
            sortType: "price_asc",
          ),
          SortOption(
            displayName: "Price: High to Low",
            sortType: "price_desc",
          ),
          SortOption(
            displayName: "Customer Rating",
            sortType: "rating_desc",
          ),
          SortOption(
            displayName: "Newest",
            sortType: "date_desc",
          ),
          SortOption(
            displayName: "Best Selling",
            sortType: "sales_desc",
          ),
        ],
        sortType: "featured",
        nextPageUri:
            "https://shop.example.com/api/products?category=electronics&page=4&size=24&sort=featured",
        prevPageUri:
            "https://shop.example.com/api/products?category=electronics&page=2&size=24&sort=featured",
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.page, 3);
      expect(result.pageSize, 24);
      expect(result.totalItemCount, 487);
      expect(result.numberOfPages, 21);
      expect(result.pageSizeOptions, [12, 24, 48, 96]);
      expect(result.sortOptions, hasLength(6));
      expect(result.sortType, "featured");
      expect(result.nextPageUri, contains("page=4"));
      expect(result.prevPageUri, contains("page=2"));

      // Verify all sort options
      final sortDisplayNames =
          result.sortOptions?.map((s) => s.displayName).toList();
      expect(sortDisplayNames, contains("Featured"));
      expect(sortDisplayNames, contains("Price: Low to High"));
      expect(sortDisplayNames, contains("Price: High to Low"));
      expect(sortDisplayNames, contains("Customer Rating"));
      expect(sortDisplayNames, contains("Newest"));
      expect(sortDisplayNames, contains("Best Selling"));
    });

    test('should handle last page scenario correctly', () {
      // Arrange - User is on the last page
      final pagination = Pagination(
        currentPage: 15,
        page: 15,
        pageSize: 20,
        defaultPageSize: 20,
        totalItemCount: 300, // Exactly 15 pages (300 / 20 = 15)
        numberOfPages: 15,
        pageSizeOptions: [10, 20, 50],
        sortOptions: [
          SortOption(
            displayName: "Default",
            sortType: "default",
          ),
        ],
        sortType: "default",
        nextPageUri: null, // No next page (last page)
        prevPageUri: "https://api.example.com/items?page=14",
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.page, 15);
      expect(result.numberOfPages, 15);
      expect(result.nextPageUri, isNull);
      expect(result.prevPageUri, contains("page=14"));
    });

    test('should handle first page scenario correctly', () {
      // Arrange - User is on the first page
      final pagination = Pagination(
        currentPage: 1,
        page: 1,
        pageSize: 20,
        defaultPageSize: 20,
        totalItemCount: 100,
        numberOfPages: 5,
        pageSizeOptions: [10, 20, 50],
        sortOptions: [
          SortOption(
            displayName: "Default",
            sortType: "default",
          ),
        ],
        sortType: "default",
        nextPageUri: "https://api.example.com/items?page=2",
        prevPageUri: null, // No previous page (first page)
      );

      // Act
      final result = PaginationEntityMapper.toEntity(pagination);

      // Assert
      expect(result.page, 1);
      expect(result.nextPageUri, contains("page=2"));
      expect(result.prevPageUri, isNull);
    });
  });
}
