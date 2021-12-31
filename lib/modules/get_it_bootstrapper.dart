import 'package:get_it/get_it.dart';
import 'package:prism_flutter/modules/bootstrapper.dart';

abstract class GetItBootstrapper extends PrismBootstrapper {
  late GetIt _container;
   
  @override
  void createContainer() {
    _container = GetIt.instance;
    super.createContainer();
  }

  GetIt get container => _container;
}
