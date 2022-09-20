import 'package:prism_flutter_getit/prism_flutter_getit.dart';
import 'package:prism_flutter_go_router/modules/module_route.dart';

abstract class GoRouterModule extends GetItModule {
  List<ModuleRoute> configureRoutes();
}
