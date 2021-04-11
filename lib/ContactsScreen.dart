import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';
import 'package:flutter_email_client_app/ContactManager.dart';

class ContactsScreen extends StatelessWidget {
  ContactManager manager = ContactManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        actions: [
          Chip(
            label: StreamBuilder<int>(
              stream: manager.contactCounter,
              builder: (context, snapshot) {
                return Text((snapshot.data ?? 0).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                );
              }
            ),
            backgroundColor: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<List<String>>(
        stream: manager.contactListNow,
        // Snapshot is the data being yielded by stream
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<String> contacts = snapshot.data;

          return ListView.separated(
            itemCount: contacts.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(contacts[index]),
              );
            },
          );
        },
        ),
      );
  }
}
