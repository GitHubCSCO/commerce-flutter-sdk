import 'dart:ui';
import 'package:commerce_flutter_app/features/presentation/helper/menu/menu_interface.dart';

class ToolMenu implements IMenu {
  ToolMenu({required this.title, required this.action});

  @override
  String title;

  @override
  VoidCallback action;
}
