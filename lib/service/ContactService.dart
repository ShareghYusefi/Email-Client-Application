// This class serves as service layer for contacts - connecting with external database & API
import 'dart:convert';
import 'package:flutter_email_client_app/model/Contact.dart';
import 'package:http/http.dart' as http;


class ContactService {
  static String _url = "https://jsonplaceholder.typicode.com/users";
  static Future<List<Contact>> browse({query}) async {

    http.Response response = await http.get(Uri.parse(_url));

    await Future.delayed(Duration(seconds: 1));

    String content = response.body;
    // Take json string data and turn into a collection of Map data set
    List collection = json.decode(content);
    // Transform from collection of Map data set to a list of Message Objects
    Iterable<Contact> _contacts = collection.map((json) => Contact.fromJson(json));

    // since query is an optional parameter
    // query is null when no value is passed & empty when an empty string is passed in search
    if (query != null && query.isNotEmpty) {
      _contacts = _contacts.where(
              (contact) => contact.name.toLowerCase().contains(query)
      );
    }

    return _contacts.toList();
  }
}