import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/filter.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_filter/wish_list_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/date_picker_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';

class WishlistFilterWidget extends StatelessWidget {
  final WishListsQueryParameters wishListsQueryParameters;
  final bool hasFilter;
  final void Function({
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    String? erpNumber,
    String? brandId,
    String? sharedBy,
  }) onApply;

  const WishlistFilterWidget({
    super.key,
    required this.wishListsQueryParameters,
    required this.hasFilter,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WishListFilterCubit>(),
      child: Builder(
        builder: (BuildContext context) {
          return badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 0),
            badgeStyle: const badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.black,
              padding: EdgeInsets.all(6),
              elevation: 0,
            ),
            showBadge: hasFilter,
            child: IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {
                context.read<WishListFilterCubit>().initialize(
                      wishListsQueryParameters: wishListsQueryParameters,
                    );

                _showWishListFilterWidget(
                  context,
                  onReset: () => context.read<WishListFilterCubit>().reset(),
                  onApply: () {
                    final state = context.read<WishListFilterCubit>().state;
                    onApply(
                      fromCreatedDate: state.fromCreatedDate,
                      toCreatedDate: state.toCreatedDate,
                      fromUpdatedOn: state.fromUpdatedOn,
                      toUpdatedOn: state.toUpdatedOn,
                      erpNumber: state.erpNumber,
                      brandId: state.brandId,
                      sharedBy: state.sharedBy,
                    );
                  },
                );
              },
              icon: SvgAssetImage(
                height: 20,
                width: 20,
                assetName: AssetConstants.filterIcon,
                semanticsLabel: 'filter icon',
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showWishListFilterWidget(
  BuildContext context, {
  required void Function() onApply,
  required void Function() onReset,
}) {
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: onReset,
    child: BlocProvider.value(
      value: BlocProvider.of<WishListFilterCubit>(context),
      child: BlocBuilder<WishListFilterCubit, WishListFilterState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WishListFilterDateSectionWidget(
                sectionTitle: LocalizationConstants.dateCreated.localized(),
                fromDate: state.fromCreatedDate,
                toDate: state.toCreatedDate,
                onFromDateSelected: (context, date) {
                  context.read<WishListFilterCubit>().setFromCreatedDate(date);
                },
                onToDateSelected: (context, date) {
                  context.read<WishListFilterCubit>().setToCreatedDate(date);
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}

class _WishListFilterDateSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final DateTime? fromDate;
  final DateTime? toDate;
  final void Function(BuildContext context, DateTime? date) onFromDateSelected;
  final void Function(BuildContext context, DateTime? date) onToDateSelected;

  const _WishListFilterDateSectionWidget({
    required this.sectionTitle,
    required this.fromDate,
    required this.toDate,
    required this.onFromDateSelected,
    required this.onToDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _WishListFilterDatePickerWidget(
              selectedDate: fromDate,
              title: LocalizationConstants.from.localized(),
              onDateSelected: onFromDateSelected,
            ),
            const SizedBox(width: 16),
            _WishListFilterDatePickerWidget(
              selectedDate: toDate,
              title: LocalizationConstants.to.localized(),
              onDateSelected: onToDateSelected,
            ),
          ],
        ),
      ],
    );
  }
}

class _WishListFilterDatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final String title;
  final void Function(BuildContext context, DateTime? date) onDateSelected;

  const _WishListFilterDatePickerWidget({
    required this.selectedDate,
    required this.title,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: OptiAppColors.backgroundGray,
            ),
            child: DatePickerWidget(
              key: UniqueKey(),
              minDate: DateTime(1970),
              maxDate: null,
              selectedDateTime: selectedDate,
              callback: onDateSelected,
            ),
          ),
        ],
      ),
    );
  }
}
