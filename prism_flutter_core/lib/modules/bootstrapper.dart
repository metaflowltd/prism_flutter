import 'package:flutter/widgets.dart';
import 'package:prism_flutter_core/modules/module_catalog.dart';

abstract class PrismBootstrapper {
  @protected
  late ModuleCatalog catalog;

  @protected
  ModuleCatalog createModuleCatalog();

  @protected
  void initModules(Object container) {
    for (var module in catalog.modules) {
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
    initModules(container);
  }
}
