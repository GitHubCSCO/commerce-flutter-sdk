import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/website_paths.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/brand/brand_list/brand_list_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/brand/brand_section/brand_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrandCubit>(
      create: (context) =>
      sl<BrandCubit>()
        ..getBrandAlphabet(),
      child: BrandPage(),
    );
  }

}

class BrandPage extends StatelessWidget {

  final websitePath = WebsitePaths.brandsWebsitePath;

  const BrandPage({super.key});

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
      body: BlocBuilder<BrandCubit, BrandState>(
        builder: (context, state) {
          if (state is BrandLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BrandLoaded) {
            final list = state.alphabetResult?.alphabet ?? [];

            return SingleChildScrollView(
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  context.read<BrandCubit>().togglePanel(index);
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
          } else if (state is BrandFailed) {
            return const Center(child: Text('Failed to load data'));
          } else {
            return const Center();
          }
        },
      ),
    );
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