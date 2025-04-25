import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:flutter/foundation.dart';

abstract class VMIPageState {
  const VMIPageState();
}

class VMIPageInitialState extends VMIPageState {}

class VMIPageLoadingState extends VMIPageState {}

class VMIPageLoadedState extends VMIPageState {
  final List<WidgetEntity> pageWidgets;

  VMIPageLoadedState({required this.pageWidgets});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is VMIPageLoadedState &&
        listEquals(other.pageWidgets, pageWidgets);
  }

  @override
  int get hashCode => pageWidgets.hashCode;
}

class VMIPageFailureState extends VMIPageState {
  final String error;

  VMIPageFailureState(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is VMIPageFailureState && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class VMILoacationLoadedState extends VMIPageState {}
