import 'package:prism_flutter_core/modules/module_info.dart';

abstract class ModuleCatalog {
  final List<ModuleInfo> modules = [];
}

class MemoryModuleCatalog extends ModuleCatalog {
  void addModule(ModuleInfo info) => modules.add(info);
}
