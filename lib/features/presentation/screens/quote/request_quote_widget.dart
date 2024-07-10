import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/request_quote_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestQuoteWidgetScreen extends StatelessWidget {
  const RequestQuoteWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              sl<RequestQuoteBloc>()..add(LoadRequestQuoteCartLinesEvent())),
      BlocProvider(
          create: (context) => sl<RequestQuoteSelectionBloc>()
            ..add(RequestQuoteSelectionDefaultEvent(
                RequestQuoteType.salesQuote))),
    ], child: RequestQuoteWidgetPage());
  }
}

class RequestQuoteWidgetPage extends StatelessWidget {
  RequestQuoteWidgetPage({super.key});

  final TextEditingController jobNameInputTextEditingController =
      TextEditingController();

  final TextEditingController orderNoteInputTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestQuoteSelectionBloc, RequestQuoteSelectionState>(
        builder: (_, state) {
          RequestQuoteType? selectedRequestQuoteType;
          if (state is RequestQuoteSelectionDefaultState) {
            selectedRequestQuoteType = state.requestQuoteType;
          } else if (state is RequestQuoteSelectionChangeState) {
            selectedRequestQuoteType = state.requestQuoteType;
          } else {
            selectedRequestQuoteType = null;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(LocalizationConstants.requestQuote),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RadioListTile<RequestQuoteType>(
                              title:
                                  const Text(LocalizationConstants.salesQuote),
                              value: RequestQuoteType.salesQuote,
                              groupValue: selectedRequestQuoteType,
                              onChanged: (value) {
                                context.read<RequestQuoteSelectionBloc>().add(
                                    RequestQuoteSelectionChangeEvent(value!));
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<RequestQuoteType>(
                              title: const Text(LocalizationConstants.jobQuote),
                              value: RequestQuoteType.jobQuote,
                              groupValue: selectedRequestQuoteType,
                              onChanged: (value) {
                                context.read<RequestQuoteSelectionBloc>().add(
                                    RequestQuoteSelectionChangeEvent(value!));
                              },
                            ),
                          )
                        ],
                      ),
                      Visibility(
                          visible: selectedRequestQuoteType ==
                              RequestQuoteType.jobQuote,
                          child: _buildJobNameInputWidget(context)),
                      _buildOrderNotesInputWidget(context),
                      BlocBuilder<RequestQuoteBloc, RequestQuoteState>(
                          builder: (context, state) {
                        if (state is RequestQuoteCartLinesLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${state.cartLineEntities.length} ${state.cartLineEntities.length == 1 ? "product" : "products"}',
                                  style: OptiTextStyles.body,
                                ),
                              ),
                              Column(
                                children: state.cartLineEntities
                                    .map((cartLineEntity) => CartLineWidget(
                                        cartLineEntity: cartLineEntity,
                                        showRemoveButton: false,
                                        onCartLineRemovedCallback:
                                            (cartLineEntity) {},
                                        onCartQuantityChangedCallback:
                                            (quantity) {}))
                                    .toList(),
                              ),
                            ],
                          );
                        } else if (state is RequestQuoteCartLinesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ]),
                  ),
                ),
                _buildSubmitButton()
              ],
            ),
          );
        },
        listener: (_, state) {});
  }

  Widget _buildSubmitButton() {
    return ListInformationBottomSubmitWidget(actions: [
      PrimaryButton(
        text: LocalizationConstants.submitQuote,
        onPressed: () {},
      ),
    ]);
  }

  Widget _buildJobNameInputWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Input(
          label: LocalizationConstants.jobName,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return SiteMessageConstants.defaultJobNameRequiredMessage;
            }
            return null;
          },
          controller: jobNameInputTextEditingController,
          onTapOutside: (p0) => context.closeKeyboard(),
          onEditingComplete: () => context.closeKeyboard(),
        ),
      ),
    );
  }

  Widget _buildOrderNotesInputWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Input(
          label: LocalizationConstants.orderNotes,
          controller: orderNoteInputTextEditingController,
          onTapOutside: (p0) => context.closeKeyboard(),
          onEditingComplete: () => context.closeKeyboard(),
        ),
      ),
    );
  }
}
