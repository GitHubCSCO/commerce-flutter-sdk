import 'package:commerce_flutter_app/core/extensions/product_unit_of_measure_extension.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_style_traits_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:flutter/material.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin PickerMixin {
  String getItemDescriptions(Object item) {
    if (item is CarrierDto) {
      return item.description!;
    } else if (item is ShipViaDto) {
      return item.description!;
    } else if (item is PaymentMethodDto) {
      if (item.description! != "") {
        return item.description!;
      } else {
        return item.name ?? "";
      }
    } else if (item is ConfigSectionOptionEntity) {
      return item.description!;
    } else if (item is ProductDetailStyleValue) {
      return item.displayName!;
    } else if (item is String) {
      return item;
    } else if (item is KeyValuePair) {
      return item.key.toString();
    } else if (item is Country) {
      return item.name ?? "";
    } else if (item is StateModel) {
      return item.name ?? "";
    } else if (item is CalculationMethod) {
      return item.displayName ?? item.name ?? item.value ?? "";
    } else if (item is ProductUnitOfMeasureEntity) {
      return item.getUnitOfMeasureTextDisplayWithQuantity();
    } else {
      return '';
    }
  }

  bool isOptionAvailable(Object option) {
    // Assuming isAvailable is a property of the option object
    if (option is ProductDetailStyleValue) {
      return option.isAvailable!;
    } else {
      return true; // Return true by default if isAvailable property is not found
    }
  }

  bool getValueAvailability(Object item) {
    if (item is StyleValueEntity) {
      return item.isAvailable ?? true;
    }
    return true;
  }

  Widget? getAvatar(Object item) {
    if (item is StyleValueEntity) {
      if (!getValueAvailability(item)) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      } else if (item.swatchImageValue != null &&
          item.swatchImageValue!.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            item.swatchImageValue!,
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        );
      } else if (item.swatchColorValue != null &&
          item.swatchColorValue!.isNotEmpty) {
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(int.parse("FF${item.swatchColorValue!}", radix: 16)),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }
    }

    return null;
  }

  Widget getItemDescriptionWithAvatar(Object item) {
    if (item is ProductDetailStyleValue) {
      final avatar = getAvatar(item.styleValue ?? '');
      return Row(
        children: [
          avatar ?? const SizedBox.shrink(),
          if (avatar != null) const SizedBox(width: 16),
          Text(
            item.displayName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: OptiTextStyles.body,
          ),
        ],
      );
    }

    return Text(
      getItemDescriptions(item),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: OptiTextStyles.body,
    );
  }
}
