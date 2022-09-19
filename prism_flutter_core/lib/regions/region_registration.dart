import 'package:prism_flutter_core/regions/region_manager.dart';

class RegionRegistration<T> {
  final RegionMetadata metadata;
  final T Function() registration;

  RegionRegistration({
    required this.metadata,
    required this.registration,
  });
}