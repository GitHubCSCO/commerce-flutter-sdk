import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/date_time_extension.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_information_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/quote/quote_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteDetailsScreen extends StatelessWidget {
  final QuoteDto? quoteDto;

  const QuoteDetailsScreen({super.key, this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteDetailsBloc>()..add(QuoteDetailsInitEvent()),
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
        centerTitle: false,
        title:
            Text(context.watch<QuoteDetailsBloc>().quoteDto?.orderNumber ?? ''),
        actions: [
          BottomMenuWidget(
            websitePath: WebsitePaths.myQuoteDetailsWebsitePath
                .format([context.watch<QuoteDetailsBloc>().quoteDto?.id ?? '']),
          ),
        ],
      ),
      body: BlocConsumer<QuoteDetailsBloc, QuoteDetailsState>(
          buildWhen: (previous, current) {
        if (current is QuoteDetailsLoadedState ||
            current is QuoteDetailsLoadingState) {
          return true;
        }
        return false;
      }, listener: (_, state) {
        if (state is QuoteDetailsInitializationSuccessState) {
          context
              .read<QuoteDetailsBloc>()
              .add(LoadQuoteDetailsDataEvent(quoteId: quoteDto?.id ?? ""));
        } else if (state is QuoteAcceptMessageShowState) {
          displayDialogForAccpetQuote(context);
        } else if (state is QuoteAcceptMessageBypassState) {
          context.read<QuoteDetailsBloc>().add(ProceedToCheckoutEvent());
        } else if (state is QuoteAcceptedCheckoutState) {
          AppRoute.checkout.navigateBackStack(context, extra: state.cart);
        } else if (state is ExpirationDateRequiredState) {
          _displayDialogForExpirationDateRequired(context, state.message);
        } else if (state is PastExpirationDateState) {
          _displayDialogPastExpirationDate(context, state.message);
        } else if (state is QuoteSubmissionSuccessState) {
          CustomSnackBar.showSuccesss(context);
          context.read<RootBloc>().add(RootCartUpdateEvent());
          Navigator.of(context).pop();
        } else if (state is QuoteSubmissionFailedState) {
          CustomSnackBar.showFailure(context);
          context.read<RootBloc>().add(RootCartUpdateEvent());
          Navigator.of(context).pop();
        } else if (state is QuoteDeletionSuccessState) {
          CustomSnackBar.showSuccesss(context);
          context.read<RootBloc>().add(RootCartUpdateEvent());
          Navigator.of(context).pop();
        } else if (state is QuoteDeletionFailedState) {
          CustomSnackBar.showFailure(context);
        } else if (state is QuoteDeclineSuccessState) {
          CustomSnackBar.showSuccesss(context);
          context.read<RootBloc>().add(RootCartUpdateEvent());
          Navigator.of(context).pop();
        } else if (state is QuoteDeclineFailedState) {
          CustomSnackBar.showFailure(context);
        } else if (state is QuotelineNoetUpdateSuccessState) {
          CustomSnackBar.showSuccesss(context);
          context.read<QuoteDetailsBloc>().add(QuoteDetailsInitEvent());
        } else if (state is QuotelineNoetUpdateFailureState) {
          CustomSnackBar.showFailure(context);
          context.read<QuoteDetailsBloc>().add(QuoteDetailsInitEvent());
        }
      }, builder: (_, state) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                          visible: context
                              .read<QuoteDetailsBloc>()
                              .shouldShowExpirationDate,
                          child:
                              _buildQuoteExpirationWidget(context, quoteDto)),
                      _buildQuoteMessageWidget(context, state.quoteDto),
                      QuoteInformationWidget(quoteDto: state.quoteDto),
                      _buildQuoteLinesWidget(context, state.quoteLines),
                      _buildButtonsWidget(context, state.quoteDto)
                    ],
                  ),
                ),
              ),
              BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
                  builder: (_, state) {
                if (state is SubmitButtonLoadingState) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Visibility(
                      visible: context
                          .read<QuoteDetailsBloc>()
                          .canBeSubmittedOrDeleted,
                      child: PrimaryButton(
                        onPressed: () {
                          if (context
                              .read<QuoteDetailsBloc>()
                              .isQuoteProposed) {
                            context
                                .read<QuoteDetailsBloc>()
                                .add(AcceptQuoteEvent());
                          } else if (context
                              .read<QuoteDetailsBloc>()
                              .isSalesPerson) {
                            QuoteDto? quoteDto =
                                context.read<QuoteDetailsBloc>().quoteDto;
                            if (quoteDto != null) {
                              context
                                  .read<QuoteDetailsBloc>()
                                  .add(SubmitQuoteEvent(quoteDto: quoteDto));
                            }
                          }
                        },
                        text: context.read<QuoteDetailsBloc>().getSubmitTitle,
                      ),
                    ),
                  );
                }
              })
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildQuoteExpirationWidget(BuildContext context, QuoteDto? quoteDto) {
    var quoteExpireDays = context.read<QuoteDetailsBloc>().quoteExpireDays;
    final duration = Duration(days: quoteExpireDays);
    DateTime? maximumDate = DateTime.now().add(duration);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  LocalizationConstants.quoteExpiration.localized(),
                  textAlign: TextAlign.start,
                  style: OptiTextStyles.subtitle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                        child: DatePickerWidget(
                            maxDate: maximumDate,
                            selectedDateTime: quoteDto?.expirationDate,
                            callback: _onSelectDate)),
                  ],
                ),
              ),
            ],
          ),
          BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
            builder: (_, state) {
              if (state is ExpirationDateRequiredState) {
                return Text(
                  state.message,
                  style: OptiTextStyles.body.copyWith(color: Colors.red),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void _onSelectDate(BuildContext context, DateTime dateTime) {
    context.read<QuoteDetailsBloc>().add(ExpirationDateSelectEvent(
          expirationDate: dateTime,
        ));
  }

  void _displayDialogPastExpirationDate(BuildContext context, String msg) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.error.localized(),
      message: msg,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.oK.localized()),
        ),
      ],
    );
  }

  void _displayDialogForExpirationDateRequired(
      BuildContext context, String msg) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.error.localized(),
      message: msg,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.oK.localized()),
        ),
      ],
    );
  }

  void displayDialogForAccpetQuote(BuildContext context) {
    displayDialogWidget(
      context: context,
      message: LocalizationConstants.acceptQuoteMessage.localized(),
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<QuoteDetailsBloc>().add(ProceedToCheckoutEvent());
          },
          child: Text(LocalizationConstants.continueText.localized()),
        ),
      ],
    );
  }

  void displayDialogForDeleteQuote(BuildContext context) {
    displayDialogWidget(
      context: context,
      title: LocalizationConstants.deleteQuote.localized(),
      message: context.read<QuoteDetailsBloc>().deleteQuoteConfirmation,
      actions: [
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(LocalizationConstants.cancel.localized()),
        ),
        DialogPlainButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<QuoteDetailsBloc>().add(DeleteQuoteEvent(
                quoteId: context.read<QuoteDetailsBloc>().quoteDto?.id ?? ""));
          },
          child: Text(LocalizationConstants.continueText.localized()),
        ),
      ],
    );
  }

  Widget _buildButtonsWidget(BuildContext context, QuoteDto? quoteDto) {
    var acceptedTitle = context.read<QuoteDetailsBloc>().acceptedTitle;
    var declineTitle = context.read<QuoteDetailsBloc>().declineTile;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: context.read<QuoteDetailsBloc>().canBeAccepted,
            child: TertiaryBlackButton(
              text: acceptedTitle,
              onPressed: () {
                if ((context.read<QuoteDetailsBloc>().isQuoteRequested ||
                        context.read<QuoteDetailsBloc>().isQuoteCreated) &&
                    context.read<QuoteDetailsBloc>().isSalesPerson) {
                  AppRoute.quoteAll.navigateBackStack(context,
                      extra: context.read<QuoteDetailsBloc>().quoteDto);
                }
              },
            ),
          ),
          const SizedBox(width: 16),
          Visibility(
            visible: context.read<QuoteDetailsBloc>().canBeDeclined,
            child: TertiaryBlackButton(
              text: declineTitle,
              onPressed: () {
                if (context.read<QuoteDetailsBloc>().isQuoteProposed) {
                  context.read<QuoteDetailsBloc>().add(DeclineQuoteEvent());
                } else {
                  displayDialogForDeleteQuote(context);
                }
              },
            ),
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
                  canEditQuantity:
                      context.watch<QuoteDetailsBloc>().canEditQuantity,
                  showQuantityAndSubtotalField: context
                      .watch<QuoteDetailsBloc>()
                      .showQuoteQuantityAndSubtotal,
                  hideInventoryEnable:
                      quoteLineEntity.hideInventoryEnable ?? false,
                  hidePricingEnable: quoteLineEntity.hidePricingEnable ?? false,
                  quoteLineEntity: quoteLineEntity,
                  showViewBreakPricing:
                      context.watch<QuoteDetailsBloc>().showViewQuotedPricing,
                  viewQuotedPricingTitle: context
                      .read<QuoteDetailsBloc>()
                      .viewQuotedPricingTitle(quoteLineEntity),
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
    list.add(
      ToolMenu(
        title: LocalizationConstants.lineNotes.localized(),
        action: () async {
          var initialText = ''; // TODO - SET INITIAL TEXT
          final lineNotesText = await context.pushNamed(
            AppRoute.quoteLineNotes.name,
            extra: initialText as String?,
          );

          context.read<QuoteDetailsBloc>().add(QuoteLineNoteUpdateEvent(
              note: lineNotesText as String, quoteLineEntity: quoteLineEntity));
        },
      ),
    );
    if (context.watch<QuoteDetailsBloc>().showQuoteOption) {
      list.add(ToolMenu(
          title: LocalizationConstants.quote.localized(),
          action: () {
            gotoQuotePricing(context, quoteLineEntity);
          }));
    }

    return list;
  }

  void gotoQuotePricing(
      BuildContext context, QuoteLineEntity quoteLineEntity) async {
    final bloc = context.read<QuoteDetailsBloc>();

    final result = await context.pushNamed<QuoteDto>(AppRoute.quotePricing.name,
        extra: quoteLineEntity);

    if (context.mounted) {
      if (result != null) {
        bloc.add(QuoteDetailsInitEvent());
      }
    }
  }

  Widget _buildQuoteMessageWidget(BuildContext context, QuoteDto? quoteDto) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
          onTap: () {
            AppRoute.quoteCommunication
                .navigateBackStack(context, extra: quoteDto);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                LocalizationConstants.message.localized(),
                style: OptiTextStyles.bodyFade,
              ),
              const SizedBox(height: 10.0),
              if (quoteDto != null &&
                  quoteDto.messageCollection != null &&
                  quoteDto.messageCollection!.isNotEmpty &&
                  quoteDto.messageCollection?.last != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            quoteDto.messageCollection?.last.displayName ?? ""),
                        Row(
                          children: [
                            Text(quoteDto.messageCollection?.last.createdDate
                                    .formatDate(
                                        format: CoreConstants
                                            .dateFormatFullString) ??
                                ""),
                            const SizedBox(width: 10.0),
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
                    const SizedBox(height: 10.0),
                    Text(quoteDto.messageCollection?.last.body ?? ""),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalizationConstants.noMessageItem.localized()),
                    const SizedBox(width: 10.0),
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
          )),
    );
  }
}
