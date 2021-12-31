import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prism_flutter/regions/region_manager.dart';

class RegionBuilder extends StatefulWidget {
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
  _RegionBuilderState createState() => _RegionBuilderState();
}

class _RegionBuilderState extends State<RegionBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.regionManager[widget.regionName],
      builder: (BuildContext context, AsyncSnapshot<List<RegionRegistration>> snapshot) {
        if (widget.singleChild != null) {
          return singleChildStrategy(widget.singleChild!, snapshot.data);
        } else if (widget.multiChild != null) {
          return multiChildStrategy(widget.multiChild!, snapshot.data);
        }
        throw Exception("Cannot have a state without either a container or a list");
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

    return multiChild(data.map((e) => e.registration()).toList());
  }
}
