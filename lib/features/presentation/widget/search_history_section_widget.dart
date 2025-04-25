import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/search_history_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/search_history_item_widget.dart';
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
              (searchHistoryWidgetEntity.title ?? "").isEmpty
                  ? LocalizationConstants.searchHistory.localized()
                  : searchHistoryWidgetEntity.title!,
              style: OptiTextStyles.titleLarge,
            ),
          ),
          BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
            builder: (context, state) {
              switch (state) {
                case SearchHistoryInitialState():
                case SearchHistoryLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case SearchHistoryLoadedState():
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: (state.historyList.isNotEmpty)
                        ? ListView.builder(
                            padding: const EdgeInsets.all(0.0),
                            itemCount: _historyListCount(
                                searchHistoryWidgetEntity.itemsCount,
                                state.historyList.length),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final history = state.historyList[index];
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<RootBloc>()
                                      .add(RootInitiateSearchEvent(history));
                                },
                                child:
                                    SearchHistoryItemWidget(history: history),
                              );
                            },
                          )
                        : SearchHistoryItemWidget(
                            history: LocalizationConstants
                                .searchNoHistoryAvailable
                                .localized()),
                  );
                default:
                  return const Center();
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
