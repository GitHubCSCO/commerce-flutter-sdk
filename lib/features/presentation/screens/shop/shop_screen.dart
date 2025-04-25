import 'package:commerce_flutter_sdk/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/app_route.dart';
import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/website_paths.dart';
import 'package:commerce_flutter_sdk/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/base/base_dynamic_content_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/cms/cms_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:commerce_flutter_sdk/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/bottom_menu_widget.dart';
import 'package:commerce_flutter_sdk/features/presentation/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _reloadShopPage(BuildContext context) {
  context.read<CartCountCubit>().loadCurrentCartCount();
  context.read<ShopPageBloc>().add(const ShopPageLoadEvent());
}

class ShopScreen extends BaseStatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CmsCubit>(create: (context) => sl<CmsCubit>()),
      BlocProvider<ShopPageBloc>(
        create: (context) => sl<ShopPageBloc>()..add(const ShopPageLoadEvent()),
      ),
    ], child: const ShopPage());
  }

  @override
  AnalyticsEvent getAnalyticsEvent() => AnalyticsEvent(
        AnalyticsConstants.eventViewScreen,
        AnalyticsConstants.screenNameShop,
      );
}

class ShopPage extends StatelessWidget with BaseDynamicContentScreen {
  final websitePath = WebsitePaths.shopWebsitePath;

  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(actions: <Widget>[
        BottomMenuWidget(
            screenName: AnalyticsConstants.screenNameShop,
            websitePath: websitePath),
      ], backgroundColor: Theme.of(context).colorScheme.surface),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RootBloc, RootState>(
            listener: (context, state) {
              if (state is RootConfigReload) {
                _reloadShopPage(context);
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                authCubitChangeTrigger(previous, current),
            listener: (context, state) {
              _reloadShopPage(context);
            },
          ),
          BlocListener<DomainCubit, DomainState>(
            listener: (context, state) {
              if (state is DomainLoaded) {
                _reloadShopPage(context);
              }
            },
          ),
          BlocListener<ShopPageBloc, ShopPageState>(
            listener: (context, state) {
              switch (state) {
                case ShopPageLoadingState():
                  context.read<CmsCubit>().loading();
                case ShopPageLoadedState():
                  context.read<CmsCubit>().buildCMSWidgets(state.pageWidgets);
                case ShopPageFailureState():
                  context.read<CmsCubit>().failedLoading();
              }
            },
          ),
          BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.read<AuthCubit>().loadAuthenticationState();
                if (state.isSignInRequired) {
                  AppRoute.landing.navigateBackStack(
                    context,
                    extra: state.domain != null,
                  );
                }
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () async {
            _reloadShopPage(context);
          },
          child: BlocBuilder<CmsCubit, CmsState>(
            builder: (context, state) {
              switch (state) {
                case CmsInitialState():
                case CmsLoadingState():
                  return const Center(child: CircularProgressIndicator());
                case CmsLoadedState():
                  return Scaffold(
                      backgroundColor: OptiAppColors.backgroundGray,
                      body: ListView(
                        children: buildContentWidgets(state.widgetEntities),
                      ));
                default:
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverFillRemaining(
                        child: OptiErrorWidget(
                            onRetry: () {
                              _reloadShopPage(context);
                            },
                            errorText: LocalizationConstants.errorLoadingShop
                                .localized()),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }

// List<ToolMenu> _getToolMenu(BuildContext context) {
//   List<ToolMenu> list = [];
//   list.add(ToolMenu(
//     title: "Setting",
//     action: () {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Sending Message"),
//       ));
//     }
//   ));
//   return list;
// }
}
