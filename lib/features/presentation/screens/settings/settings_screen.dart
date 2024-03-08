import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/settings_domain/settings_domain_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsDomainCubit>()..fetchDomain(),
      child: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppStyle.neutral00,
        title: const Text(LocalizationConstants.settings),
        centerTitle: false,
      ),
      body: const Center(
        child: Column(
          children: [
            _SettingsListWidget(),
            SizedBox(height: 16),
            _SettingsDomainSelectorWidget(),
          ],
        ),
      ),
    );
  }
}

class _SettingsDomainSelectorWidget extends StatelessWidget {
  const _SettingsDomainSelectorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.neutral00,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(LocalizationConstants.currentDomain),
          const SizedBox(height: 8),
          BlocBuilder<SettingsDomainCubit, SettingsDomainState>(
            builder: (context, state) {
              if (state is SettingsDomainLoaded) {
                return Text(
                  state.domain,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return const Text('...');
              }
            },
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            leadingIcon: SvgPicture.asset(
              AssetConstants.iconChangeDomain,
              semanticsLabel: 'Change domain icon',
              fit: BoxFit.fitWidth,
            ),
            text: LocalizationConstants.changeDomain,
            onPressed: () =>
                AppRoute.domainSelection.navigateBackStack(context),
          )
        ],
      ),
    );
  }
}

class _SettingsListWidget extends StatelessWidget {
  const _SettingsListWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppStyle.neutral00,
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => settingsItems[index],
        separatorBuilder: (context, index) => const Divider(
          height: 0,
          thickness: 1,
        ),
        itemCount: settingsItems.length,
      ),
    );
  }
}

final settingsItems = [
  _SettingsListItemWidget(
    onTap: () {},
    title: LocalizationConstants.clearCache,
  ),
  _SettingsListItemWidget(
    title: LocalizationConstants.languages,
    onTap: () {},
    showTrailing: true,
  ),
  _SettingsListItemWidget(
    title: LocalizationConstants.adminLogin,
    onTap: () {},
  ),
];

class _SettingsListItemWidget extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final bool showTrailing;

  const _SettingsListItemWidget({
    required this.onTap,
    required this.title,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xFF222222),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  showTrailing
                      ? Container(
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.all(7),
                          child: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                            size: 20,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
