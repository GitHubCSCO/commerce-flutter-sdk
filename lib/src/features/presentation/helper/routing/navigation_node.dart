import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationNode {
  final String name;
  final String path;
  final Widget Function(BuildContext context, GoRouterState state)? builder;
  final NavigationNode? parent;
  final List<NavigationNode> children = [];
  final bool isNavbarRoot;
  final StatefulShellRouteBuilder? statefulShellBuilder;
  final GlobalKey<NavigatorState>? navigatorKey;

  NavigationNode(
    this.name,
    this.path,
    this.builder, {
    this.parent,
    this.isNavbarRoot = false,
    this.statefulShellBuilder,
    this.navigatorKey,
  });
}

NavigationNode createNode({
  required String name,
  required String path,
  required Widget Function(BuildContext context, GoRouterState state)? builder,
  NavigationNode? parent,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  final node = NavigationNode(
    name,
    path,
    builder,
    parent: parent,
    navigatorKey: navigatorKey,
  );
  parent?.children.add(node);
  return node;
}

NavigationNode createNavbarRoot({
  required StatefulShellRouteBuilder statefulShellBuilder,
  required NavigationNode? parent,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  final node = NavigationNode(
    '',
    '',
    null,
    isNavbarRoot: true,
    statefulShellBuilder: statefulShellBuilder,
    parent: parent,
    navigatorKey: navigatorKey,
  );

  parent?.children.add(node);
  return node;
}

NavigationNode createSeparateRoute({
  required String name,
  required String path,
  required Widget Function(BuildContext context, GoRouterState state)? builder,
  required GlobalKey<NavigatorState>? navigatorKey,
  required NavigationNode? parent,
}) {
  return createNode(
    name: name,
    path: path,
    builder: builder,
    navigatorKey: navigatorKey,
    parent: parent,
  );
}
