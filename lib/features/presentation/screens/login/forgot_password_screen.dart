import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/account_type.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/login_usecase/forgot_password_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/style.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/login/forgot_password/forgot_password_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends BaseStatelessWidget {
  final AccountType accountType;

  const ForgotPasswordScreen({
    super.key,
    required this.accountType,
  });

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>()..loadAccountSettings(),
      child: ForgotPasswordPage(accountType: accountType),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewForgotPassword,
        AnalyticsConstants.screenNameSignIn,
      );
}

class ForgotPasswordPage extends StatefulWidget {
  final AccountType accountType;

  const ForgotPasswordPage({
    super.key,
    required this.accountType,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool useEmailAsUserName =
        context.watch<ForgotPasswordCubit>().useEmailAsUserName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          LocalizationConstants.forgotPassword.localized(),
          style: OptiTextStyles.titleLarge,
        ),
        centerTitle: false,
        actions: [
          PlainButton(
            onPressed: () {
              context.pop();
            },
            style: OptiTextStyles.subtitle.copyWith(
              color: OptiAppColors.primaryColor,
            ),
            text: LocalizationConstants.cancel.localized(),
          ),
        ],
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Container(
            color: AppStyle.neutral75,
            height: 20,
          ),
        ),
      ),
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.settingsFailure) {
            _errorCommunicatingWithServer(context);
          }

          if (state.status == ForgotPasswordStatus.success) {
            Navigator.of(context, rootNavigator: true).pop();
            displayDialogWidget(
              context: context,
              content: Text(
                LocalizationConstants.forgotPasswordSuccessfulMessage
                    .localized(),
              ),
              actions: [
                PlainBlackButton(
                  text: LocalizationConstants.oK.localized(),
                  onPressed: () {
                    context.pop();
                    context.pop();
                  },
                ),
              ],
            );
          }

          if (state.status == ForgotPasswordStatus.failure) {
            Navigator.of(context, rootNavigator: true).pop();
            _errorCommunicatingWithServer(context);
          }

          if (state.status == ForgotPasswordStatus.loading) {
            showPleaseWait(context);
          }
        },
        builder: (context, state) {
          if (state.status == ForgotPasswordStatus.settingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            height: double.infinity,
            color: AppStyle.neutral00,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      AssetConstants.logo,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      useEmailAsUserName
                          ? LocalizationConstants
                              .instructionsEmailStringTemplate
                              .localized()
                          : LocalizationConstants
                              .instructionsUsernameStringTemplate
                              .localized(),
                      style: OptiTextStyles.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Input(
                      label: useEmailAsUserName
                          ? LocalizationConstants.email.localized()
                          : LocalizationConstants.username.localized(),
                      hintText: useEmailAsUserName
                          ? LocalizationConstants.enterEmail.localized()
                          : LocalizationConstants.enterUsername.localized(),
                      controller: textEditingController,
                      onTapOutside: (p0) => context.closeKeyboard(),
                    ),
                    const SizedBox(height: 16.0),
                    PrimaryButton(
                      onPressed: () {
                        context.closeKeyboard();
                        context.read<ForgotPasswordCubit>().resetPassword(
                              textEditingController.text.trim(),
                              widget.accountType,
                            );
                      },
                      text: LocalizationConstants.submit.localized(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _errorCommunicatingWithServer(BuildContext context) {
  displayDialogWidget(
    context: context,
    title: LocalizationConstants.error.localized(),
    content:
        Text(LocalizationConstants.errorCommunicatingWithTheServer.localized()),
    actions: [
      PlainBlackButton(
        text: LocalizationConstants.oK.localized(),
        onPressed: () {
          context.pop();
          context.pop();
        },
      ),
    ],
  );
}
