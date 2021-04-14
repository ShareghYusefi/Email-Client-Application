import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/App.dart';
import 'package:flutter_email_client_app/ContactManager.dart';
import 'package:flutter_email_client_app/Provider.dart';

void main() {
  runApp(EmailApp());
}

class EmailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Wrap Application with Provider with data
    return Provider(
      data: ContactManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.redAccent,
        ),
        home: App(),
      ),
    );
  }
}