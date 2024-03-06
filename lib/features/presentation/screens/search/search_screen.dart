import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

void _reloadSearchPage(BuildContext context) {
  context.read<SearchPageCmsBloc>().add(SearchPageCmsLoadEvent());
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SearchPageCmsBloc>(
        create: (context) =>
            sl<SearchPageCmsBloc>()..add(SearchPageCmsLoadEvent()),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => sl<SearchBloc>(),
      ),
    ], child: SearchPage());
  }
}

class SearchPage extends BaseDynamicContentScreen {
  SearchPage({super.key});

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Input(
            hintText: LocalizationConstants.search,
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                "assets/images/icon_clear.svg",
                semanticsLabel: 'search query clear icon',
                fit: BoxFit.fitWidth,
              ),
              onPressed: () {
                textEditingController.clear();
                context.read<SearchBloc>().add(SearchTypingEvent(''));
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            onTapOutside: (context) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            textInputAction: TextInputAction.search,
            focusListener: (bool hasFocus) {
              if (hasFocus) {
                context.read<SearchBloc>().add(SearchFocusEvent());
              } else {
                context.read<SearchBloc>().add(SearchUnFocusEvent());
              }
            },
            onChanged: (String searchQuery) {
              context.read<SearchBloc>().add(SearchTypingEvent(searchQuery));
            },
            onSubmitted: (String query) {
              context.read<SearchBloc>().add(SearchSearchEvent());
            },
            controller: textEditingController,
          ),
        ),
        Expanded(
          child:
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            switch (state.runtimeType) {
              case SearchCmsInitialState:
                return BlocBuilder<SearchPageCmsBloc, SearchPageCmsState>(
                  builder: (context, state) {
                    switch (state) {
                      case SearchPageCmsInitialState():
                      case SearchPageCmsLoadingState():
                        return const Center(child: CircularProgressIndicator());
                      case SearchPageCmsLoadedState():
                        return MultiBlocListener(
                          listeners: [
                            BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                _reloadSearchPage(context);
                              },
                            ),
                            BlocListener<DomainCubit, DomainState>(
                              listener: (context, state) {
                                if (state is DomainLoaded) {
                                  _reloadSearchPage(context);
                                }
                              },
                            ),
                          ],
                          child: Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: buildContentWidgets(state.pageWidgets),
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
              case SearchLoadingState:
                return const Center(child: CircularProgressIndicator());
              case SearchAutoCompleteInitialState:
                return const Center(
                    child: Text(LocalizationConstants.searchPrompt));
              case SearchAutoCompleteLoadedState:
                final autoCompleteResult =
                    (state as SearchAutoCompleteLoadedState).result!;
                return AutoCompleteWidget(
                    autocompleteResult: autoCompleteResult);
              case SearchAutoCompleteFailureState:
                return const Center(
                    child: Text(LocalizationConstants.searchNoResults));
              case SearchProductsLoadedState:
                final productCollectionResult =
                    (state as SearchProductsLoadedState).result!;
                return SearchProductsWidget(
                    productCollectionResult: productCollectionResult);
              case SearchProductsFailureState:
                return const Center(
                    child: Text(LocalizationConstants.searchNoResults));
              default:
                return const Center(
                    child:
                        Text(LocalizationConstants.errorLoadingSearchLanding));
            }
          }),
        )
      ],
    );
  }
}
