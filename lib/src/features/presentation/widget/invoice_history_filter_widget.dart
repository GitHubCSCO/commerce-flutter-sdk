import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/filter.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/invoice_history/invoice_history_filter/invoice_history_filter_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:badges/badges.dart' as badges;

class InvoiceHistoryFilterWidget extends StatelessWidget {
  final InvoiceQueryParameters invoiceQueryParameters;
  final bool hasFilter;
  final void Function({
    bool? showOpenOnly,
    String? invoiceNumber,
    String? poNumber,
    String? orderNumber,
    ShipTo? shipTo,
    DateTime? fromDate,
    DateTime? toDate,
    String? customerSequence,
  }) onApply;

  const InvoiceHistoryFilterWidget({
    super.key,
    required this.invoiceQueryParameters,
    required this.hasFilter,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceHistoryFilterCubit>(),
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
                context.read<InvoiceHistoryFilterCubit>().initialize(
                      invoiceQueryParameters: invoiceQueryParameters,
                    );

                _showInvoiceHistoryFilter(
                  context,
                  onReset: () {
                    context.read<InvoiceHistoryFilterCubit>().reset();
                  },
                  onApply: () {
                    final currentState =
                        context.read<InvoiceHistoryFilterCubit>().state;
                    onApply(
                      showOpenOnly: currentState.showOpenOnly,
                      invoiceNumber: currentState.invoiceNumber,
                      poNumber: currentState.poNumber,
                      orderNumber: currentState.orderNumber,
                      shipTo: currentState.shipTo,
                      fromDate: currentState.fromDate,
                      toDate: currentState.toDate,
                      customerSequence: currentState.customerSequence,
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

void _showInvoiceHistoryFilter(
  BuildContext context, {
  required void Function() onReset,
  required void Function() onApply,
}) {
  showFilterModalSheet(
    context,
    onApply: onApply,
    onReset: onReset,
    child: BlocProvider.value(
      value: BlocProvider.of<InvoiceHistoryFilterCubit>(context),
      child: BlocBuilder<InvoiceHistoryFilterCubit, InvoiceHistoryFilterState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterOptionSwitch(
                label: LocalizationConstants.openInvoicesOnly.localized(),
                value: state.showOpenOnly,
                onChanged: (_) => context
                    .read<InvoiceHistoryFilterCubit>()
                    .toggleShowMyOrders(),
              ),
              const SizedBox(height: 45),
              _FilterTextFieldWidget(
                existingValue: state.invoiceNumber,
                onChanged:
                    context.read<InvoiceHistoryFilterCubit>().setInvoiceNumber,
                hintText: LocalizationConstants.invoiceNumber.localized(),
                onListen: (context, state, textController) {
                  if (state.invoiceNumber != textController.text &&
                      state.invoiceNumber.isNullOrEmpty) {
                    textController.value = const TextEditingValue(text: '');
                  }
                },
              ),
              const SizedBox(height: 20),
              _FilterTextFieldWidget(
                existingValue: state.poNumber,
                onChanged:
                    context.read<InvoiceHistoryFilterCubit>().setPoNumber,
                hintText: LocalizationConstants.pONumber.localized(),
                onListen: (context, state, textController) {
                  if (state.poNumber != textController.text &&
                      state.poNumber.isNullOrEmpty) {
                    textController.value = const TextEditingValue(text: '');
                  }
                },
              ),
              const SizedBox(height: 20),
              _FilterTextFieldWidget(
                existingValue: state.orderNumber,
                onChanged:
                    context.read<InvoiceHistoryFilterCubit>().setOrderNumber,
                hintText: LocalizationConstants.orderNumber.localized(),
                onListen: (context, state, textController) {
                  if (state.orderNumber != textController.text &&
                      state.orderNumber.isNullOrEmpty) {
                    textController.value = const TextEditingValue(text: '');
                  }
                },
              ),
              const SizedBox(height: 45),
              Text(
                LocalizationConstants.shipToAddress.localized().toUpperCase(),
                style: OptiTextStyles.subtitle,
              ),
              const SizedBox(height: 10),
              FilterShipToPickerWidget(
                shipTo: state.shipTo,
                billTo: state.billTo,
                onShipToSelected:
                    context.read<InvoiceHistoryFilterCubit>().setShipTo,
              ),
              const SizedBox(height: 45),
              Text(
                LocalizationConstants.dateRange.localized().toUpperCase(),
                style: OptiTextStyles.subtitle,
              ),
              FilterDatePickerWidget(
                title: LocalizationConstants.from.localized(),
                selectedDate: state.fromDate,
                onSelectDate: (innerContext, date) {
                  context.read<InvoiceHistoryFilterCubit>().setFromDate(date);
                },
              ),
              const SizedBox(height: 10),
              FilterDatePickerWidget(
                title: LocalizationConstants.to.localized(),
                selectedDate: state.toDate,
                onSelectDate: (innerContext, date) {
                  context.read<InvoiceHistoryFilterCubit>().setToDate(date);
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
  final void Function(
      BuildContext, InvoiceHistoryFilterState, TextEditingController) onListen;

  @override
  State<_FilterTextFieldWidget> createState() => _FilterTextFieldWidgetState();
}

class _FilterTextFieldWidgetState extends State<_FilterTextFieldWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.existingValue != null
        ? textController.value = TextEditingValue(text: widget.existingValue!)
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
    return BlocListener<InvoiceHistoryFilterCubit, InvoiceHistoryFilterState>(
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
