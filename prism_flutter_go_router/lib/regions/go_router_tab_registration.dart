import 'package:go_router/go_router.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';

class RegionRouterRegistration extends RegionRegistration<GoRoute> {
  RegionRouterRegistration({required RegionMetadata metadata, required GoRoute Function() registration})
      : super(metadata: metadata, registration: registration);
}
