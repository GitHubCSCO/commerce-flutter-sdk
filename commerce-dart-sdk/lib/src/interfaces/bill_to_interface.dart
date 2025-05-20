import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// A service which fetches customer addresses
abstract class IBillToService {
  Future<Result<GetBillTosResult, ErrorResponse>> getBillTosAsync(
      {BillTosQueryParameters? parameters});

  Future<Result<BillTo, ErrorResponse>> postBillTosAsync(BillTo billTo);

  Future<Result<BillTo, ErrorResponse>> getBillTo(String billToId);

  Future<Result<BillTo, ErrorResponse>> getCurrentBillTo(
      {BillTosQueryParameters? parameters});

  Future<Result<BillTo, ErrorResponse>> patchBillTo(
      String billToId, BillTo billTo);

  Future<Result<BillTo, ErrorResponse>> patchCurrentBillTo(BillTo billTo);

  Future<Result<GetShipTosResult, ErrorResponse>> getShipTosAsync(
      String billToId,
      {ShipTosQueryParameters? parameters});

  Future<Result<GetShipTosResult, ErrorResponse>> getCurrentShipTos(
      {ShipTosQueryParameters? parameters});

  Future<Result<GetShipTosResult, ErrorResponse>> getCurrentBillToShipTosAsync(
      {ShipTosQueryParameters? parameters});

  Future<Result<ShipTo, ErrorResponse>> postShipToAsync(
      String billToId, ShipTo shipTo);

  Future<Result<ShipTo, ErrorResponse>> postCurrentBillToShipToAsync(
      ShipTo shipTo);

  Future<Result<ShipTo, ErrorResponse>> getShipTo(
      String billToId, String shipToId);

  Future<Result<ShipTo, ErrorResponse>> getCurrentShipTo();

  Future<Result<ShipTo, ErrorResponse>> patchShipTo(
      String billToId, String shipToId, ShipTo shipTo);

  Future<Result<ShipTo, ErrorResponse>> patchCurrentShipTo(ShipTo shipTo);
}
