import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/billto_shipto/billto_shipto_address_selection_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/date_picker_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FilterValueViewModel {
  FilterValueViewModel({
    required this.id,
    required this.title,
    this.facetType,
    this.isSelected,
  });

  final String id;

  final String title;

  final FacetType? facetType;

  final bool? isSelected;

  FilterValueViewModel copyWith({
    String? id,
    String? title,
    FacetType? facetType,
    bool? isSelected,
  }) {
    return FilterValueViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      facetType: facetType ?? this.facetType,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class FilterValueViewModelCollection {
  final int? maxItemsToShow;
  final List<FilterValueViewModel> values;
  final String title;

  FilterValueViewModelCollection({
    this.maxItemsToShow,
    required this.values,
    required this.title,
  });

  FilterValueViewModelCollection copyWith({
    int? maxItemsToShow,
    List<FilterValueViewModel>? values,
    String? title,
  }) {
    return FilterValueViewModelCollection(
      maxItemsToShow: maxItemsToShow ?? this.maxItemsToShow,
      values: values ?? this.values,
      title: title ?? this.title,
    );
  }

  bool get anyFiltersSelected {
    return values.any((element) => element.isSelected == true);
  }
}

enum FacetType {
  previouslyPurchased,
  stockedItemsFacet,
  attributeValueFacet,
  brandFacet,
  productLineFacet,
  categoryFacet
}

void showFilterModalSheet(
  BuildContext context, {
  required void Function() onApply,
  required void Function()? onReset,
  required Widget child,
  ValueNotifier<bool>? isApplyEnabledNotifier,
}) {
  showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (innerContext) {
      return ValueListenableBuilder<bool>(
        valueListenable: isApplyEnabledNotifier ?? ValueNotifier(true),
        builder: (context, isApplyEnabled, _) {
          return SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: OptiAppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                LocalizationConstants.filter.localized(),
                                style: OptiTextStyles.titleLarge,
                              ),
                            ),
                            child,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: OptiAppColors.backgroundWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 5,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 13.5,
                      horizontal: 31.5,
                    ),
                    child: Row(
                      children: [
                        if (onReset != null)
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: SecondaryButton(
                                onPressed: onReset,
                                text: LocalizationConstants.reset.localized(),
                              ),
                            ),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            width: 176,
                            height: 48,
                            child: PrimaryButton(
                              text: LocalizationConstants.apply.localized(),
                              isEnabled: isApplyEnabled,
                              onPressed: () {
                                onApply();
                                Navigator.pop(innerContext);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class FilterOptionsChip extends StatelessWidget {
  const FilterOptionsChip({
    super.key,
    required this.label,
    required this.values,
    required this.selectedValueIds,
    required this.onSelectionIdAdded,
    required this.onSelectionIdRemoved,
  });

  final String label;
  final List<FilterValueViewModel> values;
  final Set<String> selectedValueIds;
  final void Function(String selectionId) onSelectionIdAdded;
  final void Function(String selectionId) onSelectionIdRemoved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            label,
            style: OptiTextStyles.body.copyWith(
              color: OptiAppColors.textSecondary,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 2,
          children: values
              .map(
                (value) => FilterChip(
                  label: Text(
                    value.title,
                    style: selectedValueIds.contains(value.id)
                        ? OptiTextStyles.bodySmallHighlight
                            .copyWith(color: OptiAppColors.backgroundWhite)
                        : OptiTextStyles.bodySmallHighlight,
                  ),
                  selectedColor: OptiAppColors.textPrimary,
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  selected: selectedValueIds.contains(value.id),
                  onSelected: (bool selected) {
                    if (selected) {
                      onSelectionIdAdded(value.id);
                    } else {
                      onSelectionIdRemoved(value.id);
                    }
                  },
                  backgroundColor: OptiAppColors.backgroundWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(
                      color: OptiAppColors.textPrimary,
                      width: 1,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class FilterOptionSwitch extends StatelessWidget {
  const FilterOptionSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: OptiTextStyles.body,
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class FilterShipToPickerWidget extends StatelessWidget {
  final ShipTo? shipTo;
  final BillTo? billTo;
  final void Function(ShipTo?) onShipToSelected;

  const FilterShipToPickerWidget({
    super.key,
    required this.shipTo,
    required this.billTo,
    required this.onShipToSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await context.pushNamed(
          AppRoute.billToShipToSelection.name,
          extra: BillToShipToAddressSelectionEntity(
            addressType: AddressType.shipTo,
            selectedShipTo: shipTo,
            selectedBillTo: billTo,
          ),
        );

        if (result != null && result is ShipTo && context.mounted) {
          onShipToSelected(result);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          shipTo == null
              ? Text(
                  LocalizationConstants.selectShipToAddress.localized(),
                  style: OptiTextStyles.body,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shipTo?.companyName ?? '',
                      style: OptiTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      shipTo?.address1 ?? '',
                      style: OptiTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${shipTo?.city ?? ''}, ${shipTo?.state?.abbreviation ?? ''} ${shipTo?.postalCode ?? ''}',
                      style: OptiTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class FilterDatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final String title;
  final void Function(BuildContext context, DateTime) onSelectDate;

  const FilterDatePickerWidget({
    required this.selectedDate,
    required this.onSelectDate,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: OptiTextStyles.body,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: DatePickerWidget(
                  key: UniqueKey(),
                  minDate: DateTime(1970),
                  maxDate: null,
                  selectedDateTime: selectedDate,
                  callback: onSelectDate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FilterListPicker extends StatelessWidget {
  final String label;
  final List<Object> items;
  final int selectedIndex;
  final void Function(BuildContext, Object) callback;

  const FilterListPicker({
    super.key,
    required this.label,
    required this.items,
    required this.selectedIndex,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OptiAppColors.backgroundInput,
        borderRadius: BorderRadius.circular(AppStyle.borderRadius),
      ),
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: OptiAppColors.backgroundInput,
              borderRadius: BorderRadius.circular(AppStyle.borderRadius),
            ),
            height: 50,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ListPicker(
                          key: UniqueKey(),
                          selectedIndex: selectedIndex,
                          items: items,
                          callback: callback,
                          isActionEnabled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterBillToPickerWidget extends StatelessWidget {
  final BillTo? billTo;
  final void Function(BillTo?) onBillToSelected;

  const FilterBillToPickerWidget({
    super.key,
    required this.billTo,
    required this.onBillToSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await context.pushNamed(
          AppRoute.billToShipToSelection.name,
          extra: BillToShipToAddressSelectionEntity(
            addressType: AddressType.billTo,
            selectedBillTo: billTo,
          ),
        );

        if (result != null && result is BillTo && context.mounted) {
          onBillToSelected(result);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          billTo == null
              ? Text(
                  LocalizationConstants.selectCustomer.localized(),
                  style: OptiTextStyles.body,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      billTo?.companyName ?? '',
                      style: OptiTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      billTo?.address1 ?? '',
                      style: OptiTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${billTo?.city ?? ''}, ${billTo?.state?.abbreviation ?? ''} ${billTo?.postalCode ?? ''}',
                      style: OptiTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class FilterItemPickerWidget extends StatelessWidget {
  final Object? item;
  final String? selectedLabel;
  final String defaultLabel;
  final void Function(Object?) onItemSelected;
  final Future<Object?> Function() onTap;

  const FilterItemPickerWidget({
    super.key,
    required this.item,
    required this.onItemSelected,
    required this.selectedLabel,
    required this.defaultLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await onTap();
        if (result != null && context.mounted) {
          onItemSelected(result);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          item == null
              ? Text(
                  defaultLabel,
                  style: OptiTextStyles.body,
                )
              : Text(
                  selectedLabel ?? '',
                  style: OptiTextStyles.titleSmall,
                ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }
}
