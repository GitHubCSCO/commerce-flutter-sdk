import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/remote_config/remote_config_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DomainScreen extends BaseStatelessWidget {
  const DomainScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RemoteConfigCubit>()..fetchDebugDomains(),
        ),
      ],
      child: const DomainWelcomeScreen(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameDomainSelection,
      );
}

class DomainWelcomeScreen extends StatelessWidget {
  const DomainWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WelcomeBaseScreen(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              LocalizationConstants.cancel.localized(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      child: const DomainPage(),
    );
  }
}

class DomainPage extends StatefulWidget {
  const DomainPage({super.key});

  @override
  State<DomainPage> createState() => _DomainPageState();
}

class _DomainPageState extends State<DomainPage> {
  final TextEditingController _textEditingController = TextEditingController();

  void _fillCredentials(String siteUrl) {
    setState(() {
      _textEditingController.text = siteUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(() {});
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WelcomeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
              builder: (context, state) {
                if (state is RemoteConfigDebugDomainLoaded &&
                    state.domains.isNotEmpty) {
                  return _buildDropdown(state.domains);
                } else {
                  return Container();
                }
              },
            ),
            Text(
              LocalizationConstants.existingCustomers.localized(),
              style: WelcomeStyle.welcomeCardHeaderStyle,
            ),
            const SizedBox(height: 8.0),
            _buildTextInput(context),
            const SizedBox(height: 8.0),
            _buildPrimaryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(Map<String, String> debugCredentials) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: const Text('Select domain'),
        onChanged: (String? newValue) {
          setState(() {
            if (newValue.isNullOrEmpty == false &&
                debugCredentials.containsKey(newValue)) {
              _fillCredentials(debugCredentials[newValue]!);
            }
          });
        },
        items: debugCredentials.keys
            .map<DropdownMenuItem<String>>((String siteUrl) {
          return DropdownMenuItem<String>(
            value: siteUrl,
            child: Text(siteUrl),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return BlocConsumer<DomainCubit, DomainState>(
      listener: (context, state) {
        if (state is DomainLoaded) {
          context.read<AuthCubit>().reset();
          while (context.canPop()) {
            context.pop();
          }
          AppRoute.root.navigateBackStack(context);
        } else if (state is DomainOperationFailed) {
          _showErrorDialog(context, state);
        }
      },
      builder: (context, state) {
        if (state is DomainOperationInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return PrimaryButton(
            onPressed: _textEditingController.text.isNotEmpty
                ? () {
                    context.closeKeyboard();
                    context
                        .read<DomainCubit>()
                        .selectDomain(_textEditingController.text);
                  }
                : null,
            isEnabled: _textEditingController.text.isNotEmpty,
            text: LocalizationConstants.useECommerceWebsite.localized(),
          );
        }
      },
    );
  }

  void _showErrorDialog(BuildContext context, DomainOperationFailed state) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(state.title),
        content: Text(state.message),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(LocalizationConstants.oK.localized()),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(BuildContext context) {
    return Input(
      controller: _textEditingController,
      hintText: LocalizationConstants.enterDomainHint.localized(),
      onTapOutside: (p0) => context.closeKeyboard(),
      label: 'Enter Storefront URL',
    );
  }
}
