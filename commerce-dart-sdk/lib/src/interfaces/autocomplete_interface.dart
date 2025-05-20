import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAutocompleteService {
  Future<Result<AutocompleteResult, ErrorResponse>> getAutocompleteResults(
      AutocompleteQueryParameters parameters);
  Future<Result<List<AutocompleteProduct>, ErrorResponse>>
      getAutocompleteProducts(String searchQuery);
  Future<Result<List<AutocompleteBrand>, ErrorResponse>> getAutocompleteBrands(
      String searchQuery);
}
