import 'package:get_it/get_it.dart';
import 'package:prism_flutter/modules/bootstrapper.dart';
import 'package:prism_flutter/regions/region_manager.dart';

abstract class GetItBootstrapper extends PrismBootstrapper {
  late GetIt _container;
   
  @override
  Object createContainer() {
    _container = GetIt.instance;
    return _container;
  }

  @override
  void configureContainer(Object container) {
    (container as GetIt).registerLazySingleton(() => RegionManager());
  }

  GetIt get container => _container;
}
