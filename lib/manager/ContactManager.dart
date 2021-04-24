//This class is Responsible for providing data to our contacts views through streams
import 'dart:async';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'package:flutter_email_client_app/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  // PublishSubject is a streamController which can be subscribed to many times over instead of once
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  // BehaviorSubject is a streamController which has memory of the last seen value which removes waiting state in an application
  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject = PublishSubject<List<Contact>>();

  // Sink is hole in application UI which takes in data like filter query being searched
  Sink<String> get inFilter => _filterSubject.sink;

  // Exposed values through streams
  Stream<int> get count$ => _countSubject.stream; // returning the data passed through the stream
  Stream<List<Contact>> get browse$ => _collectionSubject.stream;

  ContactManager() {
    // We listen to the _filterSubject stream data and react with a search query through contact service
    _filterSubject.debounceTime(Duration(milliseconds: 500))
        // The switchMap maps the search queries and begin executing requests to server and disregards all requests but the last one
        .switchMap((filter) async* {
          yield await ContactService.browse(filter: filter);
        })
        .listen((contacts) async {
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