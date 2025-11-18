import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_confirmation/quote_confirmation_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_confirmation/quote_confirmation_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quote/quote_information_widget.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/quote/quote_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteConfirmationScreen extends StatelessWidget {
  final QuoteDto quote;

  const QuoteConfirmationScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<QuoteConfirmationCubit>()..loadQuoteConfirmation(quote),
      child: QuoteConfirmationPage(quote: quote),
    );
  }
}

class QuoteConfirmationPage extends StatelessWidget {
  final QuoteDto quote;

  const QuoteConfirmationPage({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.quoteConfirmation.localized()),
      ),
      body: SafeArea(
        child: BlocBuilder<QuoteConfirmationCubit, QuoteConfirmationState>(
            builder: (_, state) {
          if (state is QuoteConfirmationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuoteConfirmationLoadedState) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleWidget("${quote.quoteNumber} Requested"),
                    QuoteInformationWidget(
                      quoteDto: state.quoteDto,
                    ),
                    _buildQuoteLinesWidget(context, state.quoteLineEntities),
                    _buildButtonsWidget(context),
                  ]),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  Widget _buildTitleWidget(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 0, 5),
      child: Text(
        title,
        style: OptiTextStyles.titleLarge,
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
                  showViewBreakPricing: false,
                  hideInventoryEnable:
                      quoteLineEntity.hideInventoryEnable ?? false,
                  hidePricingEnable: quoteLineEntity.hidePricingEnable ?? false,
                  quoteLineEntity: quoteLineEntity,
                  showRemoveButton: false,
                  canEditQuantity: false,
                  onCartLineRemovedCallback: (cartLineEntity) {},
                  onCartQuantityChangedCallback: (quantity) {}))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildButtonsWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TertiaryBlackButton(
            text: LocalizationConstants.viewMyQuotes.localized(),
            onPressed: () {
              AppRoute.myQuote.navigate(context);
            },
          ),
          const SizedBox(width: 16),
          TertiaryBlackButton(
            text: LocalizationConstants.continueShopping.localized(),
            onPressed: () {
              AppRoute.shop.navigate(context);
            },
          ),
        ],
      ),
    );
  }
}
