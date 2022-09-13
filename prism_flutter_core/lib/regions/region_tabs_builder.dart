import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prism_flutter_core/regions/region_manager.dart';

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
        _tabs = registrations?.map((registration) => registration.widgetFromRegistration()).toList();

        // Apple enforces that there should be at least 2 tabs
        final numberOfTabs = _tabs?.length ?? 0;
        if (numberOfTabs < 2) return const SizedBox.shrink();

        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: registrations
                    ?.map((registration) =>
                        BottomNavigationBarItem(label: registration.metadata.key, icon: const Icon(Icons.home)))
                    .toList() ??
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

class TabsRegionMetadata extends RegionMetadata {
  TabsRegionMetadata(String key) : super(key);
}
