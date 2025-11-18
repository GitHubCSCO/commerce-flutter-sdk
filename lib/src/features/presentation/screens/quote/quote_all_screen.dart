import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_all_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/quote/quote_all_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/list_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteAllScreen extends StatelessWidget {
  final QuoteDto quoteDto;
  const QuoteAllScreen({super.key, required this.quoteDto});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuoteAllCubit>()..initialize(quoteDto),
      child: QuoteAllPage(),
    );
  }
}

class QuoteAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.quoteAll.localized()),
        actions: [
          InkWell(
            onTap: () {
              context.read<QuoteAllCubit>().onValidateDiscount();
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
      body: SafeArea(
        child: BlocConsumer<QuoteAllCubit, QuoteAllState>(
          listener: (_, state) {
            if (state is QuoteAllValidationState) {
              context.read<QuoteAllCubit>().quoteAll();
            } else if (state is QuoteAllAppliedSuccessState) {
              CustomSnackBar.showSuccesss(context);
              Navigator.pop(context);
            }
          },
          buildWhen: (previous, current) {
            if (current is! QuoteAllValidationState &&
                current is! QuoteAllAppliedSuccessState) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is QuoteAllLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuoteAllLoadedState) {
              return _buildQuoteAllWidget(state, context);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuoteAllWidget(QuoteAllLoadedState state, BuildContext context) {
    final controller = TextEditingController();
    void _onDiscountSelect(BuildContext context, Object item) {
      context
          .read<QuoteAllCubit>()
          .onselectCalculationMethod(item as CalculationMethod);
    }

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(state.titleMsg),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: OptiAppColors.backgroundInput,
                        borderRadius:
                            BorderRadius.circular(AppStyle.borderRadius),
                      ),
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ListPickerWidget(
                                    items:
                                        state.quoteDto.calculationMethods ?? [],
                                    selectedIndex: context
                                        .read<QuoteAllCubit>()
                                        .selectedCarrierIndex,
                                    callback: _onDiscountSelect),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Input(
                    label: "",
                    controller: controller,
                    onChanged: (p0) {
                      context
                          .read<QuoteAllCubit>()
                          .onUpdateDiscountQuantity(p0);
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
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "%",
                    style: OptiTextStyles.header2,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<QuoteAllCubit, QuoteAllState>(
              buildWhen: (previous, current) {
                if (current is QuoteAllValidationState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is QuoteAllValidationState &&
                    state.isValid == false) {
                  return Text(
                    state.message ?? "",
                    style: OptiTextStyles.errorText,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
