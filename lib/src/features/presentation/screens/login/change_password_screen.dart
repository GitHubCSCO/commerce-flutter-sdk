import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/change_password_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends BaseStatelessWidget {
  final ChangePasswordEntity? entity;

  const ChangePasswordScreen({super.key, this.entity});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangePasswordCubit>(),
      child: ChangePasswordPage(entity: entity),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewChangePassword,
        AnalyticsConstants.screenNameChangePassword,
      );

  @override
  TelemetryEvent getTelemetryScreenEvent() => TelemetryEvent(
        screenName: AnalyticsConstants.screenNameChangePassword,
      );
}

class ChangePasswordPage extends StatefulWidget {
  final ChangePasswordEntity? entity;

  const ChangePasswordPage({super.key, this.entity});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _usernameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  bool _showNewPassword = false;
  bool _showConfirmNewPassword = false;
  bool _isSubmitEnabled = false;
  static const int _minPasswordLength = 7;
  static final RegExp _containsDigit = RegExp(r'\d');

  @override
  void dispose() {
    _newPasswordController.removeListener(_updateSubmitButtonOnTextChange);
    _confirmNewPasswordController
        .removeListener(_updateSubmitButtonOnTextChange);
    _usernameController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _fillCredentials() {
    final entity = widget.entity;
    if (entity == null) return;
    _usernameController.text = entity.userName;
    _oldPasswordController.text = entity.oldPassword;
  }

  bool _checkPasswordRequirements() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmNewPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    if (newPassword.length < _minPasswordLength) {
      return false;
    }
    if (!_containsDigit.hasMatch(newPassword)) {
      return false;
    }
    if (newPassword != confirmPassword) {
      return false;
    }
    return true;
  }

  void _updateSubmitButtonOnTextChange() {
    final shouldEnable = _checkPasswordRequirements();
    if (shouldEnable != _isSubmitEnabled) {
      setState(() {
        _isSubmitEnabled = shouldEnable;
      });
    }
  }

  void _onSubmit() {
    context.closeKeyboard();
    context
        .read<ChangePasswordCubit>()
        .submit(
          userName: _usernameController.text,
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
        )
        .ignore();
  }

  @override
  void initState() {
    super.initState();
    _fillCredentials();
    _newPasswordController.addListener(_updateSubmitButtonOnTextChange);
    _confirmNewPasswordController.addListener(_updateSubmitButtonOnTextChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        switch (state) {
          case ChangePasswordLoading():
            showPleaseWait(context);
          case ChangePasswordSuccess(:final newPassword):
            Navigator.of(context, rootNavigator: true).pop();
            context.pop(newPassword);
          case ChangePasswordFailure(:final message):
            Navigator.of(context, rootNavigator: true).pop();
            CustomSnackBar.showSnackBarMessage(
              context,
              message,
              seconds: 4,
            );
          case ChangePasswordInitial():
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.scheme.surface,
          title: Text(
            LocalizationConstants.changePassword.localized(),
            style: context.text.titleLarge,
          ),
          centerTitle: false,
          actions: [
            PlainButton(
              onPressed: () => context.pop(),
              style: context.text.subtitle.copyWith(
                color: context.scheme.primary,
              ),
              text: LocalizationConstants.cancel.localized(),
            ),
          ],
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              color: context.colors.neutral75,
              height: 20,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    LocalizationConstants.changePasswordRequiredMessage
                        .localized(),
                    style: context.text.body,
                  ),
                  const SizedBox(height: 20),
                  Input(
                    label: LocalizationConstants.username.localized(),
                    hintText: LocalizationConstants.username.localized(),
                    controller: _usernameController,
                    onTapOutside: (p0) => context.closeKeyboard(),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    label: LocalizationConstants.existingPassword.localized(),
                    hintText:
                        LocalizationConstants.existingPassword.localized(),
                    obscureText: true,
                    controller: _oldPasswordController,
                    onTapOutside: (p0) => context.closeKeyboard(),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    label: LocalizationConstants.newPassword.localized(),
                    hintText: LocalizationConstants.newPassword.localized(),
                    obscureText: !_showNewPassword,
                    controller: _newPasswordController,
                    onTapOutside: (p0) => context.closeKeyboard(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showNewPassword = !_showNewPassword;
                        });
                      },
                      icon: _showNewPassword
                          ? SvgAssetImage(
                              assetName: AssetConstants.iconEyeOff,
                            )
                          : SvgAssetImage(
                              assetName: AssetConstants.iconEye,
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    label: LocalizationConstants.confirmNewPassword.localized(),
                    hintText:
                        LocalizationConstants.confirmNewPassword.localized(),
                    obscureText: !_showConfirmNewPassword,
                    controller: _confirmNewPasswordController,
                    onTapOutside: (p0) => context.closeKeyboard(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showConfirmNewPassword = !_showConfirmNewPassword;
                        });
                      },
                      icon: _showConfirmNewPassword
                          ? SvgAssetImage(
                              assetName: AssetConstants.iconEyeOff,
                            )
                          : SvgAssetImage(
                              assetName: AssetConstants.iconEye,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    LocalizationConstants.passwordRequirements.localized(),
                    style: context.text.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    LocalizationConstants.passwordMinimumLengthRequirement
                        .localized(),
                    style: context.text.body,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    LocalizationConstants.passwordDigitRequirement.localized(),
                    style: context.text.body,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    isEnabled: _isSubmitEnabled,
                    onPressed: _onSubmit,
                    text: LocalizationConstants.saveNewPassword.localized(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
