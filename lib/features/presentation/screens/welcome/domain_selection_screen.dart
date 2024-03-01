import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_change/domain_change_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_selection/domain_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DomainSelectionScreen extends StatelessWidget {
  const DomainSelectionScreen({super.key});

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
      child: BlocProvider(
        create: (context) => sl<DomainSelectionCubit>(),
        child: const DomainSelectionPage(),
      ),
    );
  }
}

class DomainSelectionPage extends StatefulWidget {
  const DomainSelectionPage({super.key});

  @override
  State<DomainSelectionPage> createState() => _DomainSelectionPageState();
}

class _DomainSelectionPageState extends State<DomainSelectionPage> {
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
            BlocConsumer<DomainSelectionCubit, DomainSelectionState>(
              listener: (context, state) {
                if (state is DomainSelectionSuccess) {
                  context
                      .read<DomainChangeCubit>()
                      .changeDomain(_textEditingController.text);
                  AppRoute.shop.navigate(context);
                }

                if (state is DomainSelectionFailed) {
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
                return state is DomainSelectionInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : PrimaryButton(
                        onPressed: () {
                          context
                              .read<DomainSelectionCubit>()
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
