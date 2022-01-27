import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prism_flutter/regions/region_manager.dart';

class RegionBuilder extends StatelessWidget {
  final RegionManager regionManager;
  final String regionName;
  final Widget Function(dynamic child)? templateChild;
  final Widget Function(Widget child)? singleChild;
  final ListView Function(List<Widget> children)? multiChild;

  RegionBuilder({
    Key? key,
    required this.regionManager,
    required this.regionName,
    this.singleChild,
    this.multiChild,
    this.templateChild,
  }) : super(key: key) {
    assert(singleChild != null || multiChild != null, "Cannot provide both a singleChild and a multiChild");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: regionManager[regionName],
      builder: (BuildContext context, AsyncSnapshot<List<RegionRegistration>> snapshot) {
        if (singleChild != null) {
          return singleChildStrategy(singleChild!, snapshot.data);
        } else if (multiChild != null) {
          return multiChildStrategy(multiChild!, snapshot.data);
        }
        throw Exception("Cannot have a state without either a singleChild method or a multiChild");
      },
    );
  }

  Widget _getWidgetFromRegistration(RegionRegistration registration) {
    final child = registration.registration();
    return (child is Widget || templateChild == null) ? child as Widget : templateChild!(child);
  }

  @protected
  Widget singleChildStrategy(Widget Function(Widget child) singleChild, List<RegionRegistration>? data) {
    if (data == null || data.isEmpty) return const SizedBox.shrink();
    return singleChild(_getWidgetFromRegistration(data.last));
  }

  @protected
  Widget multiChildStrategy(ListView Function(List<Widget> children) multiChild, List<RegionRegistration>? data) {
    if (data == null || data.isEmpty) return const SizedBox.shrink();
    data.sort((a, b) {
      if (a.metadata is! MultiChildMetadata) return 0;
      if (b.metadata is! MultiChildMetadata) return 0;
      final first = a.metadata as MultiChildMetadata;
      final second = b.metadata as MultiChildMetadata;
      if (first.order == second.order) return 0;
      return (first.order < second.order) ? -1 : 1;
    });
    return multiChild(data.map((e) => _getWidgetFromRegistration(e)).toList());
  }
}

class MultiChildMetadata extends RegionMetadata {
  final double order;
  MultiChildMetadata({required String key, this.order = 1.0}) : super(key);
}
