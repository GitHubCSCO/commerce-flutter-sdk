import 'package:flutter/material.dart';

extension Context on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  void closeKeyboard() => FocusScope.of(this).unfocus();


}
