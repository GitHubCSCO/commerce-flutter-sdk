import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/themes/theme.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/root/root_bloc.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/svg_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class NavBarScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return NavBarPage(
      navigationShell: navigationShell,
    );
  }
}

class NavBarPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarPage({
    super.key,
    required this.navigationShell,
  });

  void _onTap(BuildContext context, int index) {
    if (index == 3) {
      context.read<CartCountCubit>().onSelectCartTab();
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootBloc, RootState>(
      listener: (context, state) {
        if (state is RootInitiateSearch) {
          int index = 1;
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
          context.read<RootBloc>().add(RootSearchProductEvent(state.query));
        }
      },
      child: Scaffold(
        backgroundColor: OptiAppColors.backgroundGray,
        bottomNavigationBar: BlocBuilder<CartCountCubit, CountState>(
          builder: (context, state) {
            return bottomNavigationBar(context, state.cartItemCount);
          },
        ),
        body: navigationShell,
      ),
    );
  }

  Container bottomNavigationBar(BuildContext context, int cartCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: _buildBottomNavigationBarItems(cartCount),
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(int cartCount) {
    return [
      _buildBottomNavigationBarItem(
        0,
        AssetConstants.shopIcon,
        AssetConstants.shopSelectedIcon,
        LocalizationConstants.shopTitle.localized(),
      ),
      _buildBottomNavigationBarItem(
        1,
        AssetConstants.searchIcon,
        AssetConstants.searchSelectedIcon,
        LocalizationConstants.searchLandingTitle.localized(),
      ),
      _buildBottomNavigationBarItem(
        2,
        AssetConstants.accountIcon,
        AssetConstants.accountSelectedIcon,
        LocalizationConstants.account.localized(),
      ),
      _buildBottomNavigationBarItem(
        3,
        AssetConstants.cartIcon,
        AssetConstants.cartSelectedIcon,
        LocalizationConstants.cart.localized(),
        cartCount,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    int index,
    String unselectedIconPath,
    String selectedIconPath,
    String label, [
    int cartCount = 0,
  ]) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: _getIcon(index, unselectedIconPath, selectedIconPath, cartCount),
      ),
      label: label,
    );
  }

  Widget _getIcon(int index, String unselectedIconPath, String selectedIconPath,
      [int cartCount = 0]) {
    Widget icon = navigationShell.currentIndex == index
        ? SvgAssetImage(
            assetName: selectedIconPath,
            fit: BoxFit.fitWidth,
          )
        : SvgAssetImage(
            assetName: unselectedIconPath,
            fit: BoxFit.fitWidth,
          );

    if (index == 3 && cartCount > 0) {
      return badges.Badge(
        position: badges.BadgePosition.topEnd(top: -30, end: -20),
        badgeStyle: const badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: Colors.black,
          padding: EdgeInsets.all(10),
          elevation: 0,
        ),
        badgeContent:
            Text(cartCount.toString(), style: OptiTextStyles.badgesStyle),
        child: icon,
      );
    } else {
      return icon;
    }
  }
}
