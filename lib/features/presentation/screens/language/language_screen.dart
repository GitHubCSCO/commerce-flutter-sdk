import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/language/language_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/screens/language/language_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>(
      create: (context) => sl<LanguageBloc>()..add(LanguageListLoadEvent()),
      child: LanguagePage(),
    );
  }

}

class LanguagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.languages.localized(),
            style: OptiTextStyles.titleLarge),
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (previous, current) =>
            current is LanguageInitial ||
            current is LanguageLoading ||
            current is LanguageListLoaded ||
            current is LanguageFailedToLoad,
        builder: (context, state) {
          switch(state) {
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
                        context.read<LanguageBloc>()
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