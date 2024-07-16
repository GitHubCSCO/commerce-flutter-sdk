import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_information_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteDetailsScreen extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteDetailsScreen({super.key, this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteDetailsBloc>()
        ..add(LoadQuoteDetailsDataEvent(quoteId: quoteDto?.id ?? "")),
      child: QuoteDetailsPage(quoteDto: quoteDto),
    );
  }
}

class QuoteDetailsPage extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteDetailsPage({super.key, this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
      ),
      body: BlocConsumer<QuoteDetailsBloc, QuoteDetailsState>(
          listener: (_, state) {},
          builder: (_, state) {
            if (state is QuoteDetailsFailedState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is QuoteDetailsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteDetailsLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildQuoteMessageWidget(context, state.quoteDto),
                          QuoteInformationWidget(quoteDto: state.quoteDto),
                          _buildQuoteLinesWidget(context, state.quoteLines),
                          _buildButtonsWidget(context, state.quoteDto)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Visibility(
                      visible: true,
                      child: PrimaryButton(
                        onPressed: () {},
                        text: LocalizationConstants.acceptSalesQuote,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget _buildButtonsWidget(BuildContext context, QuoteDto? quoteDto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TertiaryBlackButton(
            child: const Text(
              LocalizationConstants.quoteAll,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          TertiaryBlackButton(
            child: const Text(LocalizationConstants.deleteSalesQuote),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteLinesWidget(
      BuildContext context, List<QuoteLineEntity> quoteLineEntities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Text(
            '${quoteLineEntities.length} ${quoteLineEntities.length == 1 ? "product" : "products"}',
            style: OptiTextStyles.bodyFade,
          ),
        ),
        Column(
          children: quoteLineEntities
              .map((quoteLineEntity) => QuoteLineWidget(
                  quoteLineEntity: quoteLineEntity,
                  showRemoveButton: false,
                  moreButtonWidget:
                      _buildMenuButtonForQuoteLine(context, quoteLineEntity),
                  onCartLineRemovedCallback: (cartLineEntity) {},
                  onCartQuantityChangedCallback: (quantity) {}))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildMenuButtonForQuoteLine(
      BuildContext context, QuoteLineEntity quoteLineEntity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: BottomMenuWidget(
            isViewOnWebsiteEnable: false,
            toolMenuList: _buildToolMenuForQuoteLine(context, quoteLineEntity)),
      ),
    );
  }

  List<ToolMenu> _buildToolMenuForQuoteLine(
      BuildContext context, QuoteLineEntity quoteLineEntity) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(title: LocalizationConstants.lineNotes, action: () {}));
    list.add(ToolMenu(title: LocalizationConstants.delete, action: () {}));
    return list;
  }

  Widget _buildQuoteMessageWidget(BuildContext context, QuoteDto? quoteDto) {
    return Container(
      padding: EdgeInsets.all(20),
      child: InkWell(
          onTap: () {
            AppRoute.quoteCommunication
                .navigateBackStack(context, extra: quoteDto);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.message,
                style: OptiTextStyles.bodyFade,
              ),
              SizedBox(height: 10.0),
              if (quoteDto?.messageCollection?.last != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(quoteDto?.messageCollection?.last.displayName ??
                            ""),
                        Row(
                          children: [
                            Text(quoteDto?.messageCollection?.last.createdDate
                                    .formatDate(
                                        format: CoreConstants
                                            .dateFormatFullString) ??
                                ""),
                            SizedBox(width: 10.0),
                            Container(
                              alignment: Alignment.center,
                              width: 25,
                              height: 25,
                              // padding: const EdgeInsets.all(7),
                              child: const Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey,
                                size: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(quoteDto?.messageCollection?.last.body ?? ""),
                  ],
                )
              else
                Text(LocalizationConstants.noMessageItem)
            ],
          )),
    );
  }
}
