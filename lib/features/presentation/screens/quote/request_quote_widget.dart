import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/request_quote_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_state.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote_selection/request_quote_selection_state.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/helper/menu/tool_menu.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_line/cart_line_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/wish_list/wish_list_info_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/selection_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RequestQuoteWidgetScreen extends StatelessWidget {
  final Cart? cart;
  const RequestQuoteWidgetScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => sl<RequestQuoteBloc>()
            ..add(RequestQuoteAddCartEvent(cart: cart))
            ..add(LoadRequestQuoteCartLinesEvent())),
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
                      BlocBuilder<RequestQuoteBloc, RequestQuoteState>(
                          buildWhen: (previous, current) {
                        if (current is RequestAddCartInitSuccessState) {
                          return true;
                        }
                        return false;
                      }, builder: (_, state) {
                        if (state is RequestAddCartInitSuccessState) {
                          return _buildSelectUserWidget(context);
                        } else {
                          return Container();
                        }
                      }),
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
                      MultiBlocListener(
                          listeners: [
                            BlocListener<RequestQuoteBloc, RequestQuoteState>(
                              listener: (context, state) {
                                if (state is DeleteCartLineSuccessState ||
                                    state is UpdateCartlineSuccessState) {
                                  context
                                      .read<RequestQuoteBloc>()
                                      .add(LoadRequestQuoteCartLinesEvent());
                                } else if (state is SubmitQuoteSuccessState) {
                                  if (context
                                      .read<RequestQuoteBloc>()
                                      .isSalesPerson) {
                                    Navigator.pop(context);
                                    AppRoute.quoteDetails.navigateBackStack(
                                        context,
                                        extra: state.quoteDto);
                                  } else {
                                    Navigator.pop(context);
                                    AppRoute.quoteConfirmation
                                        .navigateBackStack(context,
                                            extra: state.quoteDto);
                                  }
                                } else if (state is SubmitQuoteErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                          child:
                              BlocBuilder<RequestQuoteBloc, RequestQuoteState>(
                                  buildWhen: (previous, current) {
                            if (current is RequestQuoteCartLinesLoaded ||
                                current is RequestQuoteCartLinesLoading) {
                              return true;
                            }
                            return false;
                          }, builder: (context, state) {
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
                                            moreButtonWidget: _buildMenuButton(
                                                context, cartLineEntity),
                                            onCartLineRemovedCallback:
                                                (cartLineEntity) {},
                                            onCartQuantityChangedCallback:
                                                (quantity) {
                                              context
                                                  .read<RequestQuoteBloc>()
                                                  .add(UpdateCartLineEvent(
                                                      cartLineEntity:
                                                          cartLineEntity.copyWith(
                                                              qtyOrdered:
                                                                  quantity)));
                                            }))
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
                          })),
                    ]),
                  ),
                ),
                _buildSubmitButton(() {
                  context.read<RequestQuoteBloc>().add(SubmitQuoteEvent(
                      requestQuoteType: selectedRequestQuoteType!,
                      jobName: jobNameInputTextEditingController.text,
                      note: orderNoteInputTextEditingController.text));
                })
              ],
            ),
          );
        },
        listener: (_, state) {});
  }

  Widget _buildSubmitButton(VoidCallback onPressed) {
    return ListInformationBottomSubmitWidget(actions: [
      PrimaryButton(
        text: LocalizationConstants.submitQuote,
        onPressed: onPressed,
      ),
    ]);
  }

  Widget _buildMenuButton(BuildContext context, CartLineEntity cartLineEntity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SizedBox(
        width: 30,
        height: 30,
        child: BottomMenuWidget(
            isViewOnWebsiteEnable: false,
            toolMenuList: _buildToolMenu(context, cartLineEntity)),
      ),
    );
  }

  List<ToolMenu> _buildToolMenu(
      BuildContext context, CartLineEntity cartLineEntity) {
    List<ToolMenu> list = [];
    list.add(ToolMenu(title: LocalizationConstants.lineNotes, action: () {}));
    list.add(ToolMenu(
        title: LocalizationConstants.delete,
        action: () {
          context
              .read<RequestQuoteBloc>()
              .add(DeleteCartLineEvent(cartLineEntity: cartLineEntity));
        }));
    return list;
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

  Widget _buildSelectUserWidget(BuildContext context) {
    return Visibility(
      visible: context.read<RequestQuoteBloc>().isSalesPerson,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizationConstants.creatingQuoteFor,
              style: OptiTextStyles.subtitle,
            ),
            const SizedBox(height: 10),
            FilterItemPickerWidget(
              item: context.read<RequestQuoteBloc>().selectedUser,
              onItemSelected: (user) {
                context.read<RequestQuoteBloc>().add(SelectUserForSalesRepEvent(
                    selectedUser: user as CatalogTypeDto));
              },
              selectedLabel:
                  context.read<RequestQuoteBloc>().selectedUser?.title ?? '',
              defaultLabel: LocalizationConstants.selectUser,
              onTap: () async {
                return await context.pushNamed(
                  AppRoute.userSelection.name,
                  extra: CatalogTypeSelectingParameter(
                    currentItem: context.read<RequestQuoteBloc>().selectedUser,
                    removeMyself: true,
                  ),
                );
              },
            ),
          ],
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
