import 'package:commerce_flutter_sdk/src/features/domain/entity/document._entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/document_mapper.dart';
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
        filePath: '/documents/test_doc.pdf',
        documentType: 'pdf',
      );

      // Act
      final result = mapper.toEntity(document);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test Document');
      expect(result.description, 'A sample document');
      expect(result.filePath, '/documents/test_doc.pdf');
      expect(result.documentType, 'pdf');
    });

    test('should map DocumentEntity to Document correctly', () {
      // Arrange
      const documentEntity = DocumentEntity(
        id: '1',
        name: 'Test Document',
        description: 'A sample document',
        filePath: '/documents/test_doc.pdf',
        documentType: 'pdf',
      );

      // Act
      final result = mapper.toModel(documentEntity);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test Document');
      expect(result.description, 'A sample document');
      expect(result.filePath, '/documents/test_doc.pdf');
      expect(result.documentType, 'pdf');
    });

    test('should handle null values correctly when mapping to DocumentEntity',
        () {
      // Arrange
      final document = Document(
        id: '1',
        name: null,
        description: null,
        filePath: null,
        documentType: null,
      );

      // Act
      final result = mapper.toEntity(document);

      // Assert
      expect(result.id, '1');
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.filePath, isNull);
      expect(result.documentType, isNull);
    });

    test('should handle null values correctly when mapping to Document', () {
      // Arrange
      const documentEntity = DocumentEntity(
        id: '1',
        name: null,
        description: null,
        filePath: null,
        documentType: null,
      );

      // Act
      final result = mapper.toModel(documentEntity);

      // Assert
      expect(result.id, '1');
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.filePath, isNull);
      expect(result.documentType, isNull);
    });
  });
}
