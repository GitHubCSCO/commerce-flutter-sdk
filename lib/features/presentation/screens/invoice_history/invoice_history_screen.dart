import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/invoice_sort_order.dart';
import 'package:commerce_flutter_app/features/domain/enums/invoice_status.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/invoice_history/invoice_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/invoice_history_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceHistoryCubit>()..loadInvoiceHistory(),
      child: const InvoiceHistoryPage(),
    );
  }
}

class InvoiceHistoryPage extends StatelessWidget {
  const InvoiceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.invoiceHistory),
        centerTitle: false,
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.invoiceHistoryWebsitePath,
          )
        ],
      ),
      body: BlocBuilder<InvoiceHistoryCubit, InvoiceHistoryState>(
        builder: (context, state) {
          switch (state.status) {
            case InvoiceStatus.loading || InvoiceStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case InvoiceStatus.failure:
              return Center(
                child: Text(
                  SiteMessageConstants.defaultMobileAppAlertCommunicationError,
                ),
              );
            default:
              final invoiceList = state.invoiceCollectionModel.invoices ?? [];
              return Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.invoiceCollectionModel.pagination
                                      ?.totalItemCount !=
                                  null
                              ? '${state.invoiceCollectionModel.pagination?.totalItemCount} ${LocalizationConstants.invoices}'
                              : '',
                          style: OptiTextStyles.header3,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SortToolMenu(
                              availableSortOrders: InvoiceSortOrder.values,
                              onSortOrderChanged:
                                  (SortOrderAttribute sortOrder) async {
                                await context
                                    .read<InvoiceHistoryCubit>()
                                    .changeSortOrder(
                                      sortOrder as InvoiceSortOrder,
                                    );
                              },
                              selectedSortOrder: state.invoiceSortOrder,
                            ),
                            const SizedBox(width: 10),
                            InvoiceHistoryFilterWidget(
                              invoiceQueryParameters:
                                  state.invoiceQueryParameters,
                              hasFilter:
                                  context.read<InvoiceHistoryCubit>().hasFilter,
                              onApply: ({
                                showOpenOnly,
                                invoiceNumber,
                                poNumber,
                                orderNumber,
                                shipTo,
                                fromDate,
                                toDate,
                                customerSequence,
                              }) {
                                context.read<InvoiceHistoryCubit>().applyFilter(
                                      showOpenOnly: showOpenOnly,
                                      invoiceNumber: invoiceNumber,
                                      poNumber: poNumber,
                                      orderNumber: orderNumber,
                                      shipTo: shipTo,
                                      fromDate: fromDate,
                                      toDate: toDate,
                                      customerSequence: customerSequence,
                                    );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  invoiceList.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Text(
                              SiteMessageConstants
                                  .defaultInvoiceNoResultsMessage,
                            ),
                          ),
                        )
                      : Expanded(
                          child: _InvoiceHistoryListWidget(
                            invoices: invoiceList,
                          ),
                        ),
                ],
              );
          }
        },
      ),
    );
  }
}

class _InvoiceHistoryListWidget extends StatefulWidget {
  final List<Invoice> invoices;

  const _InvoiceHistoryListWidget({
    required this.invoices,
  });

  @override
  State<_InvoiceHistoryListWidget> createState() =>
      __InvoiceHistoryListWidgetState();
}

class __InvoiceHistoryListWidgetState extends State<_InvoiceHistoryListWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<InvoiceHistoryCubit>().loadMoreInvoiceHistory();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceHistoryCubit, InvoiceHistoryState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index >= (state.invoiceCollectionModel.invoices?.length ?? 0) &&
                state.status == InvoiceStatus.moreLoading) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return _InvoiceItem(
              invoice: widget.invoices[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            thickness: 1,
          ),
          itemCount: state.status == InvoiceStatus.moreLoading
              ? widget.invoices.length + 1
              : widget.invoices.length,
        );
      },
    );
  }
}

class _InvoiceItem extends StatelessWidget {
  final Invoice invoice;

  const _InvoiceItem({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final invoiceDate = invoice.invoiceDate != null
        ? DateFormat(CoreConstants.dateFormatString)
            .format(invoice.invoiceDate!)
        : '';
    final invoiceNumber = invoice.invoiceNumber ?? '';
    final poNumber =
        '${LocalizationConstants.pONumberSign} ${invoice.customerPO ?? ''}';
    final invoiceTotal =
        '${LocalizationConstants.total} ${invoice.invoiceTotalDisplay ?? ''}';
    final dueDate =
        '${LocalizationConstants.due} ${invoice.dueDate != null ? DateFormat(CoreConstants.dateFormatString).format(invoice.dueDate!) : ''}';
    final stCompany = invoice.stCompanyName ?? '';
    final balance = invoice.currentBalanceDisplay ?? '';
    const balanceTitle = LocalizationConstants.balance;

    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        color: OptiAppColors.backgroundWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(invoiceDate, style: OptiTextStyles.bodySmall),
                  Text(invoiceNumber, style: OptiTextStyles.titleSmall),
                  Text(stCompany, style: OptiTextStyles.body),
                  Text(poNumber, style: OptiTextStyles.body),
                  Text(invoiceTotal, style: OptiTextStyles.body),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(balanceTitle, style: OptiTextStyles.bodySmall),
                Text(balance, style: OptiTextStyles.titleLarge),
                Text(dueDate, style: OptiTextStyles.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
