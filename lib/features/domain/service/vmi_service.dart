// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/vmi_service_interface.dart';

class VMIService extends ServiceBase implements IVmiService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  final ICoreServiceProvider _coreServiceProvider;

  VMIService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
    required ICoreServiceProvider coreServiceProvider,
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  })  : _commerceAPIServiceProvider = commerceAPIServiceProvider,
        _coreServiceProvider = coreServiceProvider;
  @override
  // TODO: implement currentVmiLocation
  VmiLocationModel? currentVmiLocation;

  String googlePlacesAPIUrl =
      "https://maps.googleapis.com/maps/api/geocode/json";

  @override
  Future<VmiLocationModel?> getClosestVmiLocation() async {
    String key =
        '${CoreConstants.currentVmiLocationKey}:${_commerceAPIServiceProvider.getClientService().host}:${_commerceAPIServiceProvider.getSessionService().getCachedCurrentSession()?.userName}';
    VmiLocationModel? closestVmiLocationPersisted;
    try {
      closestVmiLocationPersisted = await _commerceAPIServiceProvider
          .getCacheService()
          .loadPersistedData<VmiLocationModel>(key);
      // ignore: empty_catches
    } catch (e) {}

    if (closestVmiLocationPersisted != null) {
      currentVmiLocation = closestVmiLocationPersisted;
      return closestVmiLocationPersisted;
    }
    VmiLocationModel? closestVmiLocation;
    VmiLocationQueryParameters param = VmiLocationQueryParameters(
      pageSize: 1,
      page: 1,
      expand: ['customer'],
    );

    var result = await _commerceAPIServiceProvider
        .getVmiLocationsService()
        .getVmiLocations(parameters: param);

    switch (result) {
      case Success(value: final data):
        closestVmiLocation = data?.vmiLocations.first;
        currentVmiLocation = closestVmiLocation;
        await _commerceAPIServiceProvider
            .getCacheService()
            .persistData<VmiLocationModel>(key, closestVmiLocation!);
      case Failure(errorResponse: final errorResponse):
        _coreServiceProvider
            .getTrackingService()
            .trackError(errorResponse)
            .ignore();
    }

    return closestVmiLocation;
  }

  @override
  Future<GooglePlace?> getPlace(String searchQuery) async {
    var result = await _commerceAPIServiceProvider
        .getSettingsService()
        .getWebsiteSettingsAsync();

    WebsiteSettings? websiteSettings =
        (result is Success) ? (result as Success).value : null;
    searchQuery = Uri.encodeComponent(searchQuery);

    List<String> parameters = [];
    parameters.add('address=$searchQuery');
    parameters.add('key=${websiteSettings?.googleMapsApiKey}');

    String url = googlePlacesAPIUrl + '?' + parameters.join('&');
    var resultResponse = await getAsyncStringResultNoCache(url);
    String? resultResponseStr =
        (resultResponse is Success) ? (resultResponse as Success).value : null;

    if (result != null) {
      try {
        var googleGeocodeResponse = jsonDecode(resultResponseStr!);
        if (googleGeocodeResponse['results'] != null &&
            googleGeocodeResponse['results'].length > 0) {
          var candidate = googleGeocodeResponse['results'][0];
          if (candidate['geometry']['location'] != null) {
            return GooglePlace(
              formattedName: candidate['formatted_address'],
              latitude: candidate['geometry']['location']['lat'],
              longitude: candidate['geometry']['location']['lng'],
            );
          }
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        // handle the error as needed
      }
    }

    return null;
  }

  @override
  Future<LatLong?> getPlaceFromAddress(Address? address) async {
    String fullAddress =
        "${address?.address1} ${address?.city} ${(address?.state == null ? '' : address?.state?.name)} ${address?.postalCode}";
    GooglePlace? result = await getPlace(fullAddress);
    if (result != null) {
      return LatLong(
        latitude: result.latitude,
        longitude: result.longitude,
      );
    }

    return null;
  }

  @override
  void saveCurrentVmiLocation(VmiLocationModel vmiLocation) {
    currentVmiLocation = vmiLocation;
    String key =
        '${CoreConstants.currentVmiLocationKey}:${_commerceAPIServiceProvider.getClientService().host}:${_commerceAPIServiceProvider.getSessionService().getCachedCurrentSession()?.userName}';
    _commerceAPIServiceProvider.getCacheService().persistData(key, vmiLocation);
  }

  @override
  void updateCurrentVmiLocation() {
    // TODO: implement updateCurrentVmiLocation
  }
}
