import 'package:flutter/material.dart';

enum WishListFilterAutocompleteType {
  erpNumber,
  brandId,
  sharedBy,
  ;

  static const erpNumberKey = 'erpNumber';
  static const brandIdKey = 'brandId';
  static const sharedByKey = 'sharedBy';
}

// Should get the selected value in calling function by context.pop(selectedValue);
class WishListFilterAutocompleteScreen extends StatelessWidget {
  final WishListFilterAutocompleteType type;

  const WishListFilterAutocompleteScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
