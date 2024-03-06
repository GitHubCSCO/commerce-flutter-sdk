import 'package:flutter/material.dart';

extension Context on BuildContext {
  void closeKeyboard() => FocusScope.of(this).unfocus();
}
