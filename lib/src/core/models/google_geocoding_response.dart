class Northeast {
  double lat;
  double lng;

  Northeast({required this.lat, required this.lng});
}

class Southwest {
  double lat;
  double lng;

  Southwest({required this.lat, required this.lng});
}

class GeoLocation {
  double lat;
  double lng;

  GeoLocation({required this.lat, required this.lng});
}

class Viewport {
  Northeast northeast;
  Southwest southwest;

  Viewport({required this.northeast, required this.southwest});
}

class Geometry {
  GeoLocation location;
  String locationType;
  Viewport viewport;

  Geometry(
      {required this.location,
      required this.locationType,
      required this.viewport});
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({required this.compoundCode, required this.globalCode});
}

class GeoResult {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  Geometry geometry;
  String placeId;
  PlusCode plusCode;
  List<String> types;

  GeoResult(
      {required this.addressComponents,
      required this.formattedAddress,
      required this.geometry,
      required this.placeId,
      required this.plusCode,
      required this.types});
}

class GoogleGeocodingResponse {
  List<GeoResult> results;
  String status;

  GoogleGeocodingResponse({required this.results, required this.status});
}

class AddressComponent {
  String long_name;
  String short_name;
  List<String> types;

  AddressComponent(
      {required this.long_name, required this.short_name, required this.types});
}
