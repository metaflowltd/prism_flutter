import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';

class TabsRegionMetadata extends RegionMetadata {
  final Widget icon;
  final String? label;
  final Widget? activeIcon;
  final Color? backgroundColor;
  final String? tooltip;
  TabsRegionMetadata({
    required String key,
    required this.icon,
    this.label,
    this.activeIcon,
    this.backgroundColor,
    this.tooltip,
  }) : super(key);
}