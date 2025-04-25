import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/language/language_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/language/language_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageScreen extends BaseStatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      create: (context) => sl<LanguageBloc>()..add(LanguageListLoadEvent()),
      child: const LanguagePage(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameLanguages,
      );
}

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.languages.localized(),
            style: OptiTextStyles.titleLarge),
      ),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageChanged) {
            context.read<RootBloc>().add(RootConfigChangeEvent());
          }
        },
        buildWhen: (previous, current) =>
            current is LanguageInitial ||
            current is LanguageLoading ||
            current is LanguageListLoaded ||
            current is LanguageFailedToLoad,
        builder: (context, state) {
          switch (state) {
            case LanguageInitial():
            case LanguageLoading():
              return const Center(child: CircularProgressIndicator());
            case LanguageListLoaded():
              final languages = state.languages;
              final selectedLanguage = state.selectedLanguage;
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.separated(
                  itemCount: languages?.length ?? 0,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    thickness: 0.3,
                  ),
                  itemBuilder: (context, index) {
                    final language = languages![index];
                    final isSelected = (selectedLanguage != null &&
                            selectedLanguage.id == language.id)
                        ? true
                        : false;
                    return LanguageItem(
                      language: language,
                      isSelected: isSelected,
                      onCallBack: (context, language) {
                        context
                            .read<LanguageBloc>()
                            .add(LanguageChangeEvent(language: language));
                      },
                    );
                  },
                ),
              );
            case LanguageFailedToLoad():
            default:
              return CustomScrollView(
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: Center(
                      child: Text(LocalizationConstants.error.localized()),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
