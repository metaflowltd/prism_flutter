import 'package:flutter/widgets.dart';
import 'package:prism_flutter/pub_sub/event_aggregator.dart';
import 'package:prism_flutter/regions/region_manager.dart';
import 'package:prism_flutter_app/events/add_event.dart';
import 'package:prism_flutter_app/main.dart';

class Counter extends StatefulWidget {
  final String text;
  final EventAggregator eventAggregator;

  const Counter({Key? key, required this.text, required this.eventAggregator}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.eventAggregator.getEvent<AddEvent>()!.subscribe((value) {
      setState(() {
        _counter = value;
        if (_counter == 4)
          container<RegionManager>().unregisterView("main", "shalva");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("${widget.text} $_counter", style: const TextStyle(fontSize: 20));
  }
}
