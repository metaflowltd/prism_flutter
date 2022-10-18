import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_go_router/interfaces/tabs_route.dart';

class GoRouterRegionTabsBuilder extends StatefulWidget {
  final RegionManager regionManager;
  final String regionName;
  final Widget child;

  const GoRouterRegionTabsBuilder({
    Key? key,
    required this.child,
    required this.regionManager,
    required this.regionName,
  }) : super(key: key);

  @override
  State<GoRouterRegionTabsBuilder> createState() => _GoRouterRegionTabsBuilderState();
}

class _GoRouterRegionTabsBuilderState extends State<GoRouterRegionTabsBuilder> {
  List<TabsRoute>? _rootRoutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: StreamBuilder(
          stream: widget.regionManager[widget.regionName],
          builder: (context, snapshot) {
            final registrations = snapshot.data;
            _rootRoutes = registrations
                ?.where((element) => element.metadata is TabsRegionMetadata)
                .map((registration) => registration.registration(context))
                .cast<TabsRoute>()
                .toList();

            // Apple enforces that there should be at least 2 tabs
            final numberOfTabs = registrations?.length ?? 0;
            if (numberOfTabs < 2) return const SizedBox.shrink();
            return BottomNavigationBar(
              items: registrations?.map((registration) {
                    final metadata = registration.metadata as TabsRegionMetadata;
                    return BottomNavigationBarItem(
                      label: metadata.label ?? metadata.key,
                      icon: metadata.icon,
                      activeIcon: metadata.activeIcon,
                      backgroundColor: metadata.backgroundColor,
                      tooltip: metadata.tooltip,
                    );
                  }).toList() ??
                  [],
              currentIndex: _calculateSelectedIndex(context),
              onTap: (int idx) => _onItemTapped(idx, context),
            );
          }),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    return max(0, _rootRoutes!.indexWhere((element) => element.isTabLocation(location)));
  }

  void _onItemTapped(int index, BuildContext context) {
    final route = _rootRoutes![index];
    route.goToTab(context);
  }
}
