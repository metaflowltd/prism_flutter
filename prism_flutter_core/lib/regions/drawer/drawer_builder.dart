import "package:collection/collection.dart";
import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/regions/region_builder.dart';
import 'package:prism_flutter_core/regions/region_registration.dart';

enum DrawerLocation {
  top,
  bottom,
  content,
}

class DrawerMetadata extends MultiChildMetadata {
  final DrawerLocation location;

  DrawerMetadata(
    String key, {
    required this.location,
    super.order = 1.0,
  }) : super(key);
}

class DrawerBuilder extends RegionBuilder {
  final Widget Function(BuildContext context)? separator;
  DrawerBuilder({
    super.key,
    required super.regionManager,
    required super.regionName,
    this.separator,
  }) : super(
            multiChild: (children) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: regionManager[regionName],
      builder: (BuildContext context, AsyncSnapshot<List<RegionRegistration>> snapshot) {
        return multiChildStrategy(context, multiChild!, snapshot.data, separator: separator);
      },
    );
  }

  @override
  Widget multiChildStrategy(
    BuildContext context,
    Widget Function(List<Widget> children) multiChild,
    List<RegionRegistration>? data, {
    Widget Function(BuildContext context)? separator,
  }) {
    if (data == null || data.isEmpty) return const SizedBox.shrink();

    final groups = groupBy(
        data.where((data) => data.metadata is DrawerMetadata), (data) => (data.metadata as DrawerMetadata).location);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (groups.containsKey(DrawerLocation.top)) ...[
            super.multiChildStrategy(context, multiChild, groups[DrawerLocation.top]),
            if (separator != null) separator(context),
          ],
          Expanded(
              child: (groups.containsKey(DrawerLocation.content))
                  ? super.multiChildStrategy(context, multiChild, groups[DrawerLocation.content])
                  : const SizedBox.shrink()),
          if (groups.containsKey(DrawerLocation.bottom)) ...[
            if (separator != null) separator(context),
            super.multiChildStrategy(context, multiChild, groups[DrawerLocation.bottom]),
          ]
        ],
      ),
    );
  }
}
