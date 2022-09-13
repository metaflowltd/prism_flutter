import 'package:prism_flutter_core/modules/module_info.dart';

abstract class ModuleCatalog {
  final List<ModuleInfo> moduleInfos = [];
}

class MemoryModuleCatalog extends ModuleCatalog {
  void addModule(ModuleInfo info) => moduleInfos.add(info);
}
