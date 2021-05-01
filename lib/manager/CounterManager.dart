import 'package:flutter_email_client_app/Manager.dart';
import 'package:rxdart/rxdart.dart';

class CounterManager implements Manager{
  // Create a counter sink
  BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);
  // Get the current value of sink
  int? get _current => _counter.value;

  // counter stream
  Stream<int> get counter$ => _counter.stream;

  void increment() => _counter.add( _current! + 1);
  void decrement() => _counter.add( _current! - 1);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}