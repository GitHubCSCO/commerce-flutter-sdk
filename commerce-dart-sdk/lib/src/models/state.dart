import 'models.dart';

part 'state.g.dart';

@JsonSerializable(explicitToJson: true)
class StateModel extends BaseModel {
  StateModel({
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
  List<StateModel>? states;

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);
  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}
