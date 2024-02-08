import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationNode {
  final String name;
  final String fullPath;
  final Widget Function(BuildContext context, GoRouterState state)? builder;
  final NavigationNode? parent;
  final List<NavigationNode> children = [];
  final String? pathSuffix;
  final bool isNavbarRoot;
  final StatefulShellRouteBuilder? statefulShellBuilder;

  NavigationNode(
    this.name,
    this.fullPath,
    this.builder, {
    this.parent,
    this.isNavbarRoot = false,
    this.statefulShellBuilder,
    this.pathSuffix,
  });

  String get suffix {
    if (pathSuffix != null || parent == null) {
      return pathSuffix ?? fullPath;
    }

    final splittedList = fullPath.split('/')
      ..skipWhile((value) => value.isEmpty);

    return splittedList.last;
  }
}

NavigationNode createNode({
  required String name,
  required String path,
  required Widget Function(BuildContext context, GoRouterState state)? builder,
  NavigationNode? parent,
}) {
  final node = NavigationNode(name, path, builder, parent: parent);
  parent?.children.add(node);
  return node;
}

NavigationNode createNavbarRoot({
  required StatefulShellRouteBuilder statefulShellBuilder,
  required NavigationNode? parent,
}) {
  final node = NavigationNode(
    '',
    '',
    null,
    isNavbarRoot: true,
    statefulShellBuilder: statefulShellBuilder,
    parent: parent,
  );

  parent?.children.add(node);
  return node;
}
