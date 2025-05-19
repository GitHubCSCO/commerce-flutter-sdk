import 'package:flutter/material.dart';

extension Context on BuildContext {
  void closeKeyboard() => FocusScope.of(this).unfocus();
  void nextFocus() => FocusScope.of(this).nextFocus();
}
