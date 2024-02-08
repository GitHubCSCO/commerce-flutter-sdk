import 'package:commerce_flutter_app/features/presentation/helper/routing/navigation_node.dart';
import 'package:go_router/go_router.dart';

RouteBase generateRoutes(NavigationNode root) {
  if (root.isNavbarRoot) {
    return StatefulShellRoute.indexedStack(
      builder: root.statefulShellBuilder!,
      branches: root.children
          .map(generateRoutes)
          .map((e) => StatefulShellBranch(routes: [e]))
          .toList(),
    );
  }
  return GoRoute(
    name: root.name,
    path: root.suffix,
    builder: root.builder,
    routes: root.children.map(generateRoutes).toList(),
  );
}
