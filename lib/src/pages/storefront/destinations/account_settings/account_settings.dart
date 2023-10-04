import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  final settingsItems = const [
    'Clear Cache',
    'Languages',
    'Admin Login',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: settingsItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: SizedBox(
                      width: double.infinity,
                      child: Text(settingsItems[index])),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const _UrlTextConsumer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 25, right: 25),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () => context.go('/connect_store'),
                        child: const Text('CHANGE DOMAIN'),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class LanguagesPages extends StatelessWidget {
  const LanguagesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Languages');
  }
}

class _UrlTextConsumer extends ConsumerWidget {
  const _UrlTextConsumer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String url = ClientConfig.hostUrl!;
    return Text('Current Domain: $url');
  }
}
