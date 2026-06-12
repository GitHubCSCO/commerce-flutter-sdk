import 'package:commerce_flutter_sdk/src/features/domain/entity/document._entity.dart';

extension ProductDetailDocumentsNameValueConverter on DocumentEntity? {
  String getDocumentDisplayName() {
    if (this == null) {
      return '';
    }
    final name = this!.name?.trim();
    final documentType = this!.documentType?.trim();
    final hasName = name != null && name.isNotEmpty;
    final hasDocumentType = documentType != null && documentType.isNotEmpty;

    if (hasName && hasDocumentType) {
      return "$name ($documentType)";
    } else if (hasName) {
      return name;
    } else if (hasDocumentType) {
      return documentType;
    }
    return '';
  }
}
