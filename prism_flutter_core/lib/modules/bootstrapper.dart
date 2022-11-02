import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';

abstract class PrismBootstrapper {
  @protected
  late ModuleCatalog catalog;

  @protected
  late List<Module> modules;

  @protected
  ModuleCatalog createModuleCatalog();

  @protected
  void createModules(Object container) {
    modules = catalog.moduleInfos.map((info) => info.factory(container)).toList();
  }

  @protected
  Future<void> initModules(Object container) async {
    for (var module in modules) {
      await module.init(container);
    }
  }

  @protected
  Object createContainer();

  @protected
  void configureContainer(Object container) {}

  @mustCallSuper
  Future<void> run() async {
    catalog = createModuleCatalog();
    final container = createContainer();
    configureContainer(container);
    createModules(container);
    await initModules(container);
  }
}
