import 'package:commerce_flutter_sdk/src/core/theme/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/model/csco_branch_inventory.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/warehouse_inventory/warehouse_inventory_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/warehouse_inventory/warehouse_inventory_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

/// Section labels. These match the desktop site copy. If you ever localize
/// these, hoist them into LocalizationConstants alongside `warehouseInventory`.
const String _kHomeBranchLabel = 'Home Branch';
const String _kRegionalBranchesLabel = 'Regional Branches';
const String _kOtherBranchesLabel = 'All Other Branches';

/// Color thresholds for the qty display, per product requirements:
///   qty < 3  →  warning yellow
///   qty >= 3 →  default text color (black-ish)
/// "Call for Availability" rows are always rendered with the default color.
const int _kLowStockThreshold = 3;

void viewWarehouseWidget(
  BuildContext context,
  String? id,
  String productNumber,
  String unitOfMeasure,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          LocalizationConstants.warehouseInventory.localized(),
          style: context.text.titleLarge,
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => sl<WarehouseInventoryCubit>()
              ..loadWarehouseInventory(id, productNumber, unitOfMeasure),
            child: BlocBuilder<WarehouseInventoryCubit, WareHouseInventoryState>(
              builder: (_, state) {
                if (state is WareHouseInventoryLoadingState ||
                    state is WareHouseInventoryInitialState) {
                  return _LoadingIndicator();
                }
                if (state is WareHouseInventoryFailureState) {
                  return _FailurePanel(onClose: () => Navigator.of(context).pop());
                }
                if (state is WareHouseInventoryLoadedState) {
                  if (!state.hasAny) {
                    return _EmptyPanel(onClose: () => Navigator.of(context).pop());
                  }
                  return _LoadedPanel(
                    state: state,
                    onClose: () => Navigator.of(context).pop(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    },
  );
}

// ---------------------------------------------------------------------------
// Subwidgets
// ---------------------------------------------------------------------------

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.progressiveDots(
          color: OptiAppColors.iconPrimary,
          size: 30,
        ),
      ],
    );
  }
}

class _FailurePanel extends StatelessWidget {
  const _FailurePanel({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "We couldn't load branch availability. Please try again later.",
              textAlign: TextAlign.center,
            ),
          ),
          PrimaryButton(
            text: LocalizationConstants.oK.localized(),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'No branch availability is currently available for this item.',
              textAlign: TextAlign.center,
            ),
          ),
          PrimaryButton(
            text: LocalizationConstants.oK.localized(),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _LoadedPanel extends StatelessWidget {
  const _LoadedPanel({required this.state, required this.onClose});
  final WareHouseInventoryLoadedState state;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final sections = <Widget>[];

    if (state.homeBranch != null) {
      sections.add(_BranchSection(
        title: _kHomeBranchLabel,
        branches: [state.homeBranch!],
      ));
    }
    if (state.regionalBranches.isNotEmpty) {
      sections.add(_BranchSection(
        title: _kRegionalBranchesLabel,
        branches: state.regionalBranches,
      ));
    }
    if (state.otherBranches.isNotEmpty) {
      sections.add(_BranchSection(
        title: _kOtherBranchesLabel,
        branches: state.otherBranches,
      ));
    }

    return SizedBox(
      width: 300.0,
      // Use a constrained, scrollable layout instead of computing height
      // manually — the old code multiplied a per-row height that didn't
      // account for section headers or wrapped branch names. Letting
      // SingleChildScrollView + ConstrainedBox handle it is simpler and
      // adapts naturally to different content sizes.
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: sections,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            PrimaryButton(
              text: LocalizationConstants.oK.localized(),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}

class _BranchSection extends StatelessWidget {
  const _BranchSection({required this.title, required this.branches});
  final String title;
  final List<CscoBranchInventory> branches;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
          child: Text(title, style: context.text.subtitle),
        ),
        const Divider(color: OptiAppColors.border, thickness: 1.0),
        for (final b in branches) _BranchRow(branch: b),
      ],
    );
  }
}

class _BranchRow extends StatelessWidget {
  const _BranchRow({required this.branch});
  final CscoBranchInventory branch;

  @override
  Widget build(BuildContext context) {
    final qty = branch.qty ?? 0;
    final isCallForAvailability = branch.isCallForAvailability;

    // Per requirements: never show qty=0 — fall back to the ERP's
    // human-readable availability string ("Call for Availability").
    final String trailingText;
    if (isCallForAvailability) {
      trailingText = branch.availability ?? 'Call for Availability';
    } else if (qty % 1 == 0) {
      trailingText = qty.toInt().toString();
    } else {
      trailingText = qty.toStringAsFixed(4);
    }

    // Per requirements: qty < 3 → warning color; otherwise default.
    // Call-for-Availability rows render in default color.
    final Color trailingColor = (!isCallForAvailability && qty < _kLowStockThreshold)
        ? Colors.orange.shade800
        : Colors.black;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(branch.warehouse ?? ''),
              ),
              const SizedBox(width: 8),
              Text(
                trailingText,
                style: TextStyle(color: trailingColor),
              ),
            ],
          ),
        ),
        const Divider(color: OptiAppColors.border, thickness: 1.0),
      ],
    );
  }
}