import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';

abstract class GetItBootstrapper extends PrismBootstrapper {
  late GetIt _container;

  @override
  Object createContainer() {
    _container = GetIt.instance;
    return _container;
  }

  @override
  void configureContainer(Object container) {
    final get = (container as GetIt);
    get.registerLazySingleton(() => RegionManager());
    get.registerLazySingleton(() => EventAggregator());
  }

  GetIt get container => _container;
}
