import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/search_history_service_interface.dart';

abstract class ILocationSearchHistoryService implements ISearchHistoryService {
  Future<void> clearHistory();
}
