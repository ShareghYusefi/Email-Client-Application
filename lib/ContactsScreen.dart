import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      drawer: AppDrawer(),
      body: Center(

        child: Text("Contacts"),
      ),
    );
  }
}
