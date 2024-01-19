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
              "Search History",
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case SearchHistoryInitialState:
                case SearchHistoryoadingState:
                  return const Center(child: CircularProgressIndicator());
                case SearchHistoryLoadedState:
                  final historyList = (state as SearchHistoryLoadedState).historyList;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListView.builder(
                      itemCount: historyList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
}
