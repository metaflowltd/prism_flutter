import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ModuleRoute {
  final bool isRoot;
  final String path;
  final GoRouterPageBuilder pageBuilder;
  final List<RouteBase> routes;

  ModuleRoute({
    this.isRoot = false,
    required this.path,
    required this.pageBuilder,
    this.routes = const [],
  });

  GoRoute toGoRoute([GlobalKey<NavigatorState>? parentNavigatorKey]) {
    return GoRoute(
      path: path,
      pageBuilder: pageBuilder,
      routes: routes,
      parentNavigatorKey: parentNavigatorKey,
    );
  }
}
