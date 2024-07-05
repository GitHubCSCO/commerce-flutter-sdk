import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandAutoCompleteWidget extends StatelessWidget {

  final Function(BuildContext, AutocompleteBrand) callback;
  final List<AutocompleteBrand>? autocompleteBrands;

  const BrandAutoCompleteWidget({super.key, required this.callback, required this.autocompleteBrands});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Color(0xFFF5F5F5),
      ),
      itemCount: autocompleteBrands?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final autoCompleteBrand = autocompleteBrands![index];
        return InkWell(
          onTap: () {
            callback(context, autoCompleteBrand);
          },
          child: AutoCompleteBrandWidget(autoCompleteBrand: autoCompleteBrand),
        );
      },
    );
  }
}

class AutoCompleteBrandWidget extends StatelessWidget {

  final AutocompleteBrand autoCompleteBrand;

  const AutoCompleteBrandWidget(
      {super.key, required this.autoCompleteBrand});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Text(
        _getBrandTitle(autoCompleteBrand),
        style: OptiTextStyles.body,
      ),
    );
  }

  String _getBrandTitle(AutocompleteBrand autoCompleteBrand) {
    final productLine = autoCompleteBrand.productLineName ?? '';
    final title = autoCompleteBrand.title ?? '';
    if (productLine.isNotEmpty && title.isNotEmpty) {
      return LocalizationConstants.autocompleteCategoryOrBrandCombinedTitle.format([productLine, title]);
    } else {
      return title;
    }
  }

}

