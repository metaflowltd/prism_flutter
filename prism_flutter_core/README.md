    Provides infrastructure to develop modular flutter applications

## Features

* Bootstrapping a module app, modules definitions and initialization.
* Regions for injecting widgets in a loosely coupled fashion.
* Publisher-Subscriber service for loosely coupled async event publishing. 

## Getting started

Begin by introducing a bootstrapper to your app and implement your first module.
Each module should have a class that extends Module.
Once you have that module in place, you can create in the bootstrapper a catalog and add 
your modules to it.
In your main.dart you can initiate the boostrapper and call run.

## Usage


```dart
void main() async {
  final boostrapper = Bootstrapper();
  await boostrapper.run();
  runApp(child: const MyApp());
}
// T should be your dependency injection abstraction
class TestModule extends Module<MyDI> {
    @override
    Future<void> init(MyDI container) {

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

class Bootstrapper extends PrismBootstrapper {
  @override
  ModuleCatalog createModuleCatalog() {
    final catalog = MemoryModuleCatalog();
    catalog.addModule(ModuleInfo((c) => TestModule()))
    return catalog;
  }

  @override
  Object createContainer() => MyDI();
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

