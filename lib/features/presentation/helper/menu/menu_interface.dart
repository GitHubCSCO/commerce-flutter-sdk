import 'dart:ui';

abstract class IMenu {
  late String title;
  late VoidCallback action;
  bool? isUrl;
  String? url;
}
