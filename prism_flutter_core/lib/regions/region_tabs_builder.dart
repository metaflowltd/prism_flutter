import 'package:flutter/cupertino.dart';
import 'package:prism_flutter_core/regions/region_manager.dart';
import 'package:prism_flutter_core/regions/region_registration.dart';
import 'package:prism_flutter_core/regions/region_tabs_metadata.dart';

class RegionTabsBuilder extends StatefulWidget {
  final RegionManager regionManager;
  final String regionName;
  const RegionTabsBuilder({
    Key? key,
    required this.regionManager,
    required this.regionName,
  }) : super(key: key);

  @override
  State<RegionTabsBuilder> createState() => _RegionTabsBuilderState();
}

class _RegionTabsBuilderState extends State<RegionTabsBuilder> {
  List<Widget>? _tabs;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.regionManager[widget.regionName],
      builder: (context, AsyncSnapshot<List<RegionRegistration>> snapshot) {
        final registrations = snapshot.data;
        _tabs = registrations
            ?.where((element) => element.metadata is TabsRegionMetadata)
            .map((registration) => registration.widgetFromRegistration())
            .where((element) => element != null)
            .cast<Widget>()
            .toList();

        // Apple enforces that there should be at least 2 tabs
        final numberOfTabs = _tabs?.length ?? 0;
        if (numberOfTabs < 2) return const SizedBox.shrink();

        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
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
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs?.isNotEmpty == true ? _tabs![index] : const SizedBox.shrink();
          },
        );
      },
    );
  }
}
