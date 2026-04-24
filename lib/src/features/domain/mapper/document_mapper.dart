import 'package:commerce_flutter_sdk/src/features/domain/entity/document._entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DocumentEntityMapper {
  DocumentEntity toEntity(Document model) => DocumentEntity(
        id: model.id,
        name: model.name,
        description: model.description,
        filePath: model.filePath,
        documentType: model.documentType,
      );

  Document toModel(DocumentEntity entity) => Document(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        filePath: entity.filePath,
        documentType: entity.documentType,
      );
}
