import 'package:flutter/material.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/menu/menu_interface.dart';

class ToolMenu implements IMenu {
  ToolMenu({required this.title, required this.action, this.isUrl, this.url});

  @override
  String title;

  @override
  VoidCallback action;

  @override
  bool? isUrl;

  @override
  String? url;
}
