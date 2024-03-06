import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';

class SearchHistoryItemWidget extends StatelessWidget {
  final String history;

  const SearchHistoryItemWidget({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: double.infinity,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            child: Text(
              history,
              style: OptiTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
