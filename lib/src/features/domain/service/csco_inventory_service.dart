import 'package:commerce_flutter_sdk/src/features/domain/model/csco_branch_inventory.dart';
import 'package:flutter/foundation.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// Service for CSCO's custom branch-inventory endpoint.
///
/// Endpoint: `GET /api/csc/inventory/getallbranchesinvenotry/{productId}`
///
/// This is a CSCO-specific addition that lives in the outer commerce_flutter_sdk
/// package rather than the upstream commerce-dart-sdk package, so future
/// Optimizely SDK upgrades don't conflict with custom CSCO behavior.
abstract class ICscoInventoryService {
  /// Fetch branch-level inventory for a product. Returns the parsed response,
  /// or a [Failure] if the call fails / times out.
  Future<Result<CscoBranchInventoryResponse, ErrorResponse>>
      getBranchInventory(String productId);
}

class CscoInventoryService implements ICscoInventoryService {
  CscoInventoryService({
    required IClientService clientService,
    required INetworkService networkService,
  })  : _clientService = clientService,
        _networkService = networkService;

  final IClientService _clientService;
  final INetworkService _networkService;

  static const String _basePath = '/api/csc/inventory/getallbranchesinvenotry';
  static const Duration _defaultTimeout = Duration(seconds: 15);

  @override
  Future<Result<CscoBranchInventoryResponse, ErrorResponse>> getBranchInventory(
      String productId) async {
    if (productId.isEmpty) {
      return Failure(ErrorResponse(message: 'productId is required'));
    }

    final isOnline = await _networkService.isOnline();
    if (!isOnline) {
      return Failure(ErrorResponse(message: 'No internet connection'));
    }

    final path = '$_basePath/$productId';

    try {
      final response = await _clientService.getAsync(
        path,
        timeout: _defaultTimeout,
      );

      switch (response) {
        case Success(value: final value):
          final data = value?.data;
          if (data is Map<String, dynamic>) {
            return Success(CscoBranchInventoryResponse.fromJson(data));
          }
          if (data is String && data.isNotEmpty) {
            // Defensive: some Dio configurations leave the body as a string.
            // Let the caller see the failure rather than silently returning
            // an empty list — better to log and surface the issue.
            debugPrint('[CscoInventoryService] expected JSON map, got String');
          }
          return Failure(
            ErrorResponse(message: 'Unexpected response shape'),
          );
        case Failure(errorResponse: final err):
          return Failure(err);
      }
    } catch (e, st) {
      debugPrint('[CscoInventoryService] getBranchInventory failed: $e\n$st');
      return Failure(ErrorResponse(message: e.toString()));
    }
  }
}
