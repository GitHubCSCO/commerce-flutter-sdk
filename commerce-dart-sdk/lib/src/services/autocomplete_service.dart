import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AutoCompleteService extends ServiceBase implements IAutocompleteService {
  AutoCompleteService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<List<AutocompleteBrand>, ErrorResponse>> getAutocompleteBrands(
    String searchQuery,
  ) async {
    var parameters = AutocompleteQueryParameters(
      query: searchQuery,
      brandEnabled: true,
      categoryEnabled: false,
      contentEnabled: false,
      productEnabled: false,
    );

    final result = await getAutocompleteResults(parameters);

    switch (result) {
      case Success(value: final value):
        {
          return Success(value?.brands);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<List<AutocompleteProduct>, ErrorResponse>>
      getAutocompleteProducts(
    String searchQuery,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.autocompleteUrl);
    List<String> parameters = [
      "query=$searchQuery",
      "categoryEnabled=false",
      "contentEnabled=false",
      "productEnabled=true",
      "brandEnabled=false",
    ];

    var urlStr = "$url?${parameters.join("&")}";

    final result = await getAsyncNoCache<Autocomplete>(
      urlStr,
      Autocomplete.fromJson,
    );

    switch (result) {
      case Success(value: final value):
        {
          return Success(value?.products);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<AutocompleteResult, ErrorResponse>> getAutocompleteResults(
    AutocompleteQueryParameters parameters,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.autocompleteUrl);
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<AutocompleteResult>(
      url.toString(),
      AutocompleteResult.fromJson,
    );
  }
}
