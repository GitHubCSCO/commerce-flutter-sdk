import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/brand/brand_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/brand/brand_list/brand_list_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/brand/brand_auto_complete_widget.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandBloc>(
      create: (context) =>
      sl<BrandBloc>()
        ..add(BrandSectionLoadEvent()),
      child: BrandPage(),
    );
  }

}

class BrandPage extends StatelessWidget {

  final websitePath = WebsitePaths.brandsWebsitePath;
  final textEditingController = TextEditingController();

  BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            LocalizationConstants.brands, style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(websitePath: websitePath),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
                  context
                      .read<BrandBloc>()
                      .add(BrandSectionLoadEvent());
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              onChanged: (String searchQuery) {
                if (searchQuery.isEmpty) {
                  context
                      .read<BrandBloc>()
                      .add(BrandSectionLoadEvent());
                } else {
                  context.read<BrandBloc>().add(BrandAutoCompleteLoadEvent(searchQuery));
                }
              },
              textInputAction: TextInputAction.search,
              controller: textEditingController,
            ),
          ),
          BlocConsumer<BrandBloc, BrandState>(
            listener: (context, state) {
              if (state is BrandLoaded) {
                AppRoute.shopBrandDetails.navigateBackStack(context, extra: state.brand);
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

                  return SingleChildScrollView(
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        context.read<BrandBloc>().add(BrandToggleEvent(index));
                      },
                      children: list
                          .asMap()
                          .map((index, item) => MapEntry(
                        index,
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text((item.letter ?? '').toUpperCase()),
                            );
                          },
                          body: BlocProvider<BrandListCubit>(
                            create: (context) =>
                            sl<BrandListCubit>()..getBrands(item.letter ?? ''),
                            child: BrandListWidget(name: item.letter ?? ''),
                          ),
                          isExpanded: state.currentPanelIndex == index,
                          canTapOnHeader: true,
                        ),
                      ))
                          .values
                          .toList(),
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
                      child: Text(LocalizationConstants.noResultFoundMessage,
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

  void _handleAutoCompleteCallback(BuildContext context, AutocompleteBrand brand) {
    context.read<BrandBloc>().add(BrandLoadEvent(brand.id ?? ''));
  }

}

class BrandListWidget extends StatelessWidget {

  final String name;

  const BrandListWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandListCubit, BrandListState>(builder: (context, state) {
      switch (state) {
        case BrandListInitial():
        case BrandListLoading():
          return const Center(child: CircularProgressIndicator());
        case BrandListLoaded():
          final List<Brand> brandList = state.brandsResult?.brands ?? [];

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
                    AppRoute.shopBrandDetails.navigateBackStack(context, extra: brand);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      brand.name ?? '',
                      style: OptiTextStyles.body,
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