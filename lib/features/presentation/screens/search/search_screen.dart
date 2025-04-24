import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/cms/search_page_cms_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/search/search/search_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_history/search_history_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/helper/extra/delayer.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/error_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/search_product/search_products_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchScreen extends BaseStatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<SearchPageCmsBloc>(
        create: (context) =>
            sl<SearchPageCmsBloc>()..add(SearchPageCmsLoadEvent()),
      ),
      BlocProvider<SearchBloc>(
        create: (context) => sl<SearchBloc>(),
      ),
    ], child: SearchPage());
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameSearchLanding,
      );
}

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with BaseDynamicContentScreen {
  final textEditingController = TextEditingController();

  final _delayer = Delayer(milliseconds: 500);

  FocusNode autoFocusNode = FocusNode();
  bool autoFocus = false;

  @override
  void initState() {
    super.initState();

    final state = context.read<RootBloc>().state;
    if (state is RootSearchProduct) {
      context.read<SearchBloc>().add(SearchFieldPopulateEvent(state.query));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listener: (context, state) {
            if (state is RootConfigReload) {
              _reloadSearchPage(context);
            } else if (state is RootSearchProduct) {
              context
                  .read<SearchBloc>()
                  .add(SearchFieldPopulateEvent(state.query));
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
                context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
              case SearchPageCmsFailureState():
                context.read<CmsCubit>().failedLoading();
            }
          },
        ),
        BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is AutoCompleteCategoryState) {
              AppRoute.shopSubCategory.navigateBackStack(
                context,
                extra: state.category,
              );
            } else if (state is AutoCompleteBrandState) {
              AppRoute.shopBrandDetails.navigateBackStack(
                context,
                extra: state.brand,
              );
            } else if (state is AutoCompleteProductListState) {
              AppRoute.product
                  .navigateBackStack(context, extra: state.pageEntity);
            }
          },
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 36),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Input(
                    hintText: LocalizationConstants.search.localized(),
                    suffixIcon: IconButton(
                      icon: SvgAssetImage(
                        assetName: AssetConstants.iconClear,
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
                        context
                            .read<SearchBloc>()
                            .add(SearchFocusEvent(autoFocus: autoFocus));
                      } else {
                        context.read<SearchBloc>().add(SearchUnFocusEvent());
                      }
                    },
                    onChanged: (String searchQuery) {
                      _delayer.run(() {
                        context
                            .read<SearchBloc>()
                            .add(SearchTypingEvent(searchQuery));
                      });
                    },
                    onSubmitted: (String query) {
                      context
                          .read<SearchHistoryCubit>()
                          .addSearchHistory(query);
                      context.read<SearchBloc>().searchQuery = query;
                      context.read<SearchBloc>().add(SearchSearchEvent());
                    },
                    controller: textEditingController,
                    autoFocusNode: autoFocusNode,
                  ),
                ),
                IconButton(
                  icon: SvgAssetImage(
                    assetName: AssetConstants.iconBarcodeScan,
                    semanticsLabel: 'barcode scan icon',
                    fit: BoxFit.fitWidth,
                  ),
                  onPressed: () async {
                    final result = (await GoRouter.of(context)
                            .pushNamed(AppRoute.barcodeSearch.name) ??
                        '') as (String, BarcodeFormat);
                    if (!result.$1.isNullOrEmpty && context.mounted) {
                      await context
                          .read<SearchHistoryCubit>()
                          .addSearchHistory(result.$1);
                      context.read<SearchBloc>().searchQuery = result.$1;
                      context.read<SearchBloc>().barcodeFormat = result.$2;
                      context.read<SearchBloc>().add(SearchSearchEvent());

                      textEditingController.text = result.$1;
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (previous, current) =>
                    current is! AutoCompleteCategoryState ||
                    current is! AutoCompleteBrandState ||
                    current is! AutoCompleteProductListState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case SearchCmsInitialState:
                      return RefreshIndicator(
                        onRefresh: () async {
                          _reloadSearchPage(context);
                        },
                        child: BlocBuilder<CmsCubit, CmsState>(
                          builder: (context, state) {
                            switch (state) {
                              case CmsInitialState():
                              case CmsLoadingState():
                                return const Center(
                                    child: CircularProgressIndicator());
                              case CmsLoadedState():
                                {
                                  context
                                      .read<SearchHistoryCubit>()
                                      .getSearchHistory();
                                  return ListView(
                                    padding: EdgeInsets.zero,
                                    children: buildContentWidgets(
                                        state.widgetEntities),
                                  );
                                }
                              default:
                                return CustomScrollView(
                                  slivers: <Widget>[
                                    SliverFillRemaining(
                                        child: OptiErrorWidget(
                                      onRetry: () {
                                        _reloadSearchPage(context);
                                      },
                                      errorText: LocalizationConstants
                                          .errorLoadingSearchLanding
                                          .localized(),
                                    )),
                                  ],
                                );
                            }
                          },
                        ),
                      );
                    case SearchLoadingState:
                      {
                        return const Center(child: CircularProgressIndicator());
                      }
                    case SearchAutoCompleteInitialState:
                      {
                        return Center(
                          child: Text(
                            LocalizationConstants.searchPrompt.localized(),
                            style: OptiTextStyles.body,
                          ),
                        );
                      }
                    case SearchAutoCompleteLoadedState:
                      {
                        final autoCompleteResult =
                            (state as SearchAutoCompleteLoadedState).result;
                        return _buildSearchAutoComplete(autoCompleteResult);
                      }
                    case SearchAutoFocusResetState:
                      {
                        autoFocus = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                        return const Center(child: CircularProgressIndicator());
                      }
                    case SearchQueryLoadedState:
                      {
                        final autoSearchQuery =
                            (state as SearchQueryLoadedState).searchQuery ?? '';
                        textEditingController.clear();
                        textEditingController.text = autoSearchQuery;
                        autoFocus = true;
                        autoFocusNode.requestFocus();
                        context
                            .read<SearchHistoryCubit>()
                            .addSearchHistory(autoSearchQuery);
                        context.read<SearchBloc>().add(SearchSearchEvent());
                        return Center(
                          child: Text(
                            LocalizationConstants.searchPrompt.localized(),
                            style: OptiTextStyles.body,
                          ),
                        );
                      }
                    case SearchAutoCompleteFailureState:
                      {
                        return Center(
                            child: Text(
                          LocalizationConstants.searchNoResults.localized(),
                          style: OptiTextStyles.body,
                        ));
                      }
                    case SearchProductsLoadedState:
                      {
                        final productCollectionResult =
                            (state as SearchProductsLoadedState).result;
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<AddToCartCubit>(
                              create: (context) => sl<AddToCartCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => sl<SearchProductsCubit>()
                                ..initialSetup(ProductPageEntity(
                                    '', ProductParentType.search))
                                ..loadInitialSearchProducts(
                                    productCollectionResult),
                            ),
                          ],
                          child: SearchProductsWidget(
                            onPageChanged: (int) {},
                            productListType: ProductListType.searchProducts,
                          ),
                        );
                      }
                    case SearchProductsFailureState:
                      {
                        return Center(
                            child: Text(
                                LocalizationConstants.searchNoResults
                                    .localized(),
                                style: OptiTextStyles.body));
                      }
                    default:
                      {
                        return OptiErrorWidget(
                          onRetry: () {
                            _reloadSearchPage(context);
                          },
                          errorText: LocalizationConstants
                              .errorLoadingSearchLanding
                              .localized(),
                        );
                      }
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _buildSearchAutoComplete(AutocompleteResult? result) {
    final autoCompleteCategoryList = result?.categories;
    final autoCompleteBrandList = result?.brands;
    final autoCompleteProductList = result?.products;
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        if (autoCompleteCategoryList?.isNotEmpty ?? false) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Text(
              LocalizationConstants.categories.localized(),
              style: OptiTextStyles.titleSmall,
            ),
          ),
          CategoryAutoCompleteWidget(
            autocompleteCategories: autoCompleteCategoryList,
            callback: handleAutoCompleteCategoryCallback,
          ),
          const SizedBox(height: 12),
        ],
        if (autoCompleteBrandList?.isNotEmpty ?? false) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Text(
              LocalizationConstants.brands.localized(),
              style: OptiTextStyles.titleSmall,
            ),
          ),
          BrandAutoCompleteWidget(
            autocompleteBrands: autoCompleteBrandList,
            callback: handleAutoCompleteBrandCallback,
          ),
          const SizedBox(height: 12),
        ],
        if (autoCompleteProductList?.isNotEmpty ?? false)
          AutoCompleteWidget(
            callback: handleAutoCompleteCallback,
            autoCompleteProductList: autoCompleteProductList,
            isScrollableChild: false,
          ),
      ],
    );
  }

  void handleAutoCompleteCategoryCallback(
      BuildContext context, AutocompleteCategory category) {
    context.read<SearchBloc>().add(AutoCompleteCategoryEvent(category));
  }

  void handleAutoCompleteBrandCallback(
      BuildContext context, AutocompleteBrand brand) {
    context.read<SearchBloc>().add(AutoCompleteBrandEvent(brand));
  }

  void handleAutoCompleteCallback(
      BuildContext context, AutocompleteProduct product) {
    AppRoute.productDetails.navigateBackStack(context,
        pathParameters: {"productId": product.id.toString()},
        extra: ProductEntity());
  }

  void _reloadSearchPage(BuildContext context) {
    if (textEditingController.text.isNotEmpty) {
      textEditingController.clear();
      context.read<SearchBloc>().add(SearchCloseEvent());
    }
    context.read<SearchPageCmsBloc>().add(SearchPageCmsLoadEvent());
  }
}
