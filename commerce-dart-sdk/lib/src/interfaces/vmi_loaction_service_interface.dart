import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IVmiLocationsService {
  Future<Result<GetVmiLocationResult, ErrorResponse>> getVmiLocations(
      {VmiLocationQueryParameters parameters});
  Future<Result<GetVmiBinResult, ErrorResponse>> getVmiBins(
      {VmiBinQueryParameters parameters});
  Future<Result<GetVmiCountResult, ErrorResponse>> getBinCounts(
      {VmiCountQueryParameters parameters});
  Future<Result<GetVmiNoteResult, ErrorResponse>> getVmiLocationNotes(
      {BaseVmiLocationQueryParameters parameters});

  Future<Result<VmiLocationModel, ErrorResponse>> getVmiLocation(
      {VmiLocationDetailParameters parameters});
  Future<Result<VmiBinModel, ErrorResponse>> getVmiBin(
      {VmiBinDetailParameters parameters});
  Future<Result<VmiCountModel, ErrorResponse>> getBinCount(
      {VmiCountDetailParameters parameters});
  Future<Result<VmiNoteModel, ErrorResponse>> getVmiBinNote(
      {VmiNoteDetailParameters parameters});

  Future<Result<VmiLocationModel, ErrorResponse>> saveVmiLocation(
      VmiLocationModel model);
  Future<Result<VmiBinModel, ErrorResponse>> saveVmiBin(
      String vmiLocationId, VmiBinModel model);
  Future<Result<VmiCountModel, ErrorResponse>> saveBinCount(
      String vmiLocationId, String vmiBinId, VmiCountModel model);
  Future<Result<VmiNoteModel, ErrorResponse>> saveVmiBinNote(
      String vmiLocationId, String vmiBinId, VmiNoteModel model);

  Future<Result<VmiLocationModel, ErrorResponse>> deleteVmiLocation(
      String vmiLocationId);
  Future<Result<VmiBinModel, ErrorResponse>> deleteVmiBin(
      String vmiLocationId, String vmiBinId);
  Future<Result<VmiCountModel, ErrorResponse>> deleteBinCount(
      String vmiLocationId, String vmiBinId, String vmiCountId);
  Future<Result<VmiNoteModel, ErrorResponse>> deleteVmiBinNote(
      String vmiLocationId, String vmiBinId, String vmiNoteId);

  Future<Result<GetProductCollectionResult, ErrorResponse>> getProducts(
      {VmiLocationProductParameters parameters});
  Future<Result<List<AutocompleteProduct>, ErrorResponse>>
      getAutocompleteProducts({VmiLocationProductParameters parameters});
}
