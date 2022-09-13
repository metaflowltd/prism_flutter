import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';
import 'package:prism_flutter_go_router/modules/go_router_module.dart';

abstract class GoRouterBootstrapper extends GetItBootstrapper {
  @override
  void run() {
    super.run();
    final routes = modules
        .whereType<GoRouterModule>()
        .expand(
          (module) => module.configureRoutes(),
        )
        .toList();
    final router = createRouter(routes);
    container.registerSingleton(router);
  }

  @protected
  GoRouter createRouter(List<GoRoute> routes) {
    return GoRouter(routes: routes);
  }
}
