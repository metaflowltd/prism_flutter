import 'package:flutter/material.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_app/events/add_event.dart';

class AddButton extends StatefulWidget {
  final EventAggregator eventAggregator;
  const AddButton({Key? key, required this.eventAggregator}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => widget.eventAggregator.getEvent<AddEvent>()!.publish(++_counter),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
