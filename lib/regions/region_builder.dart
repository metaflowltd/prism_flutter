import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prism_flutter/regions/region_manager.dart';

class RegionBuilder extends StatelessWidget {
  final RegionManager regionManager;
  final String regionName;
  final Widget Function(Widget child)? singleChild;
  final ListView Function(List<Widget> children)? multiChild;

  RegionBuilder({
    Key? key,
    required this.regionManager,
    required this.regionName,
    this.singleChild,
    this.multiChild,
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
    final last = data.last;
    return singleChild(last.registration());
  }

  @protected
  Widget multiChildStrategy(ListView Function(List<Widget> children) multiChild, List<RegionRegistration>? data) {
    if (data == null || data.isEmpty) return const SizedBox.shrink();
    data.sort((a, b) {
      if (a.metadata == null || a.metadata is! MultiChildMetadata) return 0;
      if (b.metadata == null || b.metadata is! MultiChildMetadata) return 0;
      final first = a.metadata as MultiChildMetadata;
      final second = b.metadata as MultiChildMetadata;
      if (first.order == second.order) return 0;
      return (first.order < second.order) ? -1 : 1;
    });
    return multiChild(data.map((e) => e.registration()).toList());
  }
}

class MultiChildMetadata extends RegionMetadata {
  final double order;
  MultiChildMetadata({this.order = 1.0});
}
