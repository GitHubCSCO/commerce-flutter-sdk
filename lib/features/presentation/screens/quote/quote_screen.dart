import 'dart:ffi';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/quote_page_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_state.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_filter_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_item_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/tab_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteBloc>()
        ..add(QuoteLoadEvent(
            quotePageType: QuotePageType.pending, quoteParameters: null)),
      child: const QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  QuotePageState createState() => QuotePageState();
}

class QuotePageState extends State<QuotePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.quotes.localized()),
        centerTitle: false,
        actions: [
          BottomMenuWidget(
            websitePath:
                context.watch<QuoteBloc>().pageType == QuotePageType.pending
                    ? WebsitePaths.myQuotesWebsitePath
                    : WebsitePaths.jobQuotesWebsitePath,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.watch<QuoteBloc>().title,
                  style: OptiTextStyles.header3,
                ),
                QuoteFilterWidget(
                  quoteQueryParameters: context.watch<QuoteBloc>().parameter,
                  hasFilter: context.watch<QuoteBloc>().hasFilter,
                  onApply: (parameter) {
                    context.read<QuoteBloc>().add(
                          QuoteLoadEvent(
                            quotePageType: selectedIndex == 1
                                ? QuotePageType.activejobs
                                : QuotePageType.pending,
                            quoteParameters: parameter,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: TabSwitchWidget(
              tabTitle0: LocalizationConstants.pending.localized(),
              tabTitle1: LocalizationConstants.activeJobs.localized(),
              tabWidget0:
                  BlocBuilder<QuoteBloc, QuoteState>(builder: (_, state) {
                if (state is QuoteFailed) {
                  return const Center(
                    child: Text("No data found"),
                  );
                } else if (state is QuoteLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is QuoteLoaded) {
                  return _buildPendingQuotesWidget(state.quotes, context);
                } else {
                  return Container();
                }
              }),
              tabWidget1:
                  BlocBuilder<QuoteBloc, QuoteState>(builder: (context, state) {
                if (state is QuoteFailed) {
                  return const Center(
                    child: Text("No data found"),
                  );
                } else if (state is QuoteLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is JobQuoteLoaded) {
                  return _buildActiveJobsWidget(state.jobQuotes, context);
                } else {
                  return Container();
                }
              }),
              selectedIndex: selectedIndex,
              onTabSelectionChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
                final type = index == 1
                    ? QuotePageType.activejobs
                    : QuotePageType.pending;

                context.read<QuoteBloc>().add(
                    QuoteLoadEvent(quotePageType: type, quoteParameters: null));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingQuotesWidget(
      List<QuoteDto>? quotes, BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: quotes?.length ?? 0,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              goToQuoteDetails(context, quotes[index]);
              // AppRoute.quoteDetails
              //     .navigateBackStack(context, extra: quotes[index]);
            },
            child: QuoteItemWidget(
              typeDisplay: quotes![index].typeDisplay ?? '',
              quoteNumber: quotes[index].quoteNumber ?? '',
              companyName: quotes[index].customerName ?? '',
              address: quotes[index].shipToFullAddress ?? '',
              status: quotes[index].status ?? '',
              requestDate:
                  quotes[index].orderDate.formatDate(format: 'MM/dd/yyyy'),
              expiryDate:
                  quotes[index].expirationDate.formatDate(format: 'MM/dd/yyyy'),
            ),
          );
        },
      ),
    );
  }

  void goToQuoteDetails(BuildContext context, QuoteDto quoteDto) async {
    final result = await context.pushNamed<Bool>(
      AppRoute.quoteDetails.name,
      extra: quoteDto,
    );
    if (!context.mounted) {
      return;
    }

    if (result != null) {
      context.read<QuoteBloc>().add(QuoteLoadEvent(
          quotePageType: QuotePageType.pending, quoteParameters: null));
    }
  }

  Widget _buildActiveJobsWidget(
      List<JobQuoteDto>? jobQuotes, BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: jobQuotes?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              AppRoute.jobQuoteDetails.navigateBackStack(
                context,
                pathParameters: {
                  'jobQuoteId': jobQuotes?[index].id ?? '',
                },
              );
            },
            child: QuoteItemWidget(
              typeDisplay: '',
              quoteNumber: jobQuotes?[index].jobName ?? '',
              companyName: jobQuotes?[index].customerName ?? '',
              address: jobQuotes?[index].shipToFullAddress ?? '',
              status: jobQuotes?[index].status ?? '',
              requestDate: jobQuotes?[index].orderDate != null
                  ? jobQuotes![index].orderDate.formatDate(format: 'MM/dd/yyyy')
                  : '',
              expiryDate: jobQuotes?[index].expirationDate != null
                  ? jobQuotes![index]
                      .expirationDate!
                      .formatDate(format: 'MM/dd/yyyy')
                  : '',
            ),
          );
        },
      ),
    );
  }
}
