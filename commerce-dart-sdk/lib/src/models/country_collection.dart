import 'models.dart';

part 'country_collection.g.dart';

@JsonSerializable()
class CountryCollection extends BaseModel {
  List<Country>? countries;

  CountryCollection({
    this.countries,
  });

  factory CountryCollection.fromJson(Map<String, dynamic> json) =>
      _$CountryCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCollectionToJson(this);
}
