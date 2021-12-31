import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:prism_flutter/modules/module.dart';
import 'package:prism_flutter/regions/region_manager.dart';
import 'package:prism_flutter_app/modules/students_module/views/student_name.dart';

class StudentModule extends Module {
  @override
  void init(Object container) {
    final get = container as GetIt;
    if (kDebugMode) {
      print("Students");
    }
    final regionManager = get<RegionManager>();
    regionManager.registerView("main", RegionRegistration(registration: () => const StudentName(name: "Ariel")));
    regionManager.registerView("main", RegionRegistration(registration: () => const StudentName(name: "Dina")));
  }
}
