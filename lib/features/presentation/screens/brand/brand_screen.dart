import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/website_paths.dart';
import 'package:commerce_flutter_sdk/core/extensions/context.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/url_string_extensions.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/brand/brand_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/components/input.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/brand/brand_list/brand_list_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/brand/brand_auto_complete_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandScreen extends BaseStatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (context) => sl<BrandBloc>()..add(BrandSectionLoadEvent()),
      child: BrandPage(),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameBrands,
      );
}

class BrandPage extends StatelessWidget {
  final websitePath = WebsitePaths.brandsWebsitePath;
  final textEditingController = TextEditingController();

  BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.brands.localized(),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(websitePath: websitePath),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                  context.read<BrandBloc>().add(BrandSectionLoadEvent());
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              onChanged: (String searchQuery) {
                if (searchQuery.isEmpty) {
                  context.read<BrandBloc>().add(BrandSectionLoadEvent());
                } else {
                  context
                      .read<BrandBloc>()
                      .add(BrandAutoCompleteLoadEvent(searchQuery));
                }
              },
              textInputAction: TextInputAction.search,
              controller: textEditingController,
            ),
          ),
          BlocConsumer<BrandBloc, BrandState>(
            listener: (context, state) {
              if (state is BrandLoaded) {
                AppRoute.shopBrandDetails
                    .navigateBackStack(context, extra: state.brand);
              }
            },
            buildWhen: (previous, current) {
              return current is! BrandLoaded;
            },
            builder: (context, state) {
              switch (state) {
                case BrandLoading():
                  return const Center(child: CircularProgressIndicator());
                case BrandSectionLoaded():
                  final list = state.alphabetResult?.alphabet ?? [];

                  return Expanded(
                    child: SingleChildScrollView(
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          context
                              .read<BrandBloc>()
                              .add(BrandToggleEvent(index));
                        },
                        children: list
                            .asMap()
                            .map((index, item) => MapEntry(
                                  index,
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        title: Text(
                                            (item.letter ?? '').toUpperCase()),
                                      );
                                    },
                                    body: (state.currentPanelIndex == index)
                                        ? BlocProvider<BrandListCubit>(
                                            create: (context) =>
                                                sl<BrandListCubit>()
                                                  ..getBrands(
                                                      item.letter ?? ''),
                                            child: BrandListWidget(
                                                name: item.letter ?? ''),
                                          )
                                        : const Center(),
                                    isExpanded:
                                        state.currentPanelIndex == index,
                                    canTapOnHeader: true,
                                  ),
                                ))
                            .values
                            .toList(),
                      ),
                    ),
                  );
                case BrandSectionFailed():
                  return const Center(child: Text('Failed to load data'));
                case BrandAutoCompleteLoaded():
                  final autoCompleteBrandList = state.brandList;
                  return BrandAutoCompleteWidget(
                      autocompleteBrands: autoCompleteBrandList,
                      callback: _handleAutoCompleteCallback);
                case BrandAutoCompleteFailed():
                  return Center(
                      child: Text(
                          LocalizationConstants.noResultFoundMessage
                              .localized(),
                          style: OptiTextStyles.body));
                default:
                  return const Center();
              }
            },
          )
        ],
      ),
    );
  }

  void _handleAutoCompleteCallback(
      BuildContext context, AutocompleteBrand brand) {
    context.read<BrandBloc>().add(BrandLoadEvent(brand.id ?? ''));
  }
}

class BrandListWidget extends StatelessWidget {
  final String name;

  const BrandListWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandListCubit, BrandListState>(
        builder: (context, state) {
      switch (state) {
        case BrandListInitial():
        case BrandListLoading():
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        case BrandListLoaded():
          final brandList = state.brandsResult?.brands ?? [];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: brandList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final brand = brandList[index];
                return InkWell(
                  onTap: () {
                    AppRoute.shopBrandDetails
                        .navigateBackStack(context, extra: brand);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            brand.name ?? '',
                            style: OptiTextStyles.body,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: !brand.logoSmallImagePath.isNullOrEmpty
                                ? Image.network(
                                    (brand.logoSmallImagePath ?? '')
                                        .makeImageUrl(),
                                    fit: BoxFit.fitHeight,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      // This function is called when the image fails to load
                                      return Container(
                                        color: OptiAppColors
                                            .backgroundGray, // Placeholder color
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.image, // Icon to display
                                          color: Colors.grey, // Icon color
                                          size: 30, // Icon size
                                        ),
                                      );
                                    },
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        case BrandListFailed():
        default:
          return const Center();
      }
    });
  }
}
