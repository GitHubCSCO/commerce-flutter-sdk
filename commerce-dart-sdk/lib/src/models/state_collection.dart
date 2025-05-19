import 'models.dart';

part 'state_collection.g.dart';

@JsonSerializable()
class StateCollection extends BaseModel {
  List<StateModel>? states;

  StateCollection({this.states});

  factory StateCollection.fromJson(Map<String, dynamic> json) =>
      _$StateCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$StateCollectionToJson(this);
}
