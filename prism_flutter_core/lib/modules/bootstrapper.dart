import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/modules/module_catalog.dart';
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
  void initModules(Object container) {
    for (var module in modules) {
      module.init(container);
    }
  }

  @protected
  Object createContainer();

  @protected
  void configureContainer(Object container) {}

  @mustCallSuper
  void run() {
    catalog = createModuleCatalog();
    final container = createContainer();
    configureContainer(container);
    createModules(container);
    initModules(container);
  }
}
