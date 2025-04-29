import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/menu/display_option.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

List<DisplayOption> _getDisplayOptions(
  List<SortOrderAttribute> availableSortOrders,
  void Function(SortOrderAttribute) onSortOrderChanged,
) {
  final sortOrderGroups = availableSortOrders
      .map((sortOrder) => sortOrder.groupTitle)
      .toSet()
      .toList();

  final result = <DisplayOption>[];

  for (final group in sortOrderGroups) {
    final groupSortOrders = availableSortOrders
        .where((sortOrder) => sortOrder.groupTitle == group)
        .toList();

    if (groupSortOrders.length > 1) {
      final sortOrder = groupSortOrders.first;
      final oppositeSortOrder = groupSortOrders.last;

      final displayOption = DisplayOption(
        action: () async {},
        title: sortOrder.title,
        sortOrder: sortOrder,
        oppositeSortOrder: oppositeSortOrder,
      );

      result.add(displayOption);
    } else {
      final sortOrder = groupSortOrders.first;

      final displayOption = DisplayOption(
        action: () async {},
        title: sortOrder.title,
        sortOrder: sortOrder,
      );

      result.add(displayOption);
    }
  }

  return result;
}

class SortToolMenu extends StatelessWidget {
  final List<DisplayOption> displayOptions;
  final SortOrderAttribute selectedSortOrder;
  final Future<void> Function(SortOrderAttribute) onSortOrderChanged;
  final void Function()? onSortOrderCancel;
  final isMenuCloseManually = true;

  SortToolMenu({
    super.key,
    required List<SortOrderAttribute> availableSortOrders,
    required this.onSortOrderChanged,
    this.onSortOrderCancel,
    required this.selectedSortOrder,
  }) : displayOptions = _getDisplayOptions(
          availableSortOrders,
          onSortOrderChanged,
        ) {
    init();
  }

  Future<void> _onSortOrderChanged(SortOrderAttribute sortOrder,
      SortOrderAttribute? oppositeSortOrder) async {
    if (sortOrder != selectedSortOrder) {
      await onSortOrderChanged(sortOrder);
    } else {
      if (oppositeSortOrder != null) {
        await onSortOrderChanged(oppositeSortOrder);
      }
    }
  }

  void init() {
    for (var displayOption in displayOptions) {
      displayOption.action = () async {
        await _onSortOrderChanged(
          displayOption.sortOrder!,
          displayOption.oppositeSortOrder,
        );
      };
    }
  }

  Future<void> _showBottomMenu(
      BuildContext context, List<DisplayOption> displayOptionsList) async {
    context.read<RootBloc>().add(
          RootAnalyticsEvent(
            AnalyticsEvent(
              AnalyticsConstants.eventViewScreen,
              AnalyticsConstants.screenNameSortSelection,
            ),
          ),
        );
    final result = await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text(LocalizationConstants.sortBy.localized(),
              style: OptiTextStyles.bodySmall),
          actions: _getToolMenuWidgets(context, displayOptionsList),
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              LocalizationConstants.cancel.localized(),
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () => Navigator.pop(context, isMenuCloseManually),
          ),
        );
      },
    );

    //Check whether user close menu manually
    if (result == null || result == true) {
      onSortOrderCancel?.call();
    }
  }

  List<Widget> _getToolMenuWidgets(
    BuildContext context,
    List<DisplayOption> displayOptionList,
  ) {
    List<Widget> widgets = [];

    widgets.addAll(displayOptionList.map((value) {
      return CupertinoActionSheetAction(
        onPressed: () async {
          if (context.mounted) {
            Navigator.pop(context, !isMenuCloseManually);
          }
          await value.action();
        },
        child: Text(
          () {
            if (value.sortOrder == selectedSortOrder) {
              return value.sortOrder?.title ?? '';
            } else if (value.oppositeSortOrder == selectedSortOrder) {
              return value.oppositeSortOrder?.title ?? '';
            } else {
              return value.sortOrder?.groupTitle ?? '';
            }
          }(),
          style: const TextStyle(color: Colors.blue),
        ),
      );
    }));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(10),
      onPressed: () async => _showBottomMenu(context, displayOptions),
      icon: SvgAssetImage(
        height: 20,
        width: 20,
        assetName: AssetConstants.sortIcon,
        semanticsLabel: 'sort icon',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class SortToolMenuHelper {
  static List<SortOrderAttribute> convertOptionToAttribute({
    required List<SortOption> sortOptions,
  }) {
    return sortOptions
        .map(
          (e) => SortOrderAttribute(
            groupTitle: e.displayName ?? '',
            title: '${e.displayName ?? ''} \u2713',
            value: e.sortType ?? '',
          ),
        )
        .toList();
  }

  static SortOrderAttribute getSelectedSortOrder({
    required List<SortOrderAttribute> availableSortOrders,
    required String selectedSortOrderType,
  }) {
    return availableSortOrders.firstWhere(
      (element) => element.value == selectedSortOrderType,
      orElse: () => availableSortOrders.first,
    );
  }
}
