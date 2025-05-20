import 'package:dio/dio.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationService extends ServiceBase implements IVmiLocationsService {
  VMILocationService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });
  CancelToken _cancellationTokenSource = CancelToken();
  @override
  Future<Result<VmiCountModel, ErrorResponse>> deleteBinCount(
      String vmiLocationId, String vmiBinId, String vmiCountId) {
    // TODO: implement deleteBinCount
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiBinModel, ErrorResponse>> deleteVmiBin(
      String vmiLocationId, String vmiBinId) {
    // TODO: implement deleteVmiBin
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiNoteModel, ErrorResponse>> deleteVmiBinNote(
      String vmiLocationId, String vmiBinId, String vmiNoteId) {
    // TODO: implement deleteVmiBinNote
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiLocationModel, ErrorResponse>> deleteVmiLocation(
      String vmiLocationId) {
    // TODO: implement deleteVmiLocation
    throw UnimplementedError();
  }

  @override
  Future<Result<List<AutocompleteProduct>, ErrorResponse>>
      getAutocompleteProducts({VmiLocationProductParameters? parameters}) {
    // TODO: implement getAutocompleteProducts
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiCountModel, ErrorResponse>> getBinCount(
      {VmiCountDetailParameters? parameters}) {
    // TODO: implement getBinCount
    throw UnimplementedError();
  }

  @override
  Future<Result<GetVmiCountResult, ErrorResponse>> getBinCounts(
      {VmiCountQueryParameters? parameters}) {
    // TODO: implement getBinCounts
    throw UnimplementedError();
  }

  @override
  Future<Result<GetProductCollectionResult, ErrorResponse>> getProducts(
      {VmiLocationProductParameters? parameters}) {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiBinModel, ErrorResponse>> getVmiBin(
      {VmiBinDetailParameters? parameters}) {
    // TODO: implement getVmiBin
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiNoteModel, ErrorResponse>> getVmiBinNote(
      {VmiNoteDetailParameters? parameters}) {
    // TODO: implement getVmiBinNote
    throw UnimplementedError();
  }

  @override
  Future<Result<GetVmiBinResult, ErrorResponse>> getVmiBins(
      {VmiBinQueryParameters? parameters}) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.vmiLocationsUrl}/${parameters?.vmiLocationId}/bins');
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    final urlString = url.toString();
    return await getAsyncNoCache<GetVmiBinResult>(
        urlString, GetVmiBinResult.fromJson);
  }

  @override
  Future<Result<VmiLocationModel, ErrorResponse>> getVmiLocation(
      {VmiLocationDetailParameters? parameters}) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.vmiLocationsUrl}/${parameters?.vmiLocationId!}');

    if (parameters?.expand != null) {
      url = url.replace(queryParameters: parameters?.toJson());
    }

    var response = await getAsyncNoCache<VmiLocationModel>(
        url.toString(), VmiLocationModel.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetVmiNoteResult, ErrorResponse>> getVmiLocationNotes(
      {BaseVmiLocationQueryParameters? parameters}) {
    // TODO: implement getVmiLocationNotes
    throw UnimplementedError();
  }

  @override
  Future<Result<GetVmiLocationResult, ErrorResponse>> getVmiLocations(
      {VmiLocationQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.vmiLocationsUrl);
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    var response = await getAsyncNoCache<GetVmiLocationResult>(
        url.toString(), GetVmiLocationResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<VmiCountModel, ErrorResponse>> saveBinCount(
      String vmiLocationId, String vmiBinId, VmiCountModel model) async {
    final data = model.toJson();

    if (model.id == null || model.id!.isEmpty) {
      var url = Uri.parse(
          '${CommerceAPIConstants.vmiLocationsUrl}/$vmiLocationId/bins/$vmiBinId/bincounts');

      var response = await postAsyncNoCache<VmiCountModel>(
          url.toString(), data, VmiCountModel.fromJson);
      return response;
    } else {
      final id = model.id;
      var url = Uri.parse(
          '${CommerceAPIConstants.vmiLocationsUrl}/$vmiLocationId/bins/$vmiBinId/bincounts/$id');

      var response = await patchAsyncNoCache<VmiCountModel>(
          url.toString(), data, VmiCountModel.fromJson);
      return response;
    }
  }

  @override
  Future<Result<VmiBinModel, ErrorResponse>> saveVmiBin(
      String vmiLocationId, VmiBinModel model) {
    // TODO: implement saveVmiBin
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiNoteModel, ErrorResponse>> saveVmiBinNote(
      String vmiLocationId, String vmiBinId, VmiNoteModel model) {
    // TODO: implement saveVmiBinNote
    throw UnimplementedError();
  }

  @override
  Future<Result<VmiLocationModel, ErrorResponse>> saveVmiLocation(
      VmiLocationModel model) async {
    var url = Uri.parse(CommerceAPIConstants.vmiLocationsUrl);
    final data = serialize(model,
        (VmiLocationModel vmiLocationModel) => vmiLocationModel.toJson());

    if (model.id.isEmpty) {
      return await postAsyncNoCache<VmiLocationModel>(
        url.toString(),
        data,
        VmiLocationModel.fromJson,
        cancelToken: _cancellationTokenSource,
      );
    } else {
      var url =
          Uri.parse('${CommerceAPIConstants.vmiLocationsUrl}/${model.id}');

      return await patchAsyncNoCache<VmiLocationModel>(
        url.toString(),
        data,
        VmiLocationModel.fromJson,
        cancelToken: _cancellationTokenSource,
      );
    }
  }
}
