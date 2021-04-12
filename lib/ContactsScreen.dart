import 'package:flutter/material.dart';
import 'package:flutter_email_client_app/AppDrawer.dart';
import 'package:flutter_email_client_app/ContactManager.dart';
import 'package:flutter_email_client_app/ContactSearchDelegate.dart';
import 'package:flutter_email_client_app/model/Contact.dart';

import 'ContactListBuilder.dart';

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
              stream: manager.contactCount,
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
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: ContactSearchDelegate(manager: manager)
                );
              },
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ContactListBuilder(
          stream: manager.contactListView,
          builder: (context, contacts) {
            return ListView.separated(
              itemCount: contacts.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                Contact _contact = contacts[index];
                return ListTile(
                  title: Text(_contact.name),
                  subtitle: Text(_contact.email),
                  leading: CircleAvatar(),
                );
              },
            );
          }
      )
      );
  }
}
