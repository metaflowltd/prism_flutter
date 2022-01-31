import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_app/modules/counter_module/views/counter.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';

class CounterModule extends GetItModule {
  @override
  void init(GetIt container) {
    final regionManager = container<RegionManager>();
    final eventAggregator = container<EventAggregator>();

    regionManager.registerView(
        "main",
        RegionRegistration(
            metadata: MultiChildMetadata(key: "shalva", order: 2.0),
            registration: () => Counter(
                  text: "Shalva :",
                  eventAggregator: eventAggregator,
                )));
    regionManager.registerView(
        "main",
        RegionRegistration(
            metadata: MultiChildMetadata(key: "cats", order: 1.0),
            registration: () => Counter(
                  text: "Bad Cats: ",
                  eventAggregator: eventAggregator,
                )));
  }
}
