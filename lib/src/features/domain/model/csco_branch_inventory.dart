/// Models for the custom CSCO endpoint:
/// `GET /api/csc/inventory/getallbranchesinvenotry/{productId}`
///
/// This is intentionally separate from the upstream Optimizely
/// [InventoryWarehouse] model because the CSCO ERP returns a very different
/// shape, and we don't want to pollute the upstream SDK package.
library;

/// Top-level response wrapper.
class CscoBranchInventoryResponse {
  CscoBranchInventoryResponse({this.inventoryList});

  final List<CscoBranchInventory>? inventoryList;

  factory CscoBranchInventoryResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['inventoryList'];
    return CscoBranchInventoryResponse(
      inventoryList: raw is List
          ? raw
              .whereType<Map<String, dynamic>>()
              .map(CscoBranchInventory.fromJson)
              .toList()
          : null,
    );
  }
}

/// One warehouse entry in the CSCO response.
///
/// NOTE on the misspelled "warehosue" field: this matches the actual JSON key
/// returned by the ERP today. We read both "warehosue" and "warehouse" so
/// this model survives the ERP team fixing the typo upstream.
class CscoBranchInventory {
  CscoBranchInventory({
    this.warehouse,
    this.qty,
    this.isDefault,
    this.availability,
    this.isRegional,
  });

  /// Display name of the branch (e.g. "Tigard").
  final String? warehouse;

  /// On-hand quantity. May be `0` for branches where availability must be
  /// resolved by phone — see [availability].
  final num? qty;

  /// True for the user's home branch. Exactly one entry should have this set.
  final bool? isDefault;

  /// Human-readable availability string from the ERP. For most branches this
  /// is the quantity as a string (e.g. "454"). For branches that can't quote
  /// a number, this is the literal text "Call for Availability".
  final String? availability;

  /// True if this branch is in the user's regional group. Used for the
  /// "Regional Branches" vs "All Other Branches" split in the modal.
  final bool? isRegional;

  /// Convenience: true if the ERP couldn't quote a number and we should fall
  /// back to the [availability] text instead of showing a number.
  bool get isCallForAvailability {
    final q = qty ?? 0;
    return q <= 0;
  }

  factory CscoBranchInventory.fromJson(Map<String, dynamic> json) {
    return CscoBranchInventory(
      warehouse: (json['warehosue'] ?? json['warehouse']) as String?,
      qty: json['qty'] as num?,
      isDefault: json['isDefault'] as bool?,
      availability: json['availability'] as String?,
      isRegional: json['isRegional'] as bool?,
    );
  }
}
