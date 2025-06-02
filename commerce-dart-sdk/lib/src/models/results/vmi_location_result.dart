import '../models.dart';

part 'vmi_location_result.g.dart';

@JsonSerializable()
class GetVmiLocationResult extends BaseModel {
  Pagination pagination;
  List<VmiLocationModel> vmiLocations;

  GetVmiLocationResult({
    required this.pagination,
    required this.vmiLocations,
  });

  factory GetVmiLocationResult.fromJson(Map<String, dynamic> json) =>
      _$GetVmiLocationResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetVmiLocationResultToJson(this);
}

@JsonSerializable()
class GetVmiBinResult extends BaseModel {
  Pagination pagination;
  List<VmiBinModel> vmiBins;

  GetVmiBinResult({
    required this.pagination,
    required this.vmiBins,
  });

  factory GetVmiBinResult.fromJson(Map<String, dynamic> json) =>
      _$GetVmiBinResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetVmiBinResultToJson(this);
}

@JsonSerializable()
class GetVmiCountResult extends BaseModel {
  Pagination pagination;
  List<VmiCountModel> vmiCounts;

  GetVmiCountResult({
    required this.pagination,
    required this.vmiCounts,
  });

  factory GetVmiCountResult.fromJson(Map<String, dynamic> json) =>
      _$GetVmiCountResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetVmiCountResultToJson(this);
}

@JsonSerializable()
class GetVmiNoteResult extends BaseModel {
  Pagination pagination;
  List<VmiNoteModel> vmiNotes;

  GetVmiNoteResult({
    required this.pagination,
    required this.vmiNotes,
  });

  factory GetVmiNoteResult.fromJson(Map<String, dynamic> json) =>
      _$GetVmiNoteResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetVmiNoteResultToJson(this);
}
