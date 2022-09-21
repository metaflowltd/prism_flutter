import 'package:flutter/material.dart';
import 'package:prism_flutter_core/regions/region_manager.dart';
import 'package:prism_flutter_core/regions/region_registration.dart';

class RegionWidgetRegistration extends RegionRegistration<Widget> {
  RegionWidgetRegistration({
    required RegionMetadata metadata,
    required Widget Function(BuildContext) registration,
  }) : super(metadata: metadata, registration: registration);
}
