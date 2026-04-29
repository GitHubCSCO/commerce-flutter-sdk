import 'package:commerce_flutter_sdk/src/features/domain/entity/document._entity.dart';

extension ProductDetailDocumentsNameValueConverter on DocumentEntity? {
  String getDocumentDisplayName() {
    if (this == null) {
      return '';
    }
    if (this!.name != null && this!.documentType != null) {
      return "${this!.name!} (${this!.documentType!})";
    } else if (this!.name != null) {
      return this!.name!;
    } else if (this!.documentType != null) {
      return this!.documentType!;
    }
    return '';
  }
}
