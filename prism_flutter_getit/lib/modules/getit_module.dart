import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';

abstract class GetItModule extends Module<GetIt> {
  @override
  void init(GetIt container);
}
