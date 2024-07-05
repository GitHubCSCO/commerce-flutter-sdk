import 'dart:async';
import 'package:flutter/material.dart';

class Delayer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Delayer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}