import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_parameters_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/filter.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_filter/wish_list_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/wish_list/wish_list_filter_autocomplete_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/date_picker_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';

class WishlistFilterWidget extends StatelessWidget {
  final WishListFilterParametersEntity wishListFilterParameters;
  final bool hasFilter;
  final void Function({
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    WishListFilterItemEntity? product,
    WishListFilterItemEntity? brand,
    WishListFilterItemEntity? sharedByUser,
  }) onApply;

  const WishlistFilterWidget({
    super.key,
    required this.wishListFilterParameters,
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
                      wishListFilterParameters: wishListFilterParameters
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
                      product: state.product,
                      brand: state.brand,
                      sharedByUser: state.sharedByUser,
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
              const SizedBox(height: 32),
              _WishListFilterDateSectionWidget(
                sectionTitle: LocalizationConstants.dateUpdated.localized(),
                fromDate: state.fromUpdatedOn,
                toDate: state.toUpdatedOn,
                onFromDateSelected: (context, date) {
                  context.read<WishListFilterCubit>().setFromUpdatedOn(date);
                },
                onToDateSelected: (context, date) {
                  context.read<WishListFilterCubit>().setToUpdatedOn(date);
                },
              ),
              const SizedBox(height: 32),
              _WishListFilterAutocompleteWidget(
                type: WishListFilterAutocompleteType.sharedBy,
                selectedValue: state.sharedByUser?.displayValue,
                onValueSelected: (context, value) {
                  context.read<WishListFilterCubit>().setSharedBy(value);
                },
              ),
              const SizedBox(height: 32),
              _WishListFilterAutocompleteWidget(
                type: WishListFilterAutocompleteType.erpNumber,
                selectedValue: state.product?.displayValue,
                onValueSelected: (context, value) {
                  context.read<WishListFilterCubit>().setProduct(value);
                },
              ),
              const SizedBox(height: 32),
              _WishListFilterAutocompleteWidget(
                type: WishListFilterAutocompleteType.brandId,
                selectedValue: state.brand?.displayValue,
                onValueSelected: (context, value) {
                  context.read<WishListFilterCubit>().setBrandId(value);
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
          style: OptiTextStyles.subtitle,
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

class _WishListFilterAutocompleteWidget extends StatelessWidget {
  final WishListFilterAutocompleteType type;
  final String? selectedValue;
  final void Function(BuildContext context, WishListFilterItemEntity? value)
      onValueSelected;

  const _WishListFilterAutocompleteWidget({
    required this.type,
    required this.selectedValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          switch (type) {
            WishListFilterAutocompleteType.erpNumber =>
              LocalizationConstants.product.localized(),
            WishListFilterAutocompleteType.brandId =>
              LocalizationConstants.brand.localized(),
            WishListFilterAutocompleteType.sharedBy =>
              LocalizationConstants.sharedByNoFormat.localized(),
          },
          style: OptiTextStyles.subtitle,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final selectedValue = await context.pushNamed(
                AppRoute.wishListFilterAutocomplete.name,
                pathParameters: {
                  'filterType': switch (type) {
                    WishListFilterAutocompleteType.erpNumber =>
                      WishListFilterAutocompleteType.erpNumberKey,
                    WishListFilterAutocompleteType.brandId =>
                      WishListFilterAutocompleteType.brandIdKey,
                    WishListFilterAutocompleteType.sharedBy =>
                      WishListFilterAutocompleteType.sharedByKey,
                  }
                }) as WishListFilterItemEntity?;

            if (context.mounted) {
              if (selectedValue == null) {
                return;
              }

              onValueSelected(context, selectedValue);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: OptiAppColors.backgroundGray,
            ),
            child: Text(
              selectedValue ??
                  switch (type) {
                    WishListFilterAutocompleteType.erpNumber =>
                      LocalizationConstants.searchForAProduct.localized(),
                    WishListFilterAutocompleteType.brandId =>
                      LocalizationConstants.searchForABrand.localized(),
                    WishListFilterAutocompleteType.sharedBy =>
                      LocalizationConstants.searchByUsername.localized(),
                  },
              style: selectedValue == null
                  ? OptiTextStyles.body
                      .copyWith(color: OptiAppColors.buttonTextDisabledColor)
                  : OptiTextStyles.body,
            ),
          ),
        ),
      ],
    );
  }
}
