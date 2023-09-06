import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';
import 'package:prism_flutter_go_router/interfaces/module_route.dart';
import 'package:prism_flutter_go_router/modules/go_router_module.dart';

abstract class GoRouterBootstrapper extends GetItBootstrapper {
  @override
  Future<void> run() async {
    await super.run();
    final routes = modules
        .whereType<GoRouterModuleMixin>()
        .expand(
          (module) => module.configureRoutes(),
        )
        .toList();
    final router = createRouter(routes);
    container.registerSingleton(router);
  }

  @protected
  GoRouter createRouter(List<ModuleRoute> routes, {String? initialLocation}) {
    return GoRouter(
      routes: routes.map((e) => e.toGoRoute()).toList(),
      initialLocation: initialLocation,
    );
  }
}
