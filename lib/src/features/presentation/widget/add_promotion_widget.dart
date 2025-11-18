import 'dart:async';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/cart/cart_page_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/promo_code_cubit/promo_code_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/promo_code_cubit/promo_code_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/promo_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPromotionWidget extends StatefulWidget {
  final bool shouldShowPromotionList;
  final bool fromCartPage;
  final bool isAddDiscountEnable;
  final Function? onApplyPromoCode;

  const AddPromotionWidget({
    super.key,
    required this.shouldShowPromotionList,
    required this.fromCartPage,
    this.isAddDiscountEnable = true,
    this.onApplyPromoCode,
  });

  @override
  State<AddPromotionWidget> createState() => _AddPromotionWidgetState();
}

class _AddPromotionWidgetState extends State<AddPromotionWidget> {
  final TextEditingController promoCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PromoCodeCubit>().resetShowPromotionField();
    unawaited(context.read<PromoCodeCubit>().loadCartPromotions());
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PromoCodeCubit, PromoCodeState>(
      listener: (context, state) {
        if (state is PromoCodeApplySuccessState) {
          if (widget.fromCartPage) {
            context.read<CartPageBloc>().add(CartPageLoadEvent());
          }

          CustomSnackBar.showPromotionApplied(context);
          if (widget.onApplyPromoCode != null) {
            widget.onApplyPromoCode!();
          }
        } else if (state is PromoCodeFailureState) {
          CustomSnackBar.showPromotionNotApplied(context);
        }
      },
      child: BlocBuilder<PromoCodeCubit, PromoCodeState>(
        buildWhen: (previous, current) {
          return current is PromoCodeLoadedState ||
              current is PromoCodeLoadingState;
        },
        builder: (context, state) {
          if (state is PromoCodeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PromoCodeLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Visibility(
                    visible: context.read<PromoCodeCubit>().showPromotionField,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                            visible: widget.shouldShowPromotionList,
                            child: Flexible(
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                shrinkWrap: true,
                                itemCount: state.promotions?.length,
                                itemBuilder: (context, index) {
                                  return PromoCodeWidget(
                                    code: state.promotions![index].name ?? "",
                                    description:
                                        state.promotions![index].message ?? "",
                                  );
                                },
                              ),
                            )),
                        Input(
                          label:
                              LocalizationConstants.promotionalCode.localized(),
                          hintText:
                              LocalizationConstants.promotionalCode.localized(),
                          controller: promoCodeController,
                          onTapOutside: (_) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.nextFocus();
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TertiaryButton(
                            borderColor: OptiAppColors.grayBackgroundColor,
                            backgroundColor: OptiAppColors.grayBackgroundColor,
                            text: LocalizationConstants.apply.localized(),
                            onPressed: () {
                              unawaited(context
                                  .read<PromoCodeCubit>()
                                  .applyPromoCode(promoCodeController.text,
                                      widget.fromCartPage));
                            }),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        !context.read<PromoCodeCubit>().showPromotionField &&
                            widget.isAddDiscountEnable,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TertiaryButton(
                          borderColor: OptiAppColors.grayBackgroundColor,
                          backgroundColor: OptiAppColors.grayBackgroundColor,
                          text: LocalizationConstants.addDiscount.localized(),
                          onPressed: () {
                            context
                                .read<PromoCodeCubit>()
                                .updateShowPromotionField();
                            unawaited(context
                                .read<PromoCodeCubit>()
                                .loadCartPromotions());
                          }),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
