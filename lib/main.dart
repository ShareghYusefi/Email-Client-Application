import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/App.dart';
import 'package:flutter_email_client_app/ContactManager.dart';
import 'package:flutter_email_client_app/Provider.dart';
import 'package:flutter_email_client_app/overseer.dart';

void main() {
  runApp(EmailApp());
}

class EmailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Wrap Application with Provider with Overseer for data management
    return Provider(
      data: Overseer(),
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