import 'package:commerce_flutter_sdk/src/features/domain/model/csco_branch_inventory.dart';

abstract class WareHouseInventoryState {}

class WareHouseInventoryInitialState extends WareHouseInventoryState {}

class WareHouseInventoryLoadingState extends WareHouseInventoryState {}

/// Successful load. The three sections render in this order in the modal:
///
///   1. Home Branch         — exactly one entry (the user's default branch),
///                            or null if the ERP didn't flag any branch.
///   2. Regional Branches    — branches with isRegional == true (excluding
///                            the home branch).
///   3. All Other Branches   — branches with isRegional == false / null
///                            (excluding the home branch).
class WareHouseInventoryLoadedState extends WareHouseInventoryState {
  WareHouseInventoryLoadedState({
    this.homeBranch,
    this.regionalBranches = const [],
    this.otherBranches = const [],
  });

  final CscoBranchInventory? homeBranch;
  final List<CscoBranchInventory> regionalBranches;
  final List<CscoBranchInventory> otherBranches;

  bool get hasAny =>
      homeBranch != null ||
      regionalBranches.isNotEmpty ||
      otherBranches.isNotEmpty;
}

class WareHouseInventoryFailureState extends WareHouseInventoryState {}
