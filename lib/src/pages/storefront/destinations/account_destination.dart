import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountDestination extends StatelessWidget {
  AccountDestination({super.key});

  final menuItemsList = [
    'Quick Order',
    'Location Finder',
    'Shop Brands',
    'Shop Categories en',
    'View Account on Website',
    'Settings'
  ];

  final List<IconData> menuIconsList = [
    Icons.touch_app,
    Icons.location_on_outlined,
    Icons.store_outlined,
    Icons.sell_outlined,
    Icons.explore_outlined,
    Icons.settings_outlined,
  ];

  final List<Function(BuildContext)> onTapFunctions = [
    (BuildContext context) {
      debugPrint('Index 0');
    },
    (BuildContext context) {
      debugPrint('Index 1');
    },
    (BuildContext context) {
      debugPrint('Index 2');
    },
    (BuildContext context) {
      debugPrint('Index 3');
    },
    (BuildContext context) {
      debugPrint('Index 4');
    },
    (BuildContext context) {
      debugPrint('Index 5');
      context.go('/storefront/account_settings');
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'To view previous orders, lists and other features, please sign in to your acount.'),
                      const SizedBox(
                        height: 12,
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(child: Text('SIGN IN')),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: _MenuItemsListView(
              menuItemsList: menuItemsList,
              menuIconsList: menuIconsList,
              onTapFunctions: onTapFunctions,
            )),
          ],
        ),
      ),
    );
  }
}

class _MenuItemsListView extends StatelessWidget {
  const _MenuItemsListView(
      {required this.menuItemsList,
      required this.menuIconsList,
      required this.onTapFunctions});

  final List<String> menuItemsList;
  final List<IconData> menuIconsList;
  final List<Function(BuildContext)> onTapFunctions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: menuItemsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onTapFunctions[index](context);
          },
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Row(
              children: [
                Icon(
                  menuIconsList[index],
                  color: index >= 4
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(menuItemsList[index]),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Divider(),
      ),
    );
  }
}
