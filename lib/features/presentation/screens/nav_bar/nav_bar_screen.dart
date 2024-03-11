import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NavBarScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavBarScreen({
    super.key,
    required this.navigationShell,
  });

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      bottomNavigationBar: BottomNavagationBar(context),
      body: navigationShell,
    );
  }

  Container BottomNavagationBar(BuildContext context) {
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
        padding: const EdgeInsets.only(bottom: 5.0),
        child: _getIcon(index, unselectedIconPath, selectedIconPath),
      ),
      label: label,
    );
  }

  Widget _getIcon(
      int index, String unselectedIconPath, String selectedIconPath) {
    return navigationShell.currentIndex == index
        ? SvgPicture.asset(
            selectedIconPath,
            fit: BoxFit.fitWidth,
          )
        : SvgPicture.asset(
            unselectedIconPath,
            fit: BoxFit.fitWidth,
          );
  }
}
