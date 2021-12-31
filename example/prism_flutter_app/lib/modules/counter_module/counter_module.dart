import 'package:get_it/get_it.dart';
import 'package:prism_flutter/modules/module.dart';
import 'package:prism_flutter/pub_sub/event_aggregator.dart';
import 'package:prism_flutter/regions/region_manager.dart';
import 'package:prism_flutter_app/modules/counter_module/views/counter.dart';

class CounterModule extends Module {
  @override
  void init(Object container) {
    final get = container as GetIt;
    final regionManager = get<RegionManager>();
    final eventAggregator = get<EventAggregator>();

    regionManager.registerView(
        "main",
        RegionRegistration(
            registration: () => Counter(
                  text: "Shalva :",
                  eventAggregator: eventAggregator,
                )));
    regionManager.registerView(
        "main",
        RegionRegistration(
            registration: () => Counter(
                  text: "Bad Cats: ",
                  eventAggregator: eventAggregator,
                )));
  }
}
