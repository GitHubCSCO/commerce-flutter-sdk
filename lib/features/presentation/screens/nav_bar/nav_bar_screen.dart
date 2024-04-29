import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/cart_count/cart_count_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
    return BlocBuilder<CartCountCubit, CartCountState>(
        builder: (context, state) {
      return NavBarPage(
        navigationShell: navigationShell,
        cartCount: state
            .cartItemCount, // Pass the cartCount from the state to the NavBarPage.
      );
    });
  }
}

class NavBarPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  int cartCount;

  NavBarPage(
      {super.key, required this.navigationShell, required this.cartCount});

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
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
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      bottomNavigationBar: bottomNavigationBar(context),
      body: navigationShell,
    );
  }

  Container bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
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
        items: _buildBottomNavigationBarItems(),
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    return [
      _buildBottomNavigationBarItem(
        0,
        AssetConstants.shopIcon,
        AssetConstants.shopSelectedIcon,
        LocalizationConstants.shopTitle,
      ),
      _buildBottomNavigationBarItem(
        1,
        AssetConstants.searchIcon,
        AssetConstants.searchSelectedIcon,
        LocalizationConstants.searchLandingTitle,
      ),
      _buildBottomNavigationBarItem(
        2,
        AssetConstants.accountIcon,
        AssetConstants.accountSelectedIcon,
        LocalizationConstants.account,
      ),
      _buildBottomNavigationBarItem(
        3,
        AssetConstants.cartIcon,
        AssetConstants.cartSelectedIcon,
        LocalizationConstants.cart,
      ),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    int index,
    String unselectedIconPath,
    String selectedIconPath,
    String label,
  ) {
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
        ? SvgPicture.asset(
            selectedIconPath,
            fit: BoxFit.fitWidth,
          )
        : SvgPicture.asset(
            unselectedIconPath,
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
