import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:commerce_flutter_app/features/presentation/components/multiple_selection_option_chip.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_list_filter/product_list_filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchProductFilterWidget extends StatelessWidget {
  final ProductListType productListType;
  const SearchProductFilterWidget(BuildContext context,
      {super.key, required this.productListType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductListFilterCubit>(),
      child: Builder(builder: (context) {
        return badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 0),
          badgeStyle: const badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: Colors.black,
            padding: EdgeInsets.all(6),
            elevation: 0,
          ),
          showBadge: true,
          badgeContent: Text(
            '0',
            style: OptiTextStyles.badgesStyle,
          ),
          child: IconButton(
            padding: const EdgeInsets.all(10),
            onPressed: () {
              _showProductFilterWidget(
                context,
                productListType: productListType,
              );
            },
            icon: SvgPicture.asset(
              height: 20,
              width: 20,
              AssetConstants.filterIcon,
              semanticsLabel: 'filter icon',
              fit: BoxFit.fitWidth,
            ),
          ),
        );
      }),
    );
  }
}

void _showProductFilterWidget(
  BuildContext context, {
  required ProductListType productListType,
}) {
  context.read<ProductListFilterCubit>().initialize(
        productListType: productListType,
      );
  showFilterModalSheet(
    context,
    onApply: () {},
    onReset: () {},
    child: BlocProvider.value(
      value: BlocProvider.of<ProductListFilterCubit>(context),
      child: BlocBuilder<ProductListFilterCubit, ProductListFilterState>(
        builder: (context, state) {
          if (state.status == ProductListFilterStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == ProductListFilterStatus.failure) {
            return const Center(
              child: Text('Failed to load filters'),
            );
          } else {
            for (var filter in state.filterValues) {
              print(filter.title);
              print('---');
              for (var value in filter.values) {
                print(value.title);
              }
              print('###');
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.filterValues
                  .map(
                    (e) => MultipleSelectionOptionChip<FilterValueViewModel>(
                      values: e.values,
                      chipTitle: e.title,
                      selectedValues: const <FilterValueViewModel>{},
                      onSelectionChanged: (FilterValueViewModel? v) {
                        print(v?.title);
                      },
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    ),
  );
}
