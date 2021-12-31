import 'package:flutter/widgets.dart';
import 'package:prism_flutter/modules/module_catalog.dart';

abstract class PrismBootstrapper {
  late ModuleCatalog _catalog;

  @protected
  ModuleCatalog createModuleCatalog();

  @protected
  void initModules() {
    for (var module in _catalog.modules) {
      module.init();
    }
  }

  @protected
  void createContainer() {}

  @protected
  void configureContainer() {}

  void run() {
    _catalog = createModuleCatalog();
    createContainer();
    initModules();
  }
}
