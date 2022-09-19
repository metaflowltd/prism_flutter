import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/regions/region_manager.dart';
import 'package:prism_flutter_core/regions/region_registration.dart';

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

  @protected
  Widget singleChildStrategy(Widget Function(Widget child) singleChild, List<RegionRegistration>? data) {
    if (data == null || data.isEmpty) return const SizedBox.shrink();
    final widget = data.last.widgetFromRegistration(templateChild);
    if (widget == null) return const SizedBox.shrink();
    return singleChild(widget);
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
    return multiChild(data
        .map((e) => e.widgetFromRegistration(templateChild))
        .where((element) => element != null)
        .cast<Widget>()
        .toList());
  }
}

class MultiChildMetadata extends RegionMetadata {
  final double order;
  MultiChildMetadata({required String key, this.order = 1.0}) : super(key);
}
