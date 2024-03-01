import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DomainScreen extends StatelessWidget {
  const DomainScreen({super.key});

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
            child: const Text(
              LocalizationConstants.cancel,
              style: TextStyle(color: Colors.black),
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
        constraints: WelcomeStyle.welcomeSecondPageCardConstraints,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              LocalizationConstants.existingCustomers,
              style: WelcomeStyle.welcomeCardHeaderStyle,
            ),
            WelcomeStyle.welcomeCardTextSpacer,
            Input(
              controller: _textEditingController,
              hintText: LocalizationConstants.enterDomainHint,
              label: 'Enter Storefront URL',
            ),
            const Expanded(child: SizedBox()),
            BlocConsumer<DomainCubit, DomainState>(
              listener: (context, state) {
                if (state is DomainHasValue) {
                  context.pop();
                  final branches =
                      StatefulNavigationShell.of(context).route.branches;

                  for (final branch in branches) {
                    try {
                      branch.navigatorKey.currentState
                          ?.popUntil((route) => route.isFirst);
                    } catch (e) {
                      continue;
                    }
                  }

                  AppRoute.shop.navigate(context);
                }

                if (state is DomainOperationFailed) {
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
                          child: const Text(LocalizationConstants.oK),
                        ),
                      ],
                    ),
                  );
                }
              },
              builder: (context, state) {
                return state is DomainOperationInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        onPressed: () {
                          context
                              .read<DomainCubit>()
                              .selectDomain(_textEditingController.text);
                        },
                        isEnabled: _textEditingController.text.isNotEmpty,
                        text: LocalizationConstants.useECommerceWebsite,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
