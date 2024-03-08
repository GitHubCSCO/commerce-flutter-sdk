import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_history_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHistorySectionWidget extends StatelessWidget {
  final SearchHistoryWidgetEntity searchHistoryWidgetEntity;

  const SearchHistorySectionWidget(
      {super.key, required this.searchHistoryWidgetEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              searchHistoryWidgetEntity.title ?? LocalizationConstants.searchHistory,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: _historyListCount(searchHistoryWidgetEntity.itemsCount, searchHistoryWidgetEntity.histories?.length ?? 0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final history =  searchHistoryWidgetEntity.histories![index];
                return SearchHistoryItemWidget(history: history);
              },
            ),
          )
        ],
      ),
    );
  }

  int _historyListCount(String? itemsCountLimit, int itemCount) {
    int limit = int.tryParse(itemsCountLimit ?? '') ?? itemCount;
    return limit < itemCount ? limit : itemCount;
  }

}
