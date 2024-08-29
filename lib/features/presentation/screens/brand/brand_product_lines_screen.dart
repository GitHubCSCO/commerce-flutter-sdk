import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/mixins/list_grid_view_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/brand/brand_product_line/brand_product_line_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_grid_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/category/category_list_widget.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/bottom_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandProductLinesScreen extends BaseStatelessWidget {
  final Brand brand;

  BrandProductLinesScreen({super.key, required this.brand});

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider<BrandProductLinesCubit>(
      create: (context) =>
          sl<BrandProductLinesCubit>()..getBrandProductLines(brand),
      child: BrandProductLinesPage(brand: brand),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameBrandProductLine,
      )
          .withProperty(
              name: AnalyticsConstants.eventPropertyBrandId, strValue: brand.id)
          .withProperty(
              name: AnalyticsConstants.eventPropertyBrandName,
              strValue: brand.name);
}

class BrandProductLinesPage extends StatefulWidget {
  final Brand brand;

  BrandProductLinesPage({super.key, required this.brand});

  @override
  State<BrandProductLinesPage> createState() => _BrandProductLinesPageState();
}

class _BrandProductLinesPageState extends State<BrandProductLinesPage>
    with ListGridViewMenuMixIn {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationConstants.allBrandProductLines.localized(),
            style: OptiTextStyles.titleLarge),
        actions: [
          BottomMenuWidget(
              isViewOnWebsiteEnable: false, toolMenuList: getToolMenu(context)),
        ],
      ),
      body: BlocBuilder<BrandProductLinesCubit, BrandProductLinesState>(
        builder: (context, state) {
          switch (state) {
            case BrandProductLinesInitial():
            case BrandProductLinesLoading():
              return const Center(child: CircularProgressIndicator());
            case BrandProductLinesLoaded():
              return Container(
                child: isGridView
                    ? CategoryGridWidget(
                        list: state.list,
                        callback: (ctxt, item) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandProductLine: item);
                        })
                    : CategoryListWidget(
                        list: state.list,
                        callback: (ctxt, item) async {
                          await _handleCategoryClick(ctxt, widget.brand,
                              brandProductLine: item);
                        }),
              );
            case BrandProductLinesFailed():
            default:
              return const Center();
          }
        },
      ),
    );
  }

  //! TODO need to fix it. This is anti pattern
  //! ProductPageEntity does not have toJson or fromJson which is needed
  //! for serialization and deserialization
  //! there is a possibility of these extra getting lost and gorouter
  //! has no way of retrieving them
  Future<void> _handleCategoryClick(BuildContext context, Brand brand,
      {BrandProductLine? brandProductLine}) async {
    final productPageEntity = ProductPageEntity(
      '',
      ProductParentType.brandProductLine,
      brandProductLine: brandProductLine,
      brandEntityId: brand.id,
      pageTitle: brandProductLine?.name,
    );
    AppRoute.product.navigateBackStack(context, extra: productPageEntity);
  }
}
