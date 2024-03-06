import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
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
              searchHistoryWidgetEntity.title ??
                  LocalizationConstants.searchHistory,
              style: OptiTextStyles.titleLarge,
            ),
          ),
          BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case SearchHistoryInitialState:
                case SearchHistoryoadingState:
                  return const Center(child: CircularProgressIndicator());
                case SearchHistoryLoadedState:
                  final historyList =
                      (state as SearchHistoryLoadedState).historyList;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ListView.builder(
                      itemCount: _historyListCount(
                          searchHistoryWidgetEntity.itemsCount,
                          historyList.length),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final history = historyList[index];
                        return SearchHistoryItemWidget(history: history);
                      },
                    ),
                  );
                case SearchHistoryFailureState:
                default:
                  return const Center(child: Text('Failed Loading history'));
              }
            },
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
