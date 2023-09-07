import 'package:prism_flutter_core/modules/module.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';
import 'package:prism_flutter_go_router/interfaces/module_route.dart';

mixin GoRouterModuleMixin<T> on Module<T> {
  List<ModuleRoute> configureRoutes();
}

abstract class GoRouterModule extends GetItModule with GoRouterModuleMixin {}
