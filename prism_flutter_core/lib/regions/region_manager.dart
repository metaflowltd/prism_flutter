import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/regions/region_registration.dart';
import 'package:prism_flutter_core/regions/region_widget_registration.dart';
import 'package:rxdart/rxdart.dart';

class RegionManager {
  final Map<String, Stream<List<RegionRegistration>>> _regions = {};

  void registerView(String name, RegionRegistration registration) {
    if (!_regions.containsKey(name)) {
      _regions[name] = BehaviorSubject.seeded([]);
    }
    final subject = _regions[name] as BehaviorSubject<List<RegionRegistration>>;
    final isRegistered = subject.value.any((element) => element.metadata.key == registration.metadata.key);
    if (!isRegistered) {
      final newList = subject.value..add(registration);
      subject.add(newList);
    }
  }

  void unregisterView(String name, String viewKey) {
    if (!_regions.containsKey(name)) {
      _regions[name] = BehaviorSubject.seeded([]);
    }
    final subject = _regions[name] as BehaviorSubject<List<RegionRegistration>>;
    final registration = subject.value.firstWhereOrNull((element) => element.metadata.key == viewKey);
    if (registration != null) {
      final newList = subject.value..remove(registration);
      subject.add(newList);
    }
  }

  Stream<List<RegionRegistration>>? operator [](String name) => _regions[name];
}

extension RegionRegistrationExtensions on RegionRegistration {
  Widget? widgetFromRegistration([Widget Function(dynamic child)? templateChild]) {
    if (this is RegionWidgetRegistration) return registration() as Widget;
    final child = registration();
    if (child is! Widget && templateChild == null) return null;
    return (child is Widget || templateChild == null) ? child as Widget : templateChild(child);
  }
}

class RegionMetadata {
  final String key;

  RegionMetadata(this.key);
}
