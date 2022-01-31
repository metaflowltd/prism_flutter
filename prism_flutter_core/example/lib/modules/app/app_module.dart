import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_app/events/add_event.dart';
import 'package:prism_flutter_app/modules/app/views/add_button.dart';
import 'package:prism_flutter_getit/prism_flutter_getit.dart';

class AppModule extends GetItModule {
  @override
  void init(GetIt container) {
    final regionManager = container<RegionManager>();
    final eventAggregator = container<EventAggregator>();
    eventAggregator.register(AddEvent());
    regionManager.registerView(
        "action",
        RegionRegistration(
            metadata: RegionMetadata("add"),
            registration: () => AddButton(
                  eventAggregator: eventAggregator,
                )));
  }
}
