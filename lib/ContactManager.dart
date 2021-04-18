//This class is Responsible for providing data to our contacts views through streams
import 'dart:async';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'package:flutter_email_client_app/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  // This stream can subscribe and listen to contactListView stream
  final BehaviorSubject<int> _contactCount = BehaviorSubject<int>();

  Stream<int> get count$ => _contactCount.stream; // returning the data passed through the stream
  // return a stream from a method that returns a Future
  Stream<List<Contact>> browse$({String? query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  ContactManager() {
    // Listen for list of strings & add a integer value to the streamController
    browse$().listen((list) => _contactCount.add(list.length));
  }

  void dispose() {
    _contactCount.close();
  }

}