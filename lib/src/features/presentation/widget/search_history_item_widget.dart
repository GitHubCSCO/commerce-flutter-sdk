import 'package:flutter/material.dart';
import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';

class SearchHistoryItemWidget extends StatelessWidget {
  final String history;

  const SearchHistoryItemWidget({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            color: Colors.black54,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              history,
              style: context.text.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
