import 'package:rxdart/rxdart.dart';

class CounterManager {
  // Create a counter sink
  BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);
  // Get the current value of sink
  int? get _current => _counter.value;

  // counter stream
  Stream<int> get counter$ => _counter.stream;

  void increment() => _counter.add( _current! + 1);
  void decrement() => _counter.add( _current! - 1);
}