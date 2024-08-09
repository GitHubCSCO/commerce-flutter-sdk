import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService implements ICacheService {
  Map<String, dynamic> cache = {};

  @override
  void clearAllCaches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cache.clear();
    prefs.clear();
  }

  @override
  Future<T> getObject<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return Future.value(jsonDecode(prefs.getString(key)!) as T);
    } else {
      throw Exception('Object not found in cache');
    }
  }

  @override
  Future<T> getOrFetchObject<T>(String key, Future<T> Function() fetchFunc,
      {DateTime? absoluteExpiration,
      Function(Map<String, dynamic>)? fromJson}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      //1. convert store value to jsonMap. 2. extract model type from T. 3. convert jsonMap to model using fromJson(jsonMap) into value 4. return Success(value)
      String rawValue = prefs.getString(key)!;
      Map<String, dynamic> jsonMap = jsonDecode(rawValue);
      return parseResult<T>(jsonMap);
    } else {
      final value = await fetchFunc();
      if (value is Success) {
        if (value.value != null) {
          prefs.setString(key, jsonEncode(value.value));
        }
      }
      return value;
    }
  }

  @override
  Future<bool> hasOnlineCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(prefs.containsKey(key));
  }

  @override
  Future<void> insertObject<T>(String key, T value,
      {DateTime? absoluteExpiration}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    return Future.value();
  }

  @override
  Future<void> invalidate(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateAllObjects<T>() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return Future.value();
  }

  @override
  Future<void> invalidateObject<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  Future<void> invalidateObjectWithKeysStartingWith<T>(String keyPrefix) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(keyPrefix));
    for (var key in keys) {
      prefs.remove(key);
    }
    return Future.value();
  }

  @override
  Future<Uint8List> loadPersistedBytesData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return Future.value(base64Decode(prefs.getString(key)!));
    } else {
      throw Exception('Bytes data not found in cache');
    }
  }

  @override
  Future<T> loadPersistedData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return Future.value(jsonDecode(prefs.getString(key)!) as T);
    } else {
      throw Exception('Data not found in cache');
    }
  }

  @override
  int get offlineCacheMinutes => 5; // arbitrary value

  @override
  int get onlineCacheMinutes => 5; // arbitrary value

  @override
  Future<bool> persistBytesData(String key, Uint8List value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, base64Encode(value));
    return Future.value(true);
  }

  @override
  Future<bool> persistData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    return Future.value(true);
  }

  @override
  Future<void> removePersistedData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    return Future.value();
  }

  @override
  void shutdown() {
    // No specific implementation required for shutdown in this example
  }

  T parseResult<T>(Map<String, dynamic> jsonMap) {
    // Map each type to its fromJson function
    final typeMap = <Type, Function>{
      Result<AccountSettings, ErrorResponse>: (json) =>
          Success(AccountSettings.fromJson(json)),
      Result<AddressFieldCollection, ErrorResponse>: (json) =>
          Success(AddressFieldCollection.fromJson(json)),
      Result<AutocompleteProduct, ErrorResponse>: (json) =>
          Success(AutocompleteProduct.fromJson(json)),
      Result<AutocompleteResult, ErrorResponse>: (json) =>
          Success(AutocompleteResult.fromJson(json)),
      Result<Brand, ErrorResponse>: (json) => Success(Brand.fromJson(json)),
      Result<BrandAlphabetResult, ErrorResponse>: (json) =>
          Success(BrandAlphabetResult.fromJson(json)),
      Result<CartSettings, ErrorResponse>: (json) =>
          Success(CartSettings.fromJson(json)),
      Result<CatalogPage, ErrorResponse>: (json) =>
          Success(CatalogPage.fromJson(json)),
      Result<Category, ErrorResponse>: (json) =>
          Success(Category.fromJson(json)),
      Result<CategoryResult, ErrorResponse>: (json) =>
          Success(CategoryResult.fromJson(json)),
      Result<Country, ErrorResponse>: (json) => Success(Country.fromJson(json)),
      Result<CountryCollection, ErrorResponse>: (json) =>
          Success(CountryCollection.fromJson(json)),
      Result<Currency, ErrorResponse>: (json) =>
          Success(Currency.fromJson(json)),
      Result<CurrencyCollection, ErrorResponse>: (json) =>
          Success(CurrencyCollection.fromJson(json)),
      Result<GetBrandCategoriesResult, ErrorResponse>: (json) =>
          Success(GetBrandCategoriesResult.fromJson(json)),
      Result<GetBrandProductLinesResult, ErrorResponse>: (json) =>
          Success(GetBrandProductLinesResult.fromJson(json)),
      Result<GetBrandSubCategoriesResult, ErrorResponse>: (json) =>
          Success(GetBrandSubCategoriesResult.fromJson(json)),
      Result<GetBrandsResult, ErrorResponse>: (json) =>
          Success(GetBrandsResult.fromJson(json)),
      Result<GetDealerCollectionResult, ErrorResponse>: (json) =>
          Success(GetDealerCollectionResult.fromJson(json)),
      Result<GetOrderCollectionResult, ErrorResponse>: (json) =>
          Success(GetOrderCollectionResult.fromJson(json)),
      Result<GetOrderStatusMappingsResult, ErrorResponse>: (json) =>
          Success(GetOrderStatusMappingsResult.fromJson(json)),
      Result<GetProductCollectionResult, ErrorResponse>: (json) =>
          Success(GetProductCollectionResult.fromJson(json)),
      Result<GetProductResult, ErrorResponse>: (json) =>
          Success(GetProductResult.fromJson(json)),
      Result<GetWarehouseCollectionResult, ErrorResponse>: (json) =>
          Success(GetWarehouseCollectionResult.fromJson(json)),
      Result<GetSiteMessageCollectionResult, ErrorResponse>: (json) =>
          Success(GetSiteMessageCollectionResult.fromJson(json)),
      Result<Language, ErrorResponse>: (json) =>
          Success(Language.fromJson(json)),
      Result<LanguageCollection, ErrorResponse>: (json) =>
          Success(LanguageCollection.fromJson(json)),
      Result<MobileAppSettings, ErrorResponse>: (json) =>
          Success(MobileAppSettings.fromJson(json)),
      Result<Order, ErrorResponse>: (json) => Success(Order.fromJson(json)),
      Result<PageContentManagement, ErrorResponse>: (json) =>
          Success(PageContentManagement.fromJson(json)),
      Result<ProductPrice, ErrorResponse>: (json) =>
          Success(ProductPrice.fromJson(json)),
      Result<ProductSettings, ErrorResponse>: (json) =>
          Success(ProductSettings.fromJson(json)),
      Result<StateModel, ErrorResponse>: (json) =>
          Success(StateModel.fromJson(json)),
      Result<StateCollection, ErrorResponse>: (json) =>
          Success(StateCollection.fromJson(json)),
      Result<Website, ErrorResponse>: (json) => Success(Website.fromJson(json)),
      Result<WebsiteCrosssells, ErrorResponse>: (json) =>
          Success(WebsiteCrosssells.fromJson(json)),
      Result<WebsiteSettings, ErrorResponse>: (json) =>
          Success(WebsiteSettings.fromJson(json)),
      Result<WishList, ErrorResponse>: (json) =>
          Success(WishList.fromJson(json)),
      Result<WishListCollectionModel, ErrorResponse>: (json) =>
          Success(WishListCollectionModel.fromJson(json)),
      Result<WishListLineCollectionModel, ErrorResponse>: (json) =>
          Success(WishListLineCollectionModel.fromJson(json)),
    };

    final creator = typeMap[T];

    if (creator != null) {
      return creator(jsonMap) as T;
    }

    throw UnsupportedError('Type not supported');
  }
}
