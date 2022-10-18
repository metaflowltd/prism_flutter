import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_go_router/interfaces/tabs_route.dart';

class RegionRouterRegistration extends RegionRegistration<TabsRoute> {
  RegionRouterRegistration({required RegionMetadata metadata, required TabsRoute Function(BuildContext) registration})
      : super(metadata: metadata, registration: registration);
}
