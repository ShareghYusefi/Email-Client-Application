import 'dart:async';
import 'package:flutter_email_client_app/Validation.dart';
import 'package:rxdart/rxdart.dart';

class MessageFormManager with Validation {
  final _email = BehaviorSubject<String>.seeded("@");

  // Transform _email stream to deliver the value if it meets our validation criteria or an error
  Stream<String> get email$ => _email.stream.transform(validateEmail);
  Sink<String> get inEmail => _email.sink;

}