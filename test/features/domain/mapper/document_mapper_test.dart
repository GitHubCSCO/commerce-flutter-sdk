import 'package:commerce_flutter_app/features/domain/entity/document._entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/document_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  final mapper = DocumentEntityMapper();

  group('DocumentEntityMapper', () {
    test('should map Document to DocumentEntity correctly', () {
      // Arrange
      final document = Document(
        id: '1',
        name: 'Test Document',
        description: 'A sample document',
        createdOn: DateTime(2025, 2, 4),
        filePath: '/documents/test_doc.pdf',
        fileUrl: 'https://example.com/documents/test_doc.pdf',
        documentType: 'pdf',
        languageId: 'en',
        fileTypeString: 'application/pdf',
      );

      // Act
      final result = mapper.toEntity(document);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test Document');
      expect(result.description, 'A sample document');
      expect(result.createdOn, DateTime(2025, 2, 4));
      expect(result.filePath, '/documents/test_doc.pdf');
      expect(result.fileUrl, 'https://example.com/documents/test_doc.pdf');
      expect(result.documentType, 'pdf');
      expect(result.languageId, 'en');
      expect(result.fileTypeString, 'application/pdf');
    });

    test('should map DocumentEntity to Document correctly', () {
      // Arrange
      final documentEntity = DocumentEntity(
        id: '1',
        name: 'Test Document',
        description: 'A sample document',
        createdOn: DateTime(2025, 2, 4),
        filePath: '/documents/test_doc.pdf',
        fileUrl: 'https://example.com/documents/test_doc.pdf',
        documentType: 'pdf',
        languageId: 'en',
        fileTypeString: 'application/pdf',
      );

      // Act
      final result = mapper.toModel(documentEntity);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test Document');
      expect(result.description, 'A sample document');
      expect(result.createdOn, DateTime(2025, 2, 4));
      expect(result.filePath, '/documents/test_doc.pdf');
      expect(result.fileUrl, 'https://example.com/documents/test_doc.pdf');
      expect(result.documentType, 'pdf');
      expect(result.languageId, 'en');
      expect(result.fileTypeString, 'application/pdf');
    });

    test('should handle null values correctly when mapping to DocumentEntity',
        () {
      // Arrange
      final document = Document(
        id: '1',
        name: null,
        description: null,
        createdOn: null,
        filePath: null,
        fileUrl: null,
        documentType: null,
        languageId: null,
        fileTypeString: null,
      );

      // Act
      final result = mapper.toEntity(document);

      // Assert
      expect(result.id, '1');
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.createdOn, isNull);
      expect(result.filePath, isNull);
      expect(result.fileUrl, isNull);
      expect(result.documentType, isNull);
      expect(result.languageId, isNull);
      expect(result.fileTypeString, isNull);
    });

    test('should handle null values correctly when mapping to Document', () {
      // Arrange
      final documentEntity = DocumentEntity(
        id: '1',
        name: null,
        description: null,
        createdOn: null,
        filePath: null,
        fileUrl: null,
        documentType: null,
        languageId: null,
        fileTypeString: null,
      );

      // Act
      final result = mapper.toModel(documentEntity);

      // Assert
      expect(result.id, '1');
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.createdOn, isNull);
      expect(result.filePath, isNull);
      expect(result.fileUrl, isNull);
      expect(result.documentType, isNull);
      expect(result.languageId, isNull);
      expect(result.fileTypeString, isNull);
    });
  });
}
