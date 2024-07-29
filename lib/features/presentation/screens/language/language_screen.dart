import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/screens/language/language_item_widget.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LanguagePage();
  }

}

class LanguagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            LocalizationConstants.languages.localized(), style: OptiTextStyles.titleLarge),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: 4 ?? 0,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
            thickness: 0.3,
          ),
          itemBuilder: (context, index) {
            return LanguageItem(isSelected: false);
          },
        ),
      ),
    );
  }

}