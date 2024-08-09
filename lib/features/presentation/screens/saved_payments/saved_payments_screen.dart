import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_payments/saved_payments_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/saved_payments/saved_payments_state.dart';
import 'package:commerce_flutter_app/features/presentation/helper/callback/credit_card_add_callback_helper.dart';
import 'package:commerce_flutter_app/features/presentation/widget/add_credit_card_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPaymentsScreen extends StatelessWidget {
  const SavedPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: OptiAppColors.backgroundWhite,
          title: Text(LocalizationConstants.mySavedPayments.localized()),
          centerTitle: false,
          actions: [
            BottomMenuWidget(
              websitePath: WebsitePaths.savedPaymentsWebsitePath,
            ),
          ],
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider<SavedPaymentsCubit>(
              create: (context) =>
                  sl<SavedPaymentsCubit>()..loadSavedPayments()),
        ], child: SavedPaymentPage()));
  }
}

class SavedPaymentPage extends StatelessWidget {
  const SavedPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPaymentsCubit, SavedPaymentsState>(
        builder: (_, state) {
      if (state is SavedPaymentsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SavedPaymentsLoadedState) {
        return Column(
          children: [
            Expanded(
              child: state.accountPaymentProfiles != null &&
                      state.accountPaymentProfiles!.isEmpty
                  ? Center(
                      child: Text(
                          LocalizationConstants.noSavedPaymentsFound
                              .localized(),
                          style: OptiTextStyles.body),
                    )
                  : ListView(
                      children: _buildListWidgets(state, context),
                    ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: PrimaryButton(
                onPressed: () {
                  AppRoute.addCreditCard.navigateBackStack(context,
                      extra: CreditCardAddCallbackHelper(
                          addCreditCardEntity:
                              AddCreditCardEntity(isAddNewCreditCard: true),
                          onAddedCeditCard: (paymentProfile) {
                            context
                                .read<SavedPaymentsCubit>()
                                .loadSavedPayments();
                          }));
                },
                text: LocalizationConstants.addCreditCard.localized(),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  List<Widget> _buildListWidgets(
      SavedPaymentsLoadedState state, BuildContext context) {
    return List.generate(state.accountPaymentProfiles?.length ?? 0, (index) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              AppRoute.addCreditCard.navigateBackStack(context,
                  extra: CreditCardAddCallbackHelper(
                      onDeletedCreditCard: () {
                        context.read<SavedPaymentsCubit>().loadSavedPayments();
                      },
                      addCreditCardEntity: AddCreditCardEntity(
                          isAddNewCreditCard: false,
                          accountPaymentProfile:
                              state.accountPaymentProfiles?[index]),
                      onAddedCeditCard: (paymentProfile) {
                        context.read<SavedPaymentsCubit>().loadSavedPayments();
                      }));
            },
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(
                    state.accountPaymentProfiles?[index].cardHolderName ?? ""),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: OptiAppColors.mediumGrayTextColor,
                ),
              ),
            ),
          ),
          const Divider(), // This adds a separator after each ListTile
        ],
      );
    });
  }
}
