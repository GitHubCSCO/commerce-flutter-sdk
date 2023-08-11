import 'package:flutter/material.dart';

import 'package:commerce_flutter_app/src/pages/storefront/destinations/account_destination.dart';
import 'package:commerce_flutter_app/src/pages/storefront/destinations/cart_destination.dart';
import 'package:commerce_flutter_app/src/pages/storefront/destinations/shop_destination.dart';
import 'package:commerce_flutter_app/src/pages/storefront/destinations/search_destination.dart';

class StorefrontPage extends StatefulWidget {
  const StorefrontPage({super.key});

  @override
  State<StorefrontPage> createState() => _StorefrontPageState();
}

class _StorefrontPageState extends State<StorefrontPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _destinations = [
    const ShopDestination(),
    const SearchDestination(),
    AccountDestination(),
    const CartDestination(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _destinations[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onItemTapped,
          selectedIndex: _selectedIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(
                  (_selectedIndex == 0) ? Icons.sell : Icons.sell_outlined),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: Icon(
                  (_selectedIndex == 1) ? Icons.search : Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon((_selectedIndex == 2)
                  ? Icons.account_circle
                  : Icons.account_circle_outlined),
              label: 'Account',
            ),
            NavigationDestination(
              icon: Icon((_selectedIndex == 3)
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
          ]),
    );
  }
}
