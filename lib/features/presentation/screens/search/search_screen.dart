import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search_query/search_query_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/widget/auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SearchPageCmsBloc>(
        create: (context) =>
            sl<SearchPageCmsBloc>()..add(SearchPageCmsLoadEvent()),
      ),
      BlocProvider<SearchQueryBloc>(
        create: (context) =>
            sl<SearchQueryBloc>(),
      ),
    ], child: SearchPage());
  }
}

class SearchPage extends BaseDynamicContentScreen {

  bool _hasFocus = false;
  String _searchQuery = "";

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SearchQueryBloc, SearchQueryState>(
            listener: (_, state) {
              // switch (state.runtimeType) {
              //   case SearchQueryFocusState:
              //     if(_hasFocus && _searchQuery.isNotEmpty) {
              //       //call search product api
              //     }
              //   case SearchQueryTypingState:
              //     //call search product api
              //   case SearchQueryUnFocusState:
              //     if(_hasFocus && _searchQuery.isNotEmpty) {
              //       //call search product api
              //     }
              // }
            }
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 36),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Input(
              hintText: LocalizationConstants.search,
              onTapOutside: (context) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              textInputAction: TextInputAction.search,
              focusListener: (bool hasFocus) {
                if (hasFocus) {
                  print('TextField is focused');
                  // _hasFocus = true;
                  context.read<SearchQueryBloc>().add(SearchQueryFocusEvent());
                } else {
                  print('TextField lost focus');
                  // _hasFocus = false;
                  context
                      .read<SearchQueryBloc>()
                      .add(SearchQueryUnFocusEvent());
                }
              },
              onChanged: (String searchQuery) {
                print(searchQuery);
                // _searchQuery = searchQuery;
                context
                    .read<SearchQueryBloc>()
                    .add(SearchQueryTypingEvent(searchQuery));
              },
              onSubmitted: (String query) {
                context
                    .read<SearchQueryBloc>()
                    .add(SearchQuerySearchEvent());
              },
            ),
          ),
          BlocBuilder<SearchQueryBloc, SearchQueryState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case SearchQueryCmsInitialState:
                    return BlocBuilder<SearchPageCmsBloc, SearchPageCmsState>(
                      builder: (context, state) {
                        switch (state) {
                          case SearchPageCmsInitialState():
                          case SearchPageCmsLoadingState():
                            return const Center(
                                child: CircularProgressIndicator());
                          case SearchPageCmsLoadedState():
                            return BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                context
                                    .read<SearchPageCmsBloc>()
                                    .add(SearchPageCmsLoadEvent());
                              },
                              child: Expanded(
                                child: ListView(
                                  children:
                                  buildContentWidgets(state.pageWidgets),
                                ),
                              ),
                            );
                          case SearchPageCmsFailureState():
                            return const Center(
                                child: Text(LocalizationConstants
                                    .errorLoadingSearchLanding));
                          default:
                            return const Center(
                                child: Text(LocalizationConstants
                                    .errorLoadingSearchLanding));
                        }
                      },
                    );
                  case SearchQueryLoadingState:
                    return const Center(
                        child: CircularProgressIndicator());
                  case SearchQueryAutoCompleteInitialState:
                    return const Center(
                        child: Text(LocalizationConstants.searchPrompt));
                  case SearchQueryAutoCompleteLoadedState:
                    final autoCompleteResult = (state as SearchQueryAutoCompleteLoadedState).result!;
                    return AutoCompleteWidget(autocompleteResult: autoCompleteResult);
                  case SearchQueryAutoCompleteFailureState:
                    return const Center(
                        child: Text(LocalizationConstants.searchNoResults));
                  case SearchQueryProductsLoadedState:
                    final productCollectionResult = (state as SearchQueryProductsLoadedState).result!;
                    return SearchProductsWidget(productCollectionResult: productCollectionResult);
                  case SearchQueryProductsFailureState:
                    return const Center(
                        child: Text(LocalizationConstants.searchNoResults));
                  default:
                    return const Center(
                        child: Text(LocalizationConstants.errorLoadingSearchLanding));
                }
              }
          )
        ],
      ),
    );
  }
}
