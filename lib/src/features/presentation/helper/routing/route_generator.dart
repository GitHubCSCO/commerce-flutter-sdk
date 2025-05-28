import 'package:commerce_flutter_sdk/src/features/presentation/helper/routing/navigation_node.dart';
import 'package:go_router/go_router.dart';

RouteBase generateRoutes(NavigationNode root) {
  if (root.isNavbarRoot) {
    return StatefulShellRoute.indexedStack(
      builder: root.statefulShellBuilder!,
      parentNavigatorKey: root.navigatorKey,
      branches: root.children
          .map(generateRoutes)
          .map((e) => StatefulShellBranch(routes: [e]))
          .toList(),
    );
  }
  return GoRoute(
    name: root.name,
    path: root.path,
    builder: root.builder,
    parentNavigatorKey: root.navigatorKey,
    routes: root.children.map(generateRoutes).toList(),
  );
}
