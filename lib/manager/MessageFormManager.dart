import 'dart:async';
import 'package:flutter_email_client_app/Message.dart';
import 'package:flutter_email_client_app/Validation.dart';
import 'package:rxdart/rxdart.dart';

class MessageFormManager with Validation {
  final _email = BehaviorSubject<String>();
  // Transform _email stream to deliver the value if it meets our validation criteria or an error
  Stream<String> get email$ => _email.stream.transform(validateEmail);
  Sink<String> get inEmail => _email.sink;

  final _subject = BehaviorSubject<String>();
  Stream<String> get subject$ => _subject.stream.transform(validateSubject);
  Sink<String> get inSubject => _subject.sink;

  final _body = BehaviorSubject<String>();
  Stream<String> get body$ => _body.stream;
  Sink<String> get inBody => _body.sink;

  // If all three streams provide values instead of errors the form is valid
  // combineLatest only watches value, not errors
  Stream<bool> get isFormValid$ => Rx.combineLatest(
      // List of streams which return values or errors
      [email$, subject$, body$],
      // If all three streams emit a value, true will be emitted by this stream
      (values) => true
  );

  submit() {
    String subject  = _subject.value!;
    String body  = _body.value!;

    return Message(subject, body);
  }
}