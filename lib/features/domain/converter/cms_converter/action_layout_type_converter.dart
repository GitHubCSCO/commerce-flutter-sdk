import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/actions_widget_entity.dart';

class ActionsLayoutConverter {
  static ActionsLayout convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "list":
        return ActionsLayout.list;
      case "grid":
        return ActionsLayout.grid;
      default:
        return ActionsLayout.list;
    }
  }
}
