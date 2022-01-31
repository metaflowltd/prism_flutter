import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_app/modules/app/app_module.dart';
import 'package:prism_flutter_app/modules/counter_module/counter_module.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';

class Bootstrapper extends GetItBootstrapper {
  @override
  ModuleCatalog createModuleCatalog() {
    return MemoryModuleCatalog()
      ..addModule(ModuleInfo<GetIt>(AppModule().init))
      ..addModule(ModuleInfo<GetIt>(CounterModule().init));
  }
}
