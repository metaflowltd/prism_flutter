import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class RegionManager {
  final Map<String, Stream<List<RegionRegistration>>> _regions = {};

  void registerView(String name, RegionRegistration registration) {
    if (!_regions.containsKey(name)) {
      _regions[name] = BehaviorSubject.seeded([]);
    }
    final subject = _regions[name] as BehaviorSubject<List<RegionRegistration>>;
    final newList = subject.value..add(registration);
    subject.add(newList);
  }

  Stream<List<RegionRegistration>>? operator [](String name) => _regions[name];
}

class RegionRegistration {
  final RegionMetadata? metadata;
  final Widget Function() registration;

  RegionRegistration({
    this.metadata,
    required this.registration,
  });
}

abstract class RegionMetadata {}
