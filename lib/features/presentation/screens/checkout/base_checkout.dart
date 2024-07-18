import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/string_format_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin BaseCheckout {

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocalizationConstants.checkout.localized()),
      backgroundColor: Colors.white,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              LocalizationConstants.cancel.localized(),
              style: OptiTextStyles.subtitleLink,
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  Widget buildSummary(
      Cart cart, PromotionCollectionModel? promotionCollectionModel) {
    String promotionInfo;
    String promotionValue;
    Promotion? lastPromotion;
    Promotion? promotion;

    var promotions = promotionCollectionModel?.promotions
        ?.where((x) => x.amount != 0)
        .toList();

    if (promotions == null || promotions.isEmpty) {
      promotionInfo = '';
      promotionValue = '';
    } else {
      lastPromotion = promotions.last;
      promotion = promotions.first;
    }

    var info = '';

    if (promotions != null && promotions.length > 1) {
      info = LocalizationConstants.promoCodesMore.localized()
          .format([lastPromotion?.name, promotions.length - 1]);
    } else {
      info = LocalizationConstants.promoCodes.localized().format([lastPromotion?.name]);
    }

    var amount = promotions?.fold(
        0,
            (previousValue, element) =>
        previousValue + (element.amount?.toInt() ?? 0));

    var currencySymbol = '';

    if (promotion != null &&
        promotion.amountDisplay != null &&
        promotion.amountDisplay!.isNotEmpty) {
      currencySymbol = promotion.amountDisplay!.substring(0, 1);
    }

    promotionInfo = info;
    promotionValue = '- $currencySymbol${amount ?? 0.toStringAsFixed(2)}';

    List<Widget> list = [];

    if (promotion != null && lastPromotion != null) {
      list.add(
          _buildRow(promotionInfo, promotionValue, OptiTextStyles.bodyFade)!);
    }

    list.add(_buildRow(LocalizationConstants.subtotal.localized(),
        cart.orderGrandTotalDisplay ?? '', OptiTextStyles.subtitle)!);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: list),
    );
  }

  final _notesController = TextEditingController();

  Widget buildOrderNote() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Input(
        label: LocalizationConstants.orderNotes.localized(),
        controller: _notesController,
      ),
    );
  }

  Widget? _buildRow(String title, String body, TextStyle textStyle) {
    if (title.isEmpty || body.isEmpty) {
      return null;
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: textStyle,
              ),
            ),
          ),
          Text(
            body,
            textAlign: TextAlign.start,
            style: textStyle,
          )
        ],
      );
    }
  }

}