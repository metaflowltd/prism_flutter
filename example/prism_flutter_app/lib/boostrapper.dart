import 'package:prism_flutter/modules/get_it_bootstrapper.dart';
import 'package:prism_flutter/modules/module_catalog.dart';
import 'package:prism_flutter/modules/module_info.dart';
import 'package:prism_flutter_app/modules/students_module/student_module.dart';

class Bootstrapper extends GetItBootstrapper {
  @override
  ModuleCatalog createModuleCatalog() {
    return MemoryModuleCatalog()..addModule(ModuleInfo(StudentModule().init));
  }
}
