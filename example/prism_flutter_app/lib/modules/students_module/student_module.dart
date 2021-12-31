import 'package:flutter/foundation.dart';
import 'package:prism_flutter/modules/module.dart';

class StudentModule extends Module {
  @override
  void init() {
    if (kDebugMode) {
      print("Students");
    }
  }

}