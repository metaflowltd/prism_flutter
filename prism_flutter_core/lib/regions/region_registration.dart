import 'package:flutter/material.dart';
import 'package:prism_flutter_core/regions/region_manager.dart';

class RegionRegistration<T> {
  final RegionMetadata metadata;
  final T Function(BuildContext) registration;

  RegionRegistration({
    required this.metadata,
    required this.registration,
  });
}