import 'package:flutter/widgets.dart';
import 'package:prism_flutter/modules/module_catalog.dart';

abstract class PrismBootstrapper {
  late ModuleCatalog _catalog;

  @protected
  ModuleCatalog createModuleCatalog();

  @protected
  void initModules(Object container) {
    for (var module in _catalog.modules) {
      module.init(container);
    }
  }

  @protected
  Object createContainer();

  @protected
  void configureContainer(Object container) {}

  void run() {
    _catalog = createModuleCatalog();
    final container = createContainer();
    configureContainer(container);
    initModules(container);
  }
}
