    Provides go_router implementation for Flutter.Prism.Core

## Description
Flutter.Prism.Core is an extensible library that allow you to build modular applications
Navigation is such a common requirement from any app that requires modular support.
This library allow for easy navigation while still keeping modules isolated and independent.

## Features

* Easy Go_router integration.
* Support for common "Tabs" apps.

## Getting started

Follow the instructions on building a Flutter app with Flutter.Prism.Core library as specified in it's [readme](https://github.com/metaflowltd/prism_flutter/blob/master/prism_flutter_core/README.md).

Now, changes need to be made:
    1. Inherit your bootstrapper from 'GoRouterBootstrapper'.
    2. Optionally use the 'GoRouterRegionTabsBuilder' to add tabs as regions.
## Usage


```dart
void main() async {
  final boostrapper = Bootstrapper();
  await boostrapper.run();
  runApp(child: const MyApp());
}
// T should be your dependency injection abstraction
class TestModule extends GetItModule {
    @override
    Future<void> init(GetIt container) {

    final regionManager = container<RegionManager>();
    regionManager.registerView(
        "main",
        RegionWidgetRegistration(
            metadata: MultiChildMetadata("welcome", order: 1),
            registration: (context) => const WelcomeWidget(),
        ),
      );
    }
}

class Bootstrapper extends GetItBootstrapper {
  @override
  ModuleCatalog createModuleCatalog() {
    final catalog = MemoryModuleCatalog();
    catalog.addModule(ModuleInfo((c) => TestModule()))
    return catalog;
  }
}

class MainWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RegionBuilder(
                regionManager: MyDI().instance.get<RegionManager>(),
                regionName: "main"
                multiChild: (children) => ListView(children: children),
              );
  }
}
```

## Additional information

More packages that enhance the usage or prism with common libraries such as GetIt and GoRouter will also be available.
We would love feedback, ping at twitter: @arielbh if you have any questions.

