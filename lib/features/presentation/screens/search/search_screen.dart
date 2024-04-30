import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/refresh/pull_to_refresh_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
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
      BlocProvider<PullToRefreshBloc>(
          create: (context) => sl<PullToRefreshBloc>()),
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<SearchPageCmsBloc>(
        create: (context) =>
        sl<SearchPageCmsBloc>()
          ..add(SearchPageCmsLoadEvent()),
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
                AssetConstants.iconClear,
                semanticsLabel: 'search query clear icon',
                fit: BoxFit.fitWidth,
              ),
              onPressed: () {
                textEditingController.clear();
                context.read<SearchBloc>().add(SearchTypingEvent(''));
                context.closeKeyboard();
              },
            ),
            onTapOutside: (p0) => context.closeKeyboard(),
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
          child: MultiBlocListener(
            listeners: [
              BlocListener<PullToRefreshBloc, PullToRefreshState>(
                listener: (context, state) {
                  if (state is PullToRefreshLoadState) {
                    _reloadSearchPage(context);
                  }
                },
              ),
              BlocListener<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    authCubitChangeTrigger(previous, current),
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
              BlocListener<SearchPageCmsBloc, SearchPageCmsState>(
                listener: (context, state) {
                  switch (state) {
                    case SearchPageCmsLoadingState():
                      context.read<CmsCubit>().loading();
                    case SearchPageCmsLoadedState():
                      context
                          .read<CmsCubit>()
                          .buildCMSWidgets(state.pageWidgets);
                    case SearchPageCmsFailureState():
                      context.read<CmsCubit>().failedLoading();
                  }
                },
              ),
            ],
            child:
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              switch (state.runtimeType) {
                case SearchCmsInitialState:
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<PullToRefreshBloc>(context)
                          .add(PullToRefreshInitialEvent());
                    },
                    child: BlocBuilder<CmsCubit, CmsState>(
                      builder: (context, state) {
                        switch (state) {
                          case CmsInitialState():
                          case CmsLoadingState():
                            return const Center(
                                child: CircularProgressIndicator());
                          case CmsLoadedState():
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
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children:
                                buildContentWidgets(state.widgetEntities),
                              ),
                            );
                          default:
                            return const CustomScrollView(
                              slivers: <Widget>[
                                SliverFillRemaining(
                                  child: Center(
                                    child: Text(LocalizationConstants
                                        .errorLoadingSearchLanding),
                                  ),
                                ),
                              ],
                            );
                        }
                      },
                    ),
                  );
                case SearchLoadingState:
                  return const Center(child: CircularProgressIndicator());
                case SearchAutoCompleteInitialState:
                  return Center(
                    child: Text(
                      LocalizationConstants.searchPrompt,
                      style: OptiTextStyles.body,
                    ),
                  );
                case SearchAutoCompleteLoadedState:
                  final autoCompleteResult =
                  (state as SearchAutoCompleteLoadedState).result!;
                  return AutoCompleteWidget(
                      autocompleteResult: autoCompleteResult);
                case SearchAutoCompleteFailureState:
                  return Center(
                      child: Text(
                        LocalizationConstants.searchNoResults,
                        style: OptiTextStyles.body,
                      ));
                case SearchProductsLoadedState:
                  final productCollectionResult =
                  (state as SearchProductsLoadedState).result!;
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<AddToCartCubit>(
                        create: (context) => sl<AddToCartCubit>(),
                      ),
                      BlocProvider(
                        create: (context) => sl<SearchProductsCubit>()..loadInitialSearchProducts(productCollectionResult),
                      ),
                    ],
                    child: SearchProductsWidget(
                      // productCollectionResult: productCollectionResult,
                      onPageChanged: (int) {},),
                  );
                case SearchProductsFailureState:
                  return Center(
                      child: Text(LocalizationConstants.searchNoResults,
                          style: OptiTextStyles.body));
                default:
                  return const Center(
                      child: Text(
                          LocalizationConstants.errorLoadingSearchLanding));
              }
            }),
          ),
        )
      ],
    );
  }
}
