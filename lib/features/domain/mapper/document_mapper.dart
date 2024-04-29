import 'package:commerce_flutter_app/features/domain/entity/document._entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DocumentEntityMapper {
  DocumentEntity toEntity(Document model) => DocumentEntity(
        id: model.id,
        name: model.name,
        description: model.description,
        createdOn: model.createdOn,
        filePath: model.filePath,
        fileUrl: model.fileUrl,
        documentType: model.documentType,
        languageId: model.languageId,
        fileTypeString: model.fileTypeString,
      );
  Document toModel(DocumentEntity entity) => Document(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        createdOn: entity.createdOn,
        filePath: entity.filePath,
        fileUrl: entity.fileUrl,
        documentType: entity.documentType,
        languageId: entity.languageId,
        fileTypeString: entity.fileTypeString,
      );
}
