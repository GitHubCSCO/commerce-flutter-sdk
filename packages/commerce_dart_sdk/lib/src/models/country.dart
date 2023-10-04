import 'models.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country extends BaseModel {
  Country({
    this.abbreviation,
    this.id,
    this.name,
    this.states,
  });

  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the abbreviation.
  String? abbreviation;

  /// Gets or sets the states.
  List<State>? states;

    factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
