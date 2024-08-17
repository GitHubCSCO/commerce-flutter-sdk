import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_communication/quote_communication_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_pricing/quote_pricing_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_pricing/quote_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_pricing/quote_pricing_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class QuotePricingScreen extends StatelessWidget {
  final QuoteLineEntity? quoteLineEntity;
  const QuotePricingScreen({super.key, required this.quoteLineEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuotePricingBloc>()
        ..add(LoadQuotePricingEvent(quoteLineEntity: quoteLineEntity!)),
      child: QuotePricingPage(),
    );
  }
}

class QuotePricingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocalizationConstants.quote.localized()),
          actions: [
            InkWell(
              onTap: () {
                context
                    .read<QuotePricingBloc>()
                    .add(ApplyQuoteLinePricingEvent());
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  LocalizationConstants.apply.localized(),
                  style: OptiTextStyles.linkMedium,
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<QuotePricingBloc, QuotePricingState>(
            buildWhen: (previous, current) {
          if (current is QuotePricingLoadingState ||
              current is QuotePricingLoadedState) {
            return true;
          }
          return false;
        }, listener: (context, state) {
          if (state is QuotePriceBreakValidationState) {
            if (state.isValid == false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          } else if (state is QuoteLinePricingApplySuccessState) {
            context.pop(state.quoteDto);
          } else if (state is QuoteLinePricingApplyFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(LocalizationConstants.failed.localized()),
            ));
          }
        }, builder: (context, state) {
          if (state is QuotePricingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuotePricingLoadedState) {
            return Container(
              color: Colors.white,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                QuoteLineWidget(
                    hidePricingEnable:
                        state.quoteLineEntity.hidePricingEnable ?? false,
                    hideInventoryEnable:
                        state.quoteLineEntity.hideInventoryEnable ?? false,
                    quoteLineEntity: state.quoteLineEntity,
                    showRemoveButton: false,
                    showViewBreakPricing: false,
                    showQuantityAndSubtotalField: false,
                    moreButtonWidget: Container(),
                    hidePricingWidget: true,
                    onCartLineRemovedCallback: (cartLineEntity) {},
                    onCartQuantityChangedCallback: (quantity) {}),
                _buildQuoteItemPirincgWidget(context, state.quoteLineEntity),
                ...state.quoteLinePricingBreakItemEntities.map((item) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 20.0, 20.0, 20.0),
                            child: Text(
                              LocalizationConstants.quantity.localized(),
                              style: OptiTextStyles.body,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 120.0, 20.0),
                            child: Text(
                              LocalizationConstants.price.localized(),
                              style: OptiTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                      PriceBreakwidget(
                        index: item.id,
                        startQtyDisplay: item.startQuantityDisplay!,
                        endQtyDisplay: item.endQuantityDisplay!,
                        priceDisplay: item.priceDisplay!,
                      ),
                    ],
                  );
                }),
                const Spacer(),
                _buildQuoteButtonsWidget(context),
              ]),
            );
          } else {
            return Container();
          }
        }));
  }

  Widget _buildQuoteButtonsWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TertiaryBlackButton(
            isEnabled: context.watch<QuotePricingBloc>().isAddPriceBreakEnabled,
            text: LocalizationConstants.addPriceBreak.localized(),
            onPressed: () {
              context.read<QuotePricingBloc>().add(AddQuotePriceBreakEvent());
            },
          ),
          const SizedBox(width: 16),
          TertiaryBlackButton(
            text: LocalizationConstants.reset.localized(),
            onPressed: () {
              context.read<QuotePricingBloc>().add(ResetQuotePriceBreakEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteItemPirincgWidget(
      BuildContext context, QuoteLineEntity quoteLineEntity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 0.0, 10.0),
          child: Text(
            LocalizationConstants.itemPricing.localized(),
            style: OptiTextStyles.body,
          ),
        ),
        PriceRowWidget(
            label: LocalizationConstants.unitCost.localized(),
            price: quoteLineEntity.pricingRfq?.unitCostDisplay ?? ''),
        PriceRowWidget(
            label: LocalizationConstants.list.localized(),
            price: quoteLineEntity.pricingRfq?.listPriceDisplay ?? ''),
        PriceRowWidget(
            label: LocalizationConstants.customer.localized(),
            price: quoteLineEntity.pricingRfq?.customerPriceDisplay ?? ''),
        PriceRowWidget(
            label: LocalizationConstants.minimum.localized(),
            price:
                quoteLineEntity.pricingRfq?.minimumPriceAllowedDisplay ?? ''),
      ],
    );
  }
}

class PriceBreakwidget extends StatelessWidget {
  final String startQtyDisplay;
  final String endQtyDisplay;
  final String priceDisplay;
  final int index;
  final TextEditingController startQtycontroller = TextEditingController();
  final TextEditingController endQtycontroller = TextEditingController();
  final TextEditingController priceQtycontroller = TextEditingController();

  PriceBreakwidget(
      {super.key,
      required this.index,
      required this.startQtyDisplay,
      required this.endQtyDisplay,
      required this.priceDisplay});

  @override
  Widget build(BuildContext context) {
    startQtycontroller.text = startQtyDisplay;
    endQtycontroller.text = endQtyDisplay;
    priceQtycontroller.text = priceDisplay;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Input(
                controller: startQtycontroller,
                onSubmitted: (p0) {
                  context.read<QuotePricingBloc>().add(
                      QuoteStartQuantityUpdateEvent(
                          startQuantity: p0, id: index));
                },
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.nextFocus();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                LocalizationConstants.to.localized(),
                style: OptiTextStyles.body,
              ),
            ),
            Expanded(
              flex: 1,
              child: Input(
                controller: endQtycontroller,
                onSubmitted: (p0) {
                  context.read<QuotePricingBloc>().add(
                      QuoteEndQuantityUpdateEvent(endQuantity: p0, id: index));
                },
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.nextFocus();
                },
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Input(
                controller: priceQtycontroller,
                onSubmitted: (p0) {
                  context
                      .read<QuotePricingBloc>()
                      .add(QuotePriceUpdateEvent(price: p0, id: index));
                },
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.nextFocus();
                },
              ),
            ),
            if (index != 0)
              InkWell(
                onTap: () {
                  context
                      .read<QuotePricingBloc>()
                      .add(QuotePiricngBreakDeletionEvent(id: index));
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AssetConstants.cartItemRemoveIcon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: SizedBox(width: 30),
              ),
          ],
        ),
      ),
    );
  }
}

class PriceRowWidget extends StatelessWidget {
  final String label;
  final String price;

  const PriceRowWidget({Key? key, required this.label, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: OptiTextStyles.subtitle),
            Text(price, style: OptiTextStyles.body),
          ],
        ),
      ),
    );
  }
}
