import 'package:prism_flutter_core/prism_flutter_core.dart';

class ModuleInfo<T extends Module<C>, C> {
  final T Function(C container) factory;
  ModuleInfo(this.factory);
}
