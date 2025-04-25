import 'package:commerce_flutter_sdk/features/domain/entity/document._entity.dart';

extension ProductDetailDocumentsNameValueConverter on DocumentEntity? {
  String getDocumentDisplayName() {
    if (this == null) {
      return '';
    }
    if (this!.name != null) {
      return this!.name!;
    } else if (this!.fileTypeString != null) {
      return this!.fileTypeString!;
    } else if (this!.name != null && this!.fileTypeString != null) {
      return "${this!.name!} (${this!.fileTypeString!})";
    }
    return '';
  }
}
