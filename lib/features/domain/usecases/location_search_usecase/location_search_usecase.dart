import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class LocationSearchUseCase extends BaseUseCase {
  LocationSearchUseCase() : super();

  Future<GooglePlace?> getSearchedLocation(String query) async {
    return coreServiceProvider.getVmiService().getPlace(query);
  }

  Future<void> persistSearchQuery(String searchQuery) async {
    await coreServiceProvider
        .getLocationSearchHistoryService()
        .persistSearchQuery(searchQuery);
  }

  Future<List<String>> loadSearchQueryHistory() async {
    return coreServiceProvider
        .getLocationSearchHistoryService()
        .loadSearchQueryHistory();
  }
}
