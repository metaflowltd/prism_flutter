import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

abstract class ModuleRoute {
  bool get isRoot;

  GoRoute toGoRoute([GlobalKey<NavigatorState>? parentNavigatorKey]);
}
