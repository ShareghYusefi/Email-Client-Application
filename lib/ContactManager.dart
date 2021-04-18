//This class is Responsible for providing data to our contacts views through streams
import 'dart:async';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'package:flutter_email_client_app/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  // PublishSubject is a stream with extra methods
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  // This stream can subscribe and listen to contactListView stream
  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject = PublishSubject<List<Contact>>();

  // Sink is hole in application UI which takes in data like filter query being searched
  Sink<String> get inFilter => _filterSubject.sink;

  // Exposed values through streams
  Stream<int> get count$ => _countSubject.stream; // returning the data passed through the stream
  Stream<List<Contact>> get browse$ => _collectionSubject.stream;

  ContactManager() {
    // We listen to the _filterSubject stream data and react with a search query through contact service
    _filterSubject.stream.listen((filter) async {
      var contacts = await ContactService.browse(filter: filter);

      // push results into a collectionSubject stream
      _collectionSubject.add(contacts);
    });
    // Listen for contacts list & add a integer value based on its length to the countSubject Stream
    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }

}