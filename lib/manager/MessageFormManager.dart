import 'dart:async';

import 'package:rxdart/rxdart.dart';

class MessageFormManager {
  final _email = BehaviorSubject<String>.seeded("@");

  // Transform _email stream to deliver the value if it meets our validation criteria or an error
  Stream<String> get email$ => _email.stream.transform(validateEmail);
  Sink<String> get inEmail => _email.sink;

  // Simple validation for email field, will replace with an elaborate library in future
  static bool isEmail(String email) => email.contains('@');

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      // handle data receive a value and pass to the provided sink
      handleData: (value, sink){
        if( isEmail(value)){
          sink.add(value);
        } else {
          sink.addError('Our message error');
        }
      });

}