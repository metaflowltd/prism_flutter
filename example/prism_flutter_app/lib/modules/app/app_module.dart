import 'package:get_it/get_it.dart';
import 'package:prism_flutter/modules/module.dart';
import 'package:prism_flutter/pub_sub/event_aggregator.dart';
import 'package:prism_flutter/regions/region_manager.dart';
import 'package:prism_flutter_app/events/add_event.dart';
import 'package:prism_flutter_app/modules/app/views/add_button.dart';

class AppModule extends Module {
  @override
  void init(Object container) {
    final get = container as GetIt;
    final regionManager = get<RegionManager>();
    final eventAggregator = get<EventAggregator>();
    eventAggregator.register(AddEvent());
    regionManager.registerView(
        "action",
        RegionRegistration(
            registration: () => AddButton(
                  eventAggregator: eventAggregator,
                )));
  }
}
