//This class is Responsible for providing data to our contacts views through streams
import 'dart:async';

List<String> CONTACTS = ['User 1', 'User 2', 'User 3', 'User 4'];

class ContactManager {

  // By marking a function as async* we are able to use the yield keyword and create/return a Stream of data
  Stream<List<String>> get contactListNow async* {
    for (var i = 0; i < CONTACTS.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield CONTACTS.sublist(0, i + 1); // return a list greater than or equal to 0 & less than i+1
    }
  }

  // This stream can subscribe and listen to contactListNow stream
  final StreamController<int> _contactCounter = StreamController<int>();
  Stream<int> get contactCounter => _contactCounter.stream; // returning the data passed through the stream
  
  ContactManager() {
    // Listen for list of strings
    contactListNow.listen((list) {
      _contactCounter.add(list.length); // Adding a integer value to the streamController
    });
  }



}