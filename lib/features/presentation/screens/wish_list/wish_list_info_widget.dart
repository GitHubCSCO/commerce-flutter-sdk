import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNameInputWidget extends StatelessWidget {
  const ListNameInputWidget({
    super.key,
    required this.listNameController,
    this.readOnly = false,
    this.maxLength,
  });

  final TextEditingController listNameController;
  final bool readOnly;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: readOnly,
      child: Input(
        label: LocalizationConstants.listName.localized(),
        controller: listNameController,
        onTapOutside: (p0) => context.closeKeyboard(),
        onEditingComplete: () => context.closeKeyboard(),
        maxLength: maxLength,
      ),
    );
  }
}

class ListDescriptionInputWidget extends StatelessWidget {
  const ListDescriptionInputWidget({
    super.key,
    required this.listDescriptionController,
    this.readOnly = false,
  });

  final TextEditingController listDescriptionController;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: readOnly,
      child: SizedBox(
        height: 100,
        child: Input(
          label: LocalizationConstants.descriptionOptional.localized(),
          controller: listDescriptionController,
          onTapOutside: (p0) => context.closeKeyboard(),
          onEditingComplete: () => context.closeKeyboard(),
        ),
      ),
    );
  }
}

class ListDetailsWidget extends StatelessWidget {
  const ListDetailsWidget({
    super.key,
    required this.wishList,
  });

  final WishListEntity wishList;

  String get _sharedInfoText {
    String sharedInfoText = '';
    if (wishList.isSharedList == true ||
        (wishList.wishListSharesCount ?? 0) > 0) {
      if ((wishList.wishListSharesCount ?? 0) > 0 &&
          wishList.isSharedList != true) {
        sharedInfoText = LocalizationConstants.sharedWith
            .localized()
            .format([wishList.wishListSharesCount ?? 0]);
      } else if (wishList.isSharedList == true) {
        sharedInfoText =
            LocalizationConstants.sharedBy.localized().format(['']);
      }
    } else if (wishList.isSharedList != true &&
        (wishList.wishListSharesCount ?? 0) == 0) {
      sharedInfoText = LocalizationConstants.private.localized();
    }

    return sharedInfoText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationConstants.listDetails.localized(),
          style: OptiTextStyles.titleLarge,
        ),
        const SizedBox(height: 32),
        _ListDetailsPropertiesRow(
          title: LocalizationConstants.listUpdated.localized(),
          value: LocalizationConstants.updateOnBy.localized().format(
            [
              wishList.updatedOn != null
                  ? DateFormat(CoreConstants.dateFormatString)
                      .format(wishList.updatedOn!)
                  : '',
              wishList.updatedByDisplayName ?? '',
            ],
          ),
        ),
        const SizedBox(height: 16),
        _ListDetailsPropertiesRow(
          title: LocalizationConstants.usersShared.localized(),
          value: _sharedInfoText,
        ),
        const SizedBox(height: 16),
        _ListDetailsPropertiesRow(
          title: LocalizationConstants.products.localized(),
          value: LocalizationConstants.items
              .localized()
              .format([wishList.wishListLinesCount]),
        ),
      ],
    );
  }
}

class _ListDetailsPropertiesRow extends StatelessWidget {
  const _ListDetailsPropertiesRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: OptiTextStyles.subtitle,
        ),
        Text(
          value,
          style: OptiTextStyles.body,
        ),
      ],
    );
  }
}

class ListInformationBottomSubmitWidget extends StatelessWidget {
  const ListInformationBottomSubmitWidget({super.key, required this.actions});

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: OptiAppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 5,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 13.5,
        horizontal: 31.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions
            .map(
              (widget) => Expanded(
                child: widget,
              ),
            )
            .expand((element) => [element, const SizedBox(width: 16)])
            .take(actions.length * 2 - 1)
            .toList(),
      ),
    );
  }
}
