import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToService extends ServiceBase implements IBillToService {
  BillToService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  static String _shipTosUrl(String billToId) =>
      "${CommerceAPIConstants.billTosUrl}/$billToId/shiptos";

  static String _billToIdUrl(String billToId) =>
      "${CommerceAPIConstants.billTosUrl}/$billToId";

  static String _shipToIdUrl(String billToId, String shipToId) =>
      "${CommerceAPIConstants.billTosUrl}/$billToId/shiptos/$shipToId";

  @override
  Future<Result<BillTo, ErrorResponse>> getBillTo(String billToId) async {
    String urlStr = _billToIdUrl(billToId);
    return await getAsyncNoCache<BillTo>(urlStr, BillTo.fromJson);
  }

  @override
  Future<Result<GetBillTosResult, ErrorResponse>> getBillTosAsync(
      {BillTosQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.billTosUrl);
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    return await getAsyncNoCache<GetBillTosResult>(
        url.toString(), GetBillTosResult.fromJson);
  }

  @override
  Future<Result<BillTo, ErrorResponse>> getCurrentBillTo(
      {BillTosQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.billToCurrentUrl);
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    return await getAsyncNoCache<BillTo>(url.toString(), BillTo.fromJson);
  }

  @override
  Future<Result<GetShipTosResult, ErrorResponse>> getCurrentBillToShipTosAsync(
      {ShipTosQueryParameters? parameters}) async {
    var url = Uri.parse(CommerceAPIConstants.billToCurrentShipTosUrl);
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    return await getAsyncNoCache<GetShipTosResult>(
        url.toString(), GetShipTosResult.fromJson);
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> getCurrentShipTo() async {
    return await getAsyncNoCache<ShipTo>(
        CommerceAPIConstants.billToCurrentShipToCurrentUrl, ShipTo.fromJson);
  }

  @override
  Future<Result<GetShipTosResult, ErrorResponse>> getCurrentShipTos(
      {ShipTosQueryParameters? parameters}) async {
    var url = Uri.parse('${CommerceAPIConstants.billTosUrl}/current/shiptos');
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    return await getAsyncNoCache<GetShipTosResult>(
        url.toString(), GetShipTosResult.fromJson);
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> getShipTo(
      String billToId, String shipToId) async {
    String urlStr = _shipToIdUrl(billToId, shipToId);
    return await getAsyncNoCache<ShipTo>(urlStr, ShipTo.fromJson);
  }

  @override
  Future<Result<GetShipTosResult, ErrorResponse>> getShipTosAsync(
      String billToId,
      {ShipTosQueryParameters? parameters}) async {
    var url = Uri.parse(_shipTosUrl(billToId));
    if (parameters != null) {
      final parameterJson = parameters.toJson();
      url = url.replace(queryParameters: parameterJson);
    }

    return await getAsyncNoCache<GetShipTosResult>(
        url.toString(), GetShipTosResult.fromJson);
  }

  @override
  Future<Result<BillTo, ErrorResponse>> patchBillTo(
      String billToId, BillTo billTo) async {
    String urlStr = _billToIdUrl(billToId);
    final data = serialize(billTo, (billTo) => billTo.toJson());

    return await patchAsyncNoCache<BillTo>(urlStr, data, BillTo.fromJson);
  }

  @override
  Future<Result<BillTo, ErrorResponse>> patchCurrentBillTo(
      BillTo billTo) async {
    final data = billTo.toJson();
    return await patchAsyncNoCache<BillTo>(
        CommerceAPIConstants.billToCurrentUrl, data, BillTo.fromJson);
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> patchCurrentShipTo(
      ShipTo shipTo) async {
    final data = shipTo.toJson();
    return await postAsyncNoCache<ShipTo>(
      CommerceAPIConstants.billToCurrentShipToCurrentUrl,
      data,
      ShipTo.fromJson,
    );
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> patchShipTo(
      String billToId, String shipToId, ShipTo shipTo) async {
    String urlStr = _shipToIdUrl(billToId, shipToId);
    final data = shipTo.toJson();

    return await patchAsyncNoCache<ShipTo>(urlStr, data, ShipTo.fromJson);
  }

  @override
  Future<Result<BillTo, ErrorResponse>> postBillTosAsync(BillTo billTo) async {
    final data = billTo.toJson();
    return await postAsyncNoCache<BillTo>(
        CommerceAPIConstants.billTosUrl, data, BillTo.fromJson);
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> postCurrentBillToShipToAsync(
      ShipTo shipTo) async {
    final data = shipTo.toJson();
    return await postAsyncNoCache<ShipTo>(
        CommerceAPIConstants.billToCurrentShipTosUrl, data, ShipTo.fromJson);
  }

  @override
  Future<Result<ShipTo, ErrorResponse>> postShipToAsync(
      String billToId, ShipTo shipTo) async {
    final data = shipTo.toJson();
    return await postAsyncNoCache<ShipTo>(
        _shipTosUrl(billToId), data, ShipTo.fromJson);
  }
}
