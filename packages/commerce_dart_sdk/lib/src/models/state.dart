import 'models.dart';

part 'state.g.dart';

@JsonSerializable(explicitToJson: true)
class State extends BaseModel {
  State({
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

    factory State.fromJson(Map<String, dynamic> json) =>
      _$StateFromJson(json);
  Map<String, dynamic> toJson() => _$StateToJson(this);
}
