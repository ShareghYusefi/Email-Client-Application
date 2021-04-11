//This class is Responsible for providing data to our contacts views through streams
import 'dart:async';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'package:flutter_email_client_app/service/ContactService.dart';

class ContactManager {
  // This stream can subscribe and listen to contactListView stream
  // ignore: close_sinks
  final StreamController<int> _contactCount = StreamController<int>();
  Stream<int> get contactCount => _contactCount.stream; // returning the data passed through the stream

  // By marking a function as async* we are able to use the yield keyword and create/return a Stream of data
  Stream<List<Contact>> get contactListView async* {
      yield await ContactService.browse();
    }

  ContactManager() {
    // Listen for list of strings & add a integer value to the streamController
    contactListView.listen((list) => _contactCount.add(list.length));
  }

}