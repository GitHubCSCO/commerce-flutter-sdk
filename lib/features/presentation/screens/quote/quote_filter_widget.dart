import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/filter.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/quote_filter/quote_filter_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/selection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;

class QuoteFilterWidget extends StatelessWidget {
  final QuoteQueryParameters quoteQueryParameters;
  final bool hasFilter;
  final void Function(
    QuoteQueryParameters quoteQueryParameter,
  ) onApply;

  const QuoteFilterWidget({
    super.key,
    required this.quoteQueryParameters,
    required this.hasFilter,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteFilterCubit>(),
      child: Builder(
        builder: (context) {
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
                context.read<QuoteFilterCubit>().initialize(
                      quoteQueryParameters: quoteQueryParameters,
                    );

                _showQuoteFilter(
                  context,
                  onReset: () {
                    context.read<QuoteFilterCubit>().reset();
                  },
                  onApply: () {
                    final currentState = context.read<QuoteFilterCubit>().state;

                    bool shouldShowRequestedDateError = currentState.fromDate !=
                            null &&
                        currentState.toDate != null &&
                        currentState.fromDate!.isAfter(currentState.toDate!);

                    bool shouldShowExpireDateError =
                        currentState.expireFromDate != null &&
                            currentState.expireToDate != null &&
                            currentState.expireFromDate!
                                .isAfter(currentState.expireToDate!);

                    if (shouldShowRequestedDateError) {
                      displayDialogWidget(
                        context: context,
                        title: LocalizationConstants.error.localized(),
                        message: LocalizationConstants
                            .fromDateShouldBeLessThanOrEqualToDate
                            .localized(),
                        actions: [
                          PlainBlackButton(
                            onPressed: () {
                              context.pop();
                            },
                            text: LocalizationConstants.oK.localized(),
                          ),
                        ],
                      );
                      return;
                    }

                    if (shouldShowExpireDateError) {
                      displayDialogWidget(
                        context: context,
                        title: LocalizationConstants.error.localized(),
                        message: LocalizationConstants
                            .fromDateShouldBeLessThanOrEqualToDate
                            .localized(),
                        actions: [
                          PlainBlackButton(
                            onPressed: () {
                              context.pop();
                            },
                            text: LocalizationConstants.oK.localized(),
                          ),
                        ],
                      );
                      return;
                    }

                    onApply(
                      QuoteQueryParameters(
                        billTo: currentState.billTo,
                        customerId: currentState.customerId,
                        expand: quoteQueryParameters.expand,
                        fromDate: currentState.fromDate,
                        toDate: currentState.toDate,
                        expireFromDate: currentState.expireFromDate,
                        expireToDate: currentState.expireToDate,
                        quoteNumber: currentState.quoteNumber,
                        page: quoteQueryParameters.page,
                        pageSize: quoteQueryParameters.pageSize ??
                            CoreConstants.defaultPageSize,
                        salesRepNumber: currentState.salesRepNumber,
                        selectedSalesRep: currentState.salesRep,
                        selectedUser: currentState.user,
                        statuses: currentState.statuses,
                        types: currentState.types,
                        sort: quoteQueryParameters.sort,
                        userId: currentState.userId,
                      ),
                    );
                  },
                );
              },
              icon: SvgPicture.asset(
                height: 20,
                width: 20,
                AssetConstants.filterIcon,
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

void _showQuoteFilter(
  BuildContext context, {
  required void Function() onReset,
  required void Function() onApply,
}) {
  showFilterModalSheet(
    context,
    onReset: onReset,
    onApply: onApply,
    child: BlocProvider.value(
      value: BlocProvider.of<QuoteFilterCubit>(context),
      child: BlocBuilder<QuoteFilterCubit, QuoteFilterState>(
        builder: (context, state) {
          if (state.quoteFilterStatus == QuoteFilterStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FilterTextFieldWidget(
                existingValue: state.quoteNumber,
                onChanged: context.read<QuoteFilterCubit>().setQuoteNumber,
                hintText: LocalizationConstants.quoteSign.localized(),
                onListen: (context, state, textController) {
                  if (state.quoteNumber != textController.text) {
                    textController.text = state.quoteNumber ?? '';
                    textController.selection = TextSelection.fromPosition(
                      TextPosition(offset: textController.text.length),
                    );
                  }
                },
              ),
              const SizedBox(height: 15),
              FilterListPicker(
                label: LocalizationConstants.status.localized(),
                items: context.watch<QuoteFilterCubit>().statusList,
                selectedIndex: state.statusIndex,
                callback: (context, item) {
                  context.read<QuoteFilterCubit>().setStatuses(
                        item as String,
                      );
                },
              ),
              const SizedBox(height: 15),
              FilterListPicker(
                label: LocalizationConstants.quoteType.localized(),
                items: context.watch<QuoteFilterCubit>().typeList,
                selectedIndex: state.typeIndex,
                callback: (context, item) {
                  context.read<QuoteFilterCubit>().setTypes(
                        item as String,
                      );
                },
              ),
              const SizedBox(height: 45),
              Text(
                LocalizationConstants.customer.localized().toUpperCase(),
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 15),
              FilterBillToPickerWidget(
                billTo: state.billTo,
                onBillToSelected: context.read<QuoteFilterCubit>().setBillTo,
              ),
              const SizedBox(height: 45),
              if (state.isSalesPerson) ...[
                Text(
                  LocalizationConstants.user.localized().toUpperCase(),
                  style: OptiTextStyles.subtitle,
                ),
                const SizedBox(height: 15),
                FilterItemPickerWidget(
                  item: state.user,
                  onItemSelected: (user) {
                    context
                        .read<QuoteFilterCubit>()
                        .setUser(user as CatalogTypeDto);
                  },
                  selectedLabel: state.user?.title ?? '',
                  defaultLabel: LocalizationConstants.selectUser.localized(),
                  onTap: () async {
                    return await context.pushNamed(
                      AppRoute.userSelection.name,
                      extra: CatalogTypeSelectingParameter(
                        currentItem: state.user,
                        removeMyself: false,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 45),
                Text(
                  LocalizationConstants.salesRep.localized().toUpperCase(),
                  style: OptiTextStyles.subtitle,
                ),
                const SizedBox(height: 15),
                FilterItemPickerWidget(
                  item: state.salesRep,
                  onItemSelected: (salesRep) {
                    context
                        .read<QuoteFilterCubit>()
                        .setSalesRep(salesRep as CatalogTypeDto);
                  },
                  selectedLabel: state.salesRep?.title ?? '',
                  defaultLabel:
                      LocalizationConstants.selectSalesRep.localized(),
                  onTap: () async {
                    return await context.pushNamed(
                      AppRoute.salesRepSelection.name,
                      extra: CatalogTypeSelectingParameter(
                        currentItem: state.salesRep,
                        removeMyself: false,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 45),
              ],
              Text(
                LocalizationConstants.requestedDateRange
                    .localized()
                    .toUpperCase(),
                style: OptiTextStyles.subtitle,
              ),
              FilterDatePickerWidget(
                title: LocalizationConstants.requestedFrom.localized(),
                selectedDate: state.fromDate,
                onSelectDate: (innerContext, date) {
                  context.read<QuoteFilterCubit>().setFromDate(date);
                },
              ),
              const SizedBox(height: 15),
              FilterDatePickerWidget(
                title: LocalizationConstants.requestedTo.localized(),
                selectedDate: state.toDate,
                onSelectDate: (innerContext, date) {
                  context.read<QuoteFilterCubit>().setToDate(date);
                },
              ),
              const SizedBox(height: 45),
              Text(
                LocalizationConstants.expiresDateRange
                    .localized()
                    .toUpperCase(),
                style: OptiTextStyles.subtitle,
              ),
              FilterDatePickerWidget(
                title: LocalizationConstants.expireFrom.localized(),
                selectedDate: state.expireFromDate,
                onSelectDate: (innerContext, date) {
                  context.read<QuoteFilterCubit>().setExpireFromDate(date);
                },
              ),
              const SizedBox(height: 15),
              FilterDatePickerWidget(
                title: LocalizationConstants.expireTo.localized(),
                selectedDate: state.expireToDate,
                onSelectDate: (innerContext, date) {
                  context.read<QuoteFilterCubit>().setExpireToDate(date);
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}

class _FilterTextFieldWidget extends StatefulWidget {
  const _FilterTextFieldWidget({
    required this.existingValue,
    required this.onChanged,
    required this.hintText,
    required this.onListen,
  });

  final String? existingValue;
  final String hintText;
  final void Function(String) onChanged;
  final void Function(BuildContext, QuoteFilterState, TextEditingController)
      onListen;

  @override
  State<_FilterTextFieldWidget> createState() => _FilterTextFieldWidgetState();
}

class _FilterTextFieldWidgetState extends State<_FilterTextFieldWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.existingValue != null
        ? textController.text = widget.existingValue!
        : null;
    textController.addListener(submit);
  }

  @override
  void dispose() {
    textController.removeListener(submit);
    textController.dispose();
    super.dispose();
  }

  void submit() {
    widget.onChanged(textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteFilterCubit, QuoteFilterState>(
      listener: (context, state) {
        widget.onListen(context, state, textController);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            controller: textController,
            hintText: widget.hintText,
          ),
        ],
      ),
    );
  }
}
