import 'package:go_router/go_router.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';

abstract class GoRouterModule extends GetItModule {
  List<GoRoute> configureRoutes();
}
