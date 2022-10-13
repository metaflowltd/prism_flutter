import 'dart:async';

import 'package:rxdart/subjects.dart';

Type typeOf<T>() => T;

class EventAggregator {
  final Map<String, EventBase> _events = {};
  void register<T extends EventBase>(T event) => _events[event.runtimeType.toString()] = event;
  T? getEvent<T extends EventBase>() => _events[typeOf<T>().toString()] as T;
}

abstract class EventBase {}

class Event<T> extends EventBase {
  final Stream<T> _stream = PublishSubject<T>();
  void publish(T payload) => (_stream as PublishSubject<T>).add(payload);
  StreamSubscription<T> subscribe(void Function(T) action) => _stream.listen(action);
  Stream<T> subscribeOnStream() => _stream.asBroadcastStream();
}
