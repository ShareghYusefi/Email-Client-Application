import 'package:rxdart/rxdart.dart';

class MessageFormManager {
  final _email = BehaviorSubject<String>.seeded("");

  Stream<String> get email$ => _email.stream;
  Sink<String> get inEmail => _email.sink;

  MessageFormManager() {
    _email.stream.listen((value) {
      print(value);
    });
  }

}